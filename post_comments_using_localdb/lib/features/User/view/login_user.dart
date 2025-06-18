import 'package:flutter/material.dart';
import 'package:post_comments_using_localdb/features/User/view/register_user.dart';
import 'package:post_comments_using_localdb/features/User/view_model/user_view_model.dart';
import 'package:post_comments_using_localdb/features/post/view/home_screen.dart';
import 'package:provider/provider.dart';

final _formKeyForUser = GlobalKey<FormState>();

class LoginUser extends StatefulWidget {
  const LoginUser({super.key});

  @override
  State<LoginUser> createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        actions: [
          FilledButton(onPressed: _navToRegister, child: Text('Register')),
        ],
      ),
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
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
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
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),
              FilledButton(
                onPressed: () async {
                  try {
                    print(
                      'Debug: Attempting login for user: ${_usernameController.text}',
                    );

                    final user = await context
                        .read<UserViewModel>()
                        .identifyUser(
                          username: _usernameController.text.trim(),
                          password: _passwordController.text,
                        );

                    if (mounted) {
                      if (user != null) {
                        print('Debug: Login successful, navigating to home');
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) => HomeScreen(
                                  username: user.username,
                                  id: user.id,
                                ),
                          ),
                        );
                      } else {
                        print('Debug: Login failed - user is null');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Invalid username or password'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                  } catch (e) {
                    print('Debug: Login error: $e');
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Login error: $e'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                },
                child: Text('Login', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navToRegister() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => RegisterUser()));
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
