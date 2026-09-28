import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ToBeImplementedScreen extends StatelessWidget {
  const ToBeImplementedScreen({super.key, this.title = 'Em breve'});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(title),
      ),
    );
  }
}
