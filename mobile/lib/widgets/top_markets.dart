import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TopMarkets extends StatelessWidget {
  const TopMarkets({super.key});

  static const _markets = [
    'FreshMart',
    'Value Foods',
    'Green Grocer',
    'Daily Market',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Top markets', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _markets.map((market) {
              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: SizedBox(
                  width: 72,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(28),
                    onTap: () => context.push(
                      '/market/${market.toLowerCase().replaceAll(' ', '-')}',
                    ),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.primary,
                          child: Text(
                            market[0],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          market,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
