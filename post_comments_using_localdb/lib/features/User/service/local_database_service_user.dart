import 'package:bcrypt/bcrypt.dart';
import 'package:post_comments_using_localdb/core/local_database.dart';
import 'package:post_comments_using_localdb/data/dummyData.dart';
import 'package:post_comments_using_localdb/features/User/model/create_user_model.dart';
import 'package:post_comments_using_localdb/features/User/model/user_model.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabaseServiceUser {
  Database db = LocalDatabase.instance;

  Future<void> insertDummyUsers(String username) async {
    for (var user in dummyUsers) {
      final res = await db.query(
        'User',
        where: 'username = ?',
        whereArgs: [user.username],
      );
      if (res.isEmpty) {
        final hashedPassword = BCrypt.hashpw(user.password, BCrypt.gensalt());
        await db.insert('User', {
          'username': user.username,
          'password': hashedPassword,
        });
        print('Dummy user ${user.username} inserted');
      }
    }
  }

  Future<UserModel> registerUser(CreateUserModel model) async {
    int id = await db.insert('User', model.toMap());
    return UserModel(
      id: id,
      username: model.username,
      password: model.password,
    );
  }

  Future<UserModel?> login(CreateUserModel model) async {
    final result = await db.query(
      'User',
      where: 'username = ?',
      whereArgs: [model.username],
    );

    if (result.isEmpty) return null;

    final user = result.first;
    final hashedPassword = user['password'] as String;
    bool verifyUser = BCrypt.checkpw(model.password, hashedPassword);

    if (verifyUser) {
      return UserModel.fromDatabase(user);
    }
  }

  Future<UserModel?> findUser(int id) async {
    try {
      final user = await db.query('User', where: 'id = ?', whereArgs: [id]);
      print('Result: $user');
      if (user.isNotEmpty) {
        return UserModel.fromDatabase(user[0]);
      }
    } catch (err) {
      print('Debug: $err');
    }
    return null;
  }
}
