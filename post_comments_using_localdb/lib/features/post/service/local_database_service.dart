import 'package:post_comments_using_localdb/core/local_database.dart';
import 'package:post_comments_using_localdb/data/dummyData.dart';
// import 'package:post_comments_using_localdb/data/dummyData.dart';
import 'package:post_comments_using_localdb/features/post/model/create_post_model.dart';
import 'package:post_comments_using_localdb/features/post/model/post_model.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabaseService {
  Database db = LocalDatabase.instance;

  Future<void> insertDummyData() async {
    final res = await db.rawQuery('SELECT * FROM Post');
    int count = res.length;
    if (count == 0) {
      for (var post in dummyPosts) {
        await createPost(post);
      }
    }
  }

  Future<List<PostModel>> readAll() async {
    final res = await db.rawQuery('SELECT * FROM Post WHERE deletedAt IS NULL');
    return res.map((map) => PostModel.fromDatabase(map)).toList();
  }

  Future<PostModel> createPost(CreatePostModel model) async {
    final int id = await db.insert('Post', model.toMap());
    return PostModel(
      id: id,
      userId: model.userId,
      title: model.title,
      description: model.description,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
      deletedAt: model.deletedAt,
    );
  }

  Future<void> updateDatabase(PostModel updatedModel) async {
    await db.update(
      'Post',
      updatedModel.toUpdateDatabase(),
      where: 'id = ?',
      whereArgs: [updatedModel.id],
    );
  }

  Future<void> databaseDelete(PostModel deleteModel) async {
    await db.update(
      'Post',
      deleteModel.toDatabaseDelete(),
      where: 'id = ?',
      whereArgs: [deleteModel.id],
    );
  }
}
