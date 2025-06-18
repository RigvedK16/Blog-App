import 'package:flutter/material.dart';
import 'package:post_comments_using_localdb/features/post/view/Widgets/post_builder.dart';
import 'package:post_comments_using_localdb/features/post/view/create_post.dart';

class HomeScreen extends StatefulWidget {
  final String username;
  final int id;

  const HomeScreen({super.key, required this.username, required this.id});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All post'),
        actions: [
          IconButton(
            onPressed: () => _navToCreatePost(widget.username, widget.id),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: PostBuilder(userId: widget.id, username: widget.username),
      ),
    );
  }

  void _navToCreatePost(String username, int id) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => CreatePost(username: username, id: id)),
    );
  }
}
