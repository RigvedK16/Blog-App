import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDatabase {
  const LocalDatabase._();

  static late Database instance;

  static Future<void> init() async {
    final databasePath = await getDatabasesPath();
    String path = join(databasePath, 'post_comment.db');
    await deleteDatabase(path);
    print('Debug Path:$path');
    instance = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE User(id INTEGER PRIMARY KEY AUTOINCREMENT,username TEXT NOT NULL,password TEXT NOT NULL)',
        );
        await db.execute(
          'CREATE TABLE Post(id INTEGER PRIMARY KEY AUTOINCREMENT,userId INTEGER NOT NULL,title TEXT NOT NULL,description TEXT NOT NULL,createdAt INTEGER NOT NULL,updatedAt INTEGER,deletedAt INTEGER,FOREIGN KEY(userId) REFERENCES User(id))',
        );
      },
    );
  }
}
