import 'package:bcrypt/bcrypt.dart';

class CreateUserModel {
  String username;
  String password;

  CreateUserModel({required this.username, required this.password});

  Map<String, dynamic> toMap() {
    String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
    return {"username": username, "password": hashedPassword};
  }
}
