import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:post_comments_using_localdb/features/User/model/user_model.dart';
import 'package:post_comments_using_localdb/features/User/view_model/user_view_model.dart';
import 'package:post_comments_using_localdb/features/post/model/post_model.dart';
import 'package:post_comments_using_localdb/features/post/view/Widgets/edit_delete_dropdown.dart';
import 'package:provider/provider.dart';

class PostListViewItem extends StatefulWidget {
  final PostModel post;

  const PostListViewItem({super.key, required this.post});

  @override
  State<PostListViewItem> createState() => _PostListViewItemState();
}

class _PostListViewItemState extends State<PostListViewItem> {
  UserModel? user;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      if (context.mounted) {
        final fetchedUser = await context.read<UserViewModel>().getUser(
          widget.post.userId,
        );
        if (fetchedUser != null) {
          user = fetchedUser;
          setState(() {
            user = fetchedUser;
          });
        } else {
          print('User fetched is null');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(width: 2, color: Colors.grey.shade500),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 270,
                child: Text(
                  widget.post.title,
                  style: Theme.of(context).textTheme.titleMedium,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              EditDeleteDropdown(user: user, post: widget.post),
            ],
          ),
          SizedBox(height: 16),
          Text(
            widget.post.description,
            style: Theme.of(context).textTheme.bodySmall,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 16),
          Text(
            DateFormat("EEEE, d MMMM yyyy").format(widget.post.createdAt),
            style: TextStyle(fontSize: 10, color: Colors.black45),
          ),
        ],
      ),
    );
  }
}
