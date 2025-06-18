import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:post_comments_using_localdb/features/post/model/create_post_model.dart';
import 'package:post_comments_using_localdb/features/post/model/post_model.dart';
import 'package:post_comments_using_localdb/features/post/service/local_database_service.dart';

class PostViewModel extends ChangeNotifier {
  LocalDatabaseService service = LocalDatabaseService();

  List<PostModel> _posts = [];
  UnmodifiableListView<PostModel> get posts => UnmodifiableListView(_posts);

  late String username;

  void fetch() async {
    _posts = await service.readAll();
    notifyListeners();
  }

  Future<void> createPost({
    required title,
    required description,
    required userId,
  }) async {
    try {
      final model = CreatePostModel(
        userId: userId,
        title: title,
        description: description,
        createdAt: DateTime.now(),
      );
      final createdPost = await service.createPost(model);
      _posts.add(createdPost);
    } catch (err) {
      print('$err');
    }
    notifyListeners();
  }

  Future<void> updatePost({
    required PostModel post,
    required String title,
    required String description,
  }) async {
    int index = _posts.indexOf(post);
    final updatedPost = post.copyWith(
      title: title,
      description: description,
      updatedAt: DateTime.now(),
    );
    await service.updateDatabase(updatedPost);
    // List<PostModel> updatedList = _posts;
    // updatedList[index] = updatedPost;
    // _posts = updatedList;
    _posts[index] = updatedPost;
    notifyListeners();
  }

  Future<void> deletePost(PostModel deletePost) async {
    int index = _posts.indexOf(deletePost);
    await service.databaseDelete(deletePost);
    _posts.removeAt(index);
    notifyListeners();
  }
}
