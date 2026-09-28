import 'package:flutter/material.dart';

class DealCard extends StatelessWidget {
  const DealCard({
    super.key,
    required this.product,
    required this.market,
    required this.price,
    required this.originalPrice,
    required this.distance,
    required this.status,
  });

  final String product;
  final String market;
  final String price;
  final String originalPrice;
  final String distance;
  final String status;

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
                  Text('$market · $distance'),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Text(
                        price,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        originalPrice,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(status, style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
