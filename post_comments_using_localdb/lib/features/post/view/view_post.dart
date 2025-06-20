import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:post_comments_using_localdb/features/User/model/user_model.dart';
import 'package:post_comments_using_localdb/features/User/service/local_database_service_user.dart';
import 'package:post_comments_using_localdb/features/User/view_model/user_view_model.dart';
import 'package:post_comments_using_localdb/features/comment/model/comment_model.dart';
import 'package:post_comments_using_localdb/features/comment/view/Widgets/comment_widget.dart';
import 'package:post_comments_using_localdb/features/comment/view/Widgets/create_comment.dart';
import 'package:post_comments_using_localdb/features/comment/view_model/comment_view_model.dart';
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
  UserModel? user;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      if (context.mounted) {
        final fetchedUser = await Provider.of<UserViewModel>(
          context,
          listen: false,
        ).getUser(widget.post.userId);
        if (fetchedUser != null) {
          setState(() {
            user = fetchedUser;
          });
        } else {
          print('User fetched is null');
        }
        final vm = Provider.of<CommentViewModel>(context, listen: false);
        vm.fetch(widget.post.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Text(
                'By @${user?.username ?? "loading..."}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              Text(
                widget.post.title,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: 15),
              Text(
                DateFormat('d MMMM yyyy, H:m').format(widget.post.createdAt),
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 30),
              Text(
                widget.post.description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 40),
              Text(
                'Comments',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: 20),

              CreateComment(user: user, post: widget.post),

              SizedBox(height: 10),
              Consumer<CommentViewModel>(
                builder: (context, vm, child) {
                  List<CommentModel> allComments =
                      vm.comments[widget.post.id] ?? [];
                  if (allComments.isEmpty) {
                    return Text(
                      'No comments yet.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: allComments.length,
                    itemBuilder: (BuildContext context, int index) {
                      CommentModel comment = allComments[index];
                      return CommentWidget(comment: comment, post: widget.post);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
