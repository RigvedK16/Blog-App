import 'package:flutter/material.dart';
import 'package:post_comments_using_localdb/features/post/model/post_model.dart';
import 'package:post_comments_using_localdb/features/post/view/dialogs/post_delete_dialog.dart';
import 'package:post_comments_using_localdb/features/post/view_model/post_view_model.dart';
import 'package:provider/provider.dart';

class PostDialogHelper {
  PostDialogHelper._();
  static PostDialogHelper instance = PostDialogHelper._();
  void showDeleteConformation({
    required BuildContext context,
    required PostModel post,
  }) async {
    final userApprovalToDelete = await showDialog<bool>(
      context: context,
      builder: (context) => PostDeleteDialog(),
    );
    if (userApprovalToDelete == true && context.mounted) {
      await context.read<PostViewModel>().deletePost(post);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Post deleted successfully..')));
    }
  }
}
