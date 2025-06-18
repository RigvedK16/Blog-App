import 'package:flutter/material.dart';

class PostDeleteDialog extends StatelessWidget {
  const PostDeleteDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Confirm to delete this post ?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: Text('Delete'),
        ),
      ],
    );
  }
}
