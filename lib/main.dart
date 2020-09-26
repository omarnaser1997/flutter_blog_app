import 'package:flutter/material.dart';

import 'package:flutter_blog_app/Mapping.dart';
import 'Authentication.dart';

void main() {
  runApp(new BlogApp());
}

class BlogApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Blog App",
      theme: new ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: MappingPage(
        auth: Auth(),
      ),
    );
  }
}
