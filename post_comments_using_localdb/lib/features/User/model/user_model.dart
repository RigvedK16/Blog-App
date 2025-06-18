class UserModel {
  int id;
  String username;
  String password;

  UserModel({required this.id, required this.username, required this.password});

  factory UserModel.fromDatabase(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      username: map['username'],
      password: map['password'],
    );
  }
}
