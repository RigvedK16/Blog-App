import 'package:flutter/material.dart';
import 'package:post_comments_using_localdb/features/comment/model/comment_model.dart';
import 'package:post_comments_using_localdb/features/comment/view/Dialogs/comment_dialog_helper.dart';
import 'package:post_comments_using_localdb/features/comment/view/Widgets/create_comment.dart';
import 'package:post_comments_using_localdb/features/comment/view_model/comment_view_model.dart';
import 'package:post_comments_using_localdb/features/post/model/post_model.dart';
import 'package:provider/provider.dart';

class EditDeleteDropdownComments extends StatelessWidget {
  final PostModel post;
  final CommentModel? comment;
  const EditDeleteDropdownComments({
    super.key,
    required this.post,
    this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    child: Container(
                      width: 300,
                      padding: EdgeInsets.all(16),
                      child: ChangeNotifierProvider.value(
                        value: context.read<CommentViewModel>(),
                        child: SingleChildScrollView(
                          child: IntrinsicHeight(
                            child: CreateComment(post: post, comment: comment),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            child: Text('Edit'),
          ),
          PopupMenuItem(
            onTap: () {
              CommentDialogHelper.instance.showDeleteConformation(
                context: context,
                comment: comment!,
              );
            },
            child: Text('Delete'),
          ),
        ];
      },
    );
  }
}
