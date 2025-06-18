import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:post_comments_using_localdb/features/User/model/create_user_model.dart';
import 'package:post_comments_using_localdb/features/User/model/user_model.dart';
import 'package:post_comments_using_localdb/features/User/service/local_database_service_user.dart';

class UserViewModel extends ChangeNotifier {
  LocalDatabaseServiceUser service = LocalDatabaseServiceUser();

  List<UserModel> _users = [];
  UnmodifiableListView<UserModel> get users => UnmodifiableListView(_users);

  late UserModel? validatedUser;

  final Map<int, String> _usernames = {};
  UnmodifiableMapView<int, String> get usernames =>
      UnmodifiableMapView(_usernames);

  Future<UserModel> createUser({required username, required password}) async {
    final model = CreateUserModel(username: username, password: password);
    final createdUser = await service.registerUser(model);
    _users.add(createdUser);
    validatedUser = createdUser;
    notifyListeners();
    return createdUser;
  }

  Future<UserModel?> identifyUser({
    required username,
    required password,
  }) async {
    final model = CreateUserModel(username: username, password: password);
    validatedUser = await service.login(model);
    notifyListeners();
    return validatedUser;
  }

  Future<UserModel?> getUser(int id) async {
    final user = await service.findUser(id);
    if (!_usernames.containsKey(id)) {
      _usernames[id] = user != null ? user.username : 'Anonymous';
    }
    notifyListeners();
    return user;
  }
}
