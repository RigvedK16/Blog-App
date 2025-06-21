import 'package:flutter/material.dart';
import 'package:post_comments_using_localdb/features/comment/model/comment_model.dart';
import 'package:post_comments_using_localdb/features/comment/model/create_comment_model.dart';
import 'package:post_comments_using_localdb/features/comment/service/local_database_service_comment.dart';

class CommentViewModel extends ChangeNotifier {
  LocalDatabaseServiceComment commentService = LocalDatabaseServiceComment();
  final Map<int, List<CommentModel>> _comments = {};
  get comments => _comments;

  Future<void> fetch(int postId) async {
    _comments[postId] = await commentService.readAll(postId);
    notifyListeners();
  }

  Future<void> create({
    required int userId,
    required int postId,
    required String comment,
  }) async {
    final model = CreateCommentModel(
      userId: userId,
      postId: postId,
      comment: comment,
      createdAt: DateTime.now(),
    );
    final createdComment = await commentService.createComment(model);
    _comments[postId]!.add(createdComment);
    print('Created Comment : ${createdComment.comment}');
    notifyListeners();
  }

  Future<void> update({
    required CommentModel comment,
    required String updatedComment,
    required int postId,
    required int userId,
  }) async {
    int postIndex = postId;
    int userIndex = _comments[postIndex]!.indexOf(comment);
    CommentModel updatedModel = comment.copyWith(
      comment: updatedComment,
      updatedAt: DateTime.now(),
    );
    print('Editing: ${updatedModel.comment}');
    await commentService.updateComment(updatedModel);
    _comments[postIndex]?[userIndex] = updatedModel;
    notifyListeners();
  }

  Future<void> delete(CommentModel comment) async {
    int postId = comment.postId;
    await commentService.deleteComment(comment);
    _comments[postId]!.remove(comment);
    notifyListeners();
  }
}
