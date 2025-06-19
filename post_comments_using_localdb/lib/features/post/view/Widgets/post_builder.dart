import 'package:flutter/material.dart';
import 'package:post_comments_using_localdb/features/User/model/user_model.dart';
import 'package:post_comments_using_localdb/features/User/service/local_database_service_user.dart';
import 'package:post_comments_using_localdb/features/post/model/post_model.dart';
import 'package:post_comments_using_localdb/features/post/service/local_database_service.dart';
import 'package:post_comments_using_localdb/features/post/view/Widgets/post_list_view_item.dart';
import 'package:post_comments_using_localdb/features/post/view/view_post.dart';
import 'package:post_comments_using_localdb/features/post/view_model/post_view_model.dart';
import 'package:provider/provider.dart';

class PostBuilder extends StatefulWidget {
  final int userId;
  final String username;
  const PostBuilder({super.key, required this.userId, required this.username});

  @override
  State<PostBuilder> createState() => _PostBuilderState();
}

class _PostBuilderState extends State<PostBuilder> {
  LocalDatabaseService service = LocalDatabaseService();
  LocalDatabaseServiceUser userService = LocalDatabaseServiceUser();
  late UserModel user;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      try {
        if (context.mounted) {
          await userService.insertDummyUsers(widget.username);
          await service.insertDummyData();
          final vm = Provider.of<PostViewModel>(context, listen: false);
          vm.fetch();
        }
      } catch (err) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('$err')));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PostViewModel>(
      builder: (context, vm, child) {
        return ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: vm.posts.length,
          itemBuilder: (BuildContext context, int index) {
            final post = vm.posts[index];
            print('debug: $post');
            return GestureDetector(
              onTap: () => _navToView(post),
              child: PostListViewItem(post: post),
            );
          },
        );
      },
    );
  }

  void _navToView(PostModel post) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ViewPost(post: post)),
    );
  }
}
