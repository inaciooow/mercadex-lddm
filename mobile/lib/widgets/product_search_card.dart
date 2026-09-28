import 'package:flutter/material.dart';

class ProductSearchCard extends StatelessWidget {
  const ProductSearchCard({
    super.key,
    required this.name,
    required this.packaging,
    required this.onTap,
  });

  final String name;
  final String packaging;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          child: const Icon(Icons.shopping_bag_outlined),
        ),
        title: Text(name),
        subtitle: Text(packaging),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
