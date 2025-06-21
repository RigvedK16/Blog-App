import 'package:post_comments_using_localdb/core/local_database.dart';
import 'package:post_comments_using_localdb/features/comment/model/comment_model.dart';
import 'package:post_comments_using_localdb/features/comment/model/create_comment_model.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabaseServiceComment {
  Database db = LocalDatabase.instance;

  Future<List<CommentModel>> readAll(int postId) async {
    final res = await db.query(
      'Comment',
      where: 'postId = ? AND deletedAt IS NULL',
      whereArgs: [postId],
    );
    return res.map((map) => CommentModel.fromDatabase(map)).toList();
  }

  Future<CommentModel> createComment(CreateCommentModel model) async {
    int id = await db.insert('Comment', model.toMap());
    return CommentModel(
      id: id,
      userId: model.userId,
      postId: model.postId,
      comment: model.comment,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
      deletedAt: model.deletedAt,
    );
  }

  Future<void> updateComment(CommentModel updatedModel) async {
    await db.update(
      'Comment',
      updatedModel.toUpdateDatabase(),
      where: 'id = ?',
      whereArgs: [updatedModel.id],
    );
  }

  Future<void> deleteComment(CommentModel deletedModel) async {
    await db.update(
      'Comment',
      deletedModel.toDatabaseDelete(),
      where: 'id = ?',
      whereArgs: [deletedModel.id],
    );
  }
}
