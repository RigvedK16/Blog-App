import 'package:flutter/material.dart';
import 'package:post_comments_using_localdb/features/User/model/user_model.dart';
import 'package:post_comments_using_localdb/features/User/view_model/user_view_model.dart';
import 'package:post_comments_using_localdb/features/post/model/post_model.dart';
import 'package:post_comments_using_localdb/features/post/view/create_post.dart';
import 'package:post_comments_using_localdb/features/post/view/dialogs/post_dialog_helper.dart';
import 'package:post_comments_using_localdb/features/post/view_model/post_view_model.dart';
import 'package:provider/provider.dart';

class EditDeleteDropdown extends StatelessWidget {
  final UserModel? user;
  final PostModel? post;
  const EditDeleteDropdown({super.key, this.user, this.post});

  @override
  Widget build(BuildContext context) {
    final validateUser = context.read<UserViewModel>().validatedUser;
    bool validate = validateUser != null && validateUser.id == post?.userId;
    if (validate) {
      return PopupMenuButton(
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              child: Text('Edit'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => ChangeNotifierProvider.value(
                          value: context.read<PostViewModel>(),
                          child: CreatePost(
                            username: user?.username,
                            id: user?.id,
                            post: post,
                          ),
                        ),
                  ),
                );
              },
            ),
            PopupMenuItem(
              child: Text('Delete'),
              onTap: () {
                PostDialogHelper.instance.showDeleteConformation(
                  context: context,
                  post: post!,
                );
              },
            ),
          ];
        },
      );
    }
    return Container();
  }
}
