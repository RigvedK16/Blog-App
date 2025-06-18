import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:post_comments_using_localdb/features/User/service/local_database_service_user.dart';
import 'package:post_comments_using_localdb/features/User/view_model/user_view_model.dart';
import 'package:post_comments_using_localdb/features/post/model/post_model.dart';
import 'package:provider/provider.dart';

class ViewPost extends StatefulWidget {
  final PostModel post;

  const ViewPost({super.key, required this.post});

  @override
  State<ViewPost> createState() => _ViewPostState();
}

class _ViewPostState extends State<ViewPost> {
  LocalDatabaseServiceUser userService = LocalDatabaseServiceUser();

  @override
  void initState() {
    super.initState();
    print('Debug: Looking for username for userId: ${widget.post.userId}');
    print('Debug: ${userService.findUser(widget.post.id)}');
    Future.microtask(() {
      Provider.of<UserViewModel>(
        context,
        listen: false,
      ).getUser(widget.post.userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<UserViewModel>(
        builder: (context, vm, child) {
          final username = vm.usernames[widget.post.userId];

          return Padding(
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  Text(
                    'By @${username ?? "loading..."}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    widget.post.title,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    DateFormat(
                      'd MMMM yyyy, H:m',
                    ).format(widget.post.createdAt),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 30),
                  Text(
                    widget.post.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
