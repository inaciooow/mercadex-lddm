import 'package:flutter/material.dart';
import 'package:mercadex/widgets/app_top_bar.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppTopBar(title: 'Log in'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Welcome back',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          const Text('Log in to submit and confirm food deals.'),
          const SizedBox(height: 24),
          const TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(labelText: 'User'),
          ),
          const SizedBox(height: 12),
          const TextField(
            obscureText: true,
            decoration: InputDecoration(labelText: 'Password'),
          ),
          const SizedBox(height: 24),
          FilledButton(onPressed: () {}, child: const Text('Log in')),
        ],
      ),
    );
  }
}
