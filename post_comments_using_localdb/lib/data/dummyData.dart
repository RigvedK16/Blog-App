import 'package:post_comments_using_localdb/features/User/model/create_user_model.dart';
import 'package:post_comments_using_localdb/features/post/model/create_post_model.dart';

final dummyUsers = [
  CreateUserModel(username: 'alice', password: 'password123'),
  CreateUserModel(username: 'bob', password: 'securepass'),
  CreateUserModel(username: 'charlie', password: 'charlie123'),
  CreateUserModel(username: 'diana', password: 'diana456'),
  CreateUserModel(username: 'eve', password: 'eve@789'),
];

final dummyPosts = [
  CreatePostModel(
    userId: 2,
    title: 'Welcome to My Blog',
    description:
        '''Hi everyone! I'm Alice and this is my very first post on this platform. 
I've always wanted a space where I can share my experiences and thoughts freely. 
This blog is going to be a mix of tech, personal growth, and lifestyle topics. 
I hope you find something relatable or helpful in the journey I share.''',
    createdAt: DateTime.now().subtract(Duration(days: 3, hours: 2)),
  ),
  CreatePostModel(
    userId: 3,
    title: 'Why Flutter is Awesome',
    description: '''Flutter has completely changed how I build mobile apps. 
With hot reload, I can experiment quickly without wasting time on rebuilds. 
The ability to use a single codebase for both Android and iOS is a huge advantage. 
It’s perfect for startups and solo developers looking to ship fast.''',
    createdAt: DateTime.now().subtract(Duration(days: 2, hours: 6)),
  ),
  CreatePostModel(
    userId: 4,
    title: 'Debugging Tips for Beginners',
    description:
        '''Debugging can feel overwhelming at first, but it gets better with practice. 
Always read the error messages carefully—they often tell you exactly what’s wrong. 
Using print statements or breakpoints helps you understand app behavior. 
Most importantly, don’t panic—step through logically and be methodical.''',
    createdAt: DateTime.now().subtract(Duration(days: 1, hours: 3)),
  ),
  CreatePostModel(
    userId: 5,
    title: 'My Day at the Hackathon',
    description:
        '''Last weekend, I participated in a 24-hour hackathon and it was wild. 
We formed a team of four and built a full-stack productivity app from scratch. 
I was in charge of the Flutter frontend while others handled the backend and UI design. 
Though we didn’t win, the experience taught me more than any course ever did.''',
    createdAt: DateTime.now().subtract(Duration(hours: 12)),
  ),
  CreatePostModel(
    userId: 6,
    title: 'Cybersecurity Basics Everyone Should Know',
    description:
        '''In today’s digital world, knowing basic cybersecurity is essential. 
Always use strong, unique passwords and enable two-factor authentication wherever possible. 
Be cautious of suspicious emails and links—even if they seem to come from friends. 
Your data is valuable, so protect it like you would your wallet or house key.''',
    createdAt: DateTime.now(),
  ),
];
