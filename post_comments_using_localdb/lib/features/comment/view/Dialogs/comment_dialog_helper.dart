import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:post_comments_using_localdb/features/comment/model/comment_model.dart';
import 'package:post_comments_using_localdb/features/comment/view/Dialogs/delete_comment_dialog.dart';
import 'package:post_comments_using_localdb/features/comment/view_model/comment_view_model.dart';
import 'package:provider/provider.dart';

class CommentDialogHelper {
  CommentDialogHelper._();
  static CommentDialogHelper instance = CommentDialogHelper._();

  void showDeleteConformation({
    required BuildContext context,
    required CommentModel comment,
  }) async {
    final userApprovalToDelete = await showDialog<bool>(
      context: context,
      builder: (context) => DeleteCommentDialog(),
    );
    if (userApprovalToDelete == true) {
      context.read<CommentViewModel>().delete(comment);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Comment deleted...')));
    }
  }
}
