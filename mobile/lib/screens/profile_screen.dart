import 'package:flutter/material.dart';
import 'package:mercadex/widgets/app_top_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppTopBar(title: 'Profile'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About Mercadex'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              showModalBottomSheet<void>(
                context: context,
                builder: (context) => const AboutSheet(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class AboutSheet extends StatelessWidget {
  const AboutSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About Mercadex',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 12),
            const Text(
              'Mercadex helps people discover nearby food deals shared by '
              'their community.',
            ),
          ],
        ),
      ),
    );
  }
}
