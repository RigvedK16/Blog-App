import 'package:flutter/material.dart';
import 'package:post_comments_using_localdb/features/post/model/post_model.dart';
import 'package:post_comments_using_localdb/features/post/view_model/post_view_model.dart';
import 'package:provider/provider.dart';

class CreatePost extends StatefulWidget {
  final String? username;
  final int? id;
  final PostModel? post;

  const CreatePost({
    super.key,
    required this.username,
    required this.id,
    this.post,
  });

  State<CreatePost> createState() => CreatePostScreen();
}

class CreatePostScreen extends State<CreatePost> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;

  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.post?.title);
    _descriptionController = TextEditingController(
      text: widget.post?.description,
    );
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post != null ? 'Update Post' : 'Create your Post'),
      ),
      body: Padding(
        padding: EdgeInsets.all(40),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              Text('Title'),
              SizedBox(height: 5),
              TextFormField(
                controller: _titleController,
                style: Theme.of(context).textTheme.bodyLarge,
                validator: (value) {
                  if (value == null) {
                    return 'Title is empty';
                  }
                  if (value.trim().length <= 3) {
                    return 'Title should be more than 3 characters';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),
              Text('Description'),
              SizedBox(height: 5),
              TextFormField(
                controller: _descriptionController,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 20),
              Center(
                child: FilledButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() == true) {
                      if (widget.post == null) {
                        context
                            .read<PostViewModel>()
                            .createPost(
                              title: _titleController.text,
                              description: _descriptionController.text,
                              userId: widget.id,
                            )
                            .whenComplete(() {
                              if (context.mounted) {
                                Navigator.of(context).pop();
                              }
                            });
                      } else {
                        context
                            .read<PostViewModel>()
                            .updatePost(
                              post: widget.post!,
                              title: _titleController.text,
                              description: _descriptionController.text,
                            )
                            .whenComplete(() {
                              if (context.mounted) {
                                Navigator.of(context).pop();
                              }
                            });
                      }
                    }
                  },
                  child: Text(
                    widget.post != null ? 'Update' : 'Post',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
  }
}
