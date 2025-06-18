import 'package:flutter/material.dart';
import 'package:post_comments_using_localdb/application.dart';
import 'package:post_comments_using_localdb/core/local_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalDatabase.init();
  runApp(const Application());
}
