import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:repository_riverpod_mvvm/domain/models/post.dart';
import 'package:repository_riverpod_mvvm/infrastructure/dtos/post_document.dart';
import 'package:repository_riverpod_mvvm/infrastructure/repositories/post_repository.dart';
import 'package:repository_riverpod_mvvm/utils/convert_utils.dart';

/// Firestoreのインスタンスを保持するプロバイダ
final firebaseFirestoreProvider = Provider((_) => FirebaseFirestore.instance);

/// 投稿一覧StreamProvider
final StreamProvider<List<Post>> postListStreamProvider =
    StreamProvider<List<Post>>((ref) {
  return ref.watch(postsCollectionRefProvider).snapshots().map((snapshot) {
    final list = snapshot.docs.map((doc) {
      final jsonObject = PostDocument.fromJson(doc.data());
      return ConvertUtils.instance.toPost(postDoc: jsonObject, id: doc.id);
    }).toList();
    return list;
  });
});
