import 'package:flutter/material.dart';
import 'package:post_comments_using_localdb/features/User/model/user_model.dart';
import 'package:post_comments_using_localdb/features/User/view_model/user_view_model.dart';
import 'package:post_comments_using_localdb/features/comment/view_model/comment_view_model.dart';
import 'package:post_comments_using_localdb/features/post/model/post_model.dart';
import 'package:provider/provider.dart';

class CreateComment extends StatefulWidget {
  final UserModel? user;

  final PostModel post;

  const CreateComment({super.key, this.user, required this.post});

  @override
  State<CreateComment> createState() => _CreateCommentState();
}

class _CreateCommentState extends State<CreateComment> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final validatedUser = context.read<UserViewModel>().validatedUser;
    bool validate =
        validatedUser != null && validatedUser.id == widget.post.userId;
    if (!validate) {
      return Container(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _commentController,
                style: Theme.of(context).textTheme.bodyMedium,
                validator: (value) {
                  if (value == null) {
                    return 'Enter something...';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'Write a comment',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              FilledButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() == true) {
                    context
                        .read<CommentViewModel>()
                        .create(
                          userId: widget.user?.id,
                          postId: widget.post.id,
                          comment: _commentController.text,
                        )
                        .whenComplete(() {
                          if (context.mounted) {
                            _commentController.clear();
                            setState(() {});
                          }
                        });
                  }
                },
                child: Text('Submit'),
              ),
              // SizedBox(height: 20),
            ],
          ),
        ),
      );
    }
    return Container();
  }
}
