import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final String content;

  const ErrorScreen({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(content),
      ),
    );
  }
}
