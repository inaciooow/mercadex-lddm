import 'package:flutter/material.dart';

class DealCard extends StatelessWidget {
  const DealCard({
    super.key,
    required this.product,
    required this.market,
    required this.branch,
    required this.price,
    required this.packaging,
  });

  final String product;
  final String market;
  final String branch;
  final String price;
  final String packaging;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: const Icon(Icons.local_grocery_store_outlined),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text('$market · $branch'),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Text(
                        'R\$ $price',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Active deal · $packaging',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
