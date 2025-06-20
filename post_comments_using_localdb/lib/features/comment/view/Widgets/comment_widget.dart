import 'package:flutter/material.dart';
import 'package:post_comments_using_localdb/features/User/model/user_model.dart';
import 'package:post_comments_using_localdb/features/User/view_model/user_view_model.dart';
import 'package:post_comments_using_localdb/features/comment/model/comment_model.dart';
import 'package:post_comments_using_localdb/features/comment/view/Widgets/edit_delete_dropdown_comments.dart';
import 'package:post_comments_using_localdb/features/post/model/post_model.dart';
import 'package:provider/provider.dart';

class CommentWidget extends StatefulWidget {
  final CommentModel comment;
  final PostModel post;
  const CommentWidget({super.key, required this.comment, required this.post});

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  UserModel? validatedUser;
  @override
  void initState() {
    super.initState();
    if (context.mounted) {
      final vm = Provider.of<UserViewModel>(context, listen: false);
      validatedUser = vm.validatedUser;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: 330,
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(width: 2, color: Colors.grey.shade500),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '@${validatedUser?.username}',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              EditDeleteDropdownComments(
                post: widget.post,
                comment: widget.comment,
              ),
            ],
          ),

          SizedBox(height: 10),
          Text(
            widget.comment.comment,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
