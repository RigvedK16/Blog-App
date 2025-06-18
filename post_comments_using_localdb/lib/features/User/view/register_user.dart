import 'package:flutter/material.dart';
import 'package:post_comments_using_localdb/features/User/view_model/user_view_model.dart';
import 'package:post_comments_using_localdb/features/post/view/home_screen.dart';
import 'package:provider/provider.dart';

final _formKeyForUser = GlobalKey<FormState>();

class RegisterUser extends StatefulWidget {
  const RegisterUser({super.key});

  @override
  State<RegisterUser> createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKeyForUser,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 60),
              Text('Username', style: Theme.of(context).textTheme.bodyLarge),
              SizedBox(height: 15),
              TextFormField(
                controller: _usernameController,
                style: Theme.of(context).textTheme.titleMedium,
                validator: (value) {
                  if (value == null) {
                    return 'Enter a username';
                  }
                  if (value.trim().length <= 3) {
                    return 'Username should be more than 3 characters';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Text('Password', style: Theme.of(context).textTheme.bodyLarge),
              SizedBox(height: 15),
              TextFormField(
                controller: _passwordController,
                style: Theme.of(context).textTheme.titleMedium,
                validator: (value) {
                  if (value == null) {
                    return 'Enter a password';
                  }
                  if (value.trim().length < 6) {
                    return 'Password should have atleast 6 characters';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),
              FilledButton(
                onPressed: () async {
                  if (_formKeyForUser.currentState?.validate() == true) {
                    final user = await context.read<UserViewModel>().createUser(
                      username: _usernameController.text,
                      password: _passwordController.text,
                    );
                    if (mounted) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => HomeScreen(
                                username: user.username,
                                id: user.id,
                              ),
                        ),
                      );
                    }
                  }
                },
                child: Text('Register', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
