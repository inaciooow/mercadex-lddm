import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mercadex/widgets/app_search_field.dart';
import 'package:mercadex/widgets/deal_card.dart';

class SearchResultsScreen extends StatelessWidget {
  const SearchResultsScreen({super.key, required this.query});

  final String query;

  static const _bananaDeals = [
    (
      product: 'Banana Prata',
      market: 'FreshMart',
      price: 'R\$ 3.99 / kg',
      originalPrice: 'R\$ 5.49',
      distance: '0.8 km',
      status: 'Confirmed today',
    ),
    (
      product: 'Banana Nanica',
      market: 'Green Grocer',
      price: 'R\$ 4.29 / kg',
      originalPrice: 'R\$ 5.00',
      distance: '1.4 km',
      status: 'Submitted 2 hours ago',
    ),
    (
      product: 'Organic Bananas',
      market: 'Daily Market',
      price: 'R\$ 5.99 / kg',
      originalPrice: 'R\$ 7.49',
      distance: '2.1 km',
      status: 'Confirmed yesterday',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final normalizedQuery = query.trim().toLowerCase();
    final deals = normalizedQuery.contains('banana') ? _bananaDeals : const [];

    return Scaffold(
      appBar: AppBar(title: const Text('Search deals')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AppSearchField(
            initialValue: query,
            onSubmitted: (newQuery) {
              final searchQuery = newQuery.trim();
              if (searchQuery.isEmpty) {
                return;
              }

              context.replace(
                '/search?query=${Uri.encodeQueryComponent(searchQuery)}',
              );
            },
          ),
          const SizedBox(height: 24),
          Text(
            query.isEmpty ? 'Search for deals' : 'Deals for "$query"',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          if (deals.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text('${deals.length} nearby deals'),
            const SizedBox(height: 12),
            const Wrap(
              spacing: 8,
              children: [
                Chip(label: Text('Nearby')),
                Chip(label: Text('Lowest price')),
                Chip(label: Text('Newest')),
              ],
            ),
            const SizedBox(height: 16),
            ...deals.map(
              (deal) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: DealCard(
                  product: deal.product,
                  market: deal.market,
                  price: deal.price,
                  originalPrice: deal.originalPrice,
                  distance: deal.distance,
                  status: deal.status,
                ),
              ),
            ),
          ] else ...[
            const SizedBox(height: 24),
            const Center(child: Text('No deals found yet.')),
          ],
        ],
      ),
    );
  }
}
