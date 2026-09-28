import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mercadex/features/deals/data/deals_repository.dart';
import 'package:mercadex/features/deals/domain/search_deal.dart';
import 'package:mercadex/widgets/app_search_field.dart';
import 'package:mercadex/widgets/deal_card.dart';

class SearchResultsScreen extends StatefulWidget {
  const SearchResultsScreen({super.key, required this.query});

  final String query;

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  late Future<List<SearchDeal>> _deals;

  @override
  void initState() {
    super.initState();
    _deals = _loadDeals();
  }

  @override
  void didUpdateWidget(covariant SearchResultsScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.query == widget.query) {
      return;
    }

    setState(() => _deals = _loadDeals());
  }

  Future<List<SearchDeal>> _loadDeals() {
    if (widget.query.trim().isEmpty) {
      return Future.value([]);
    }

    return const DealsRepository().search(widget.query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search deals')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AppSearchField(
            initialValue: widget.query,
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
            widget.query.isEmpty
                ? 'Search for deals'
                : 'Deals for "${widget.query}"',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 12),
          FutureBuilder<List<SearchDeal>>(
            future: _deals,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Padding(
                  padding: EdgeInsets.only(top: 24),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (snapshot.hasError) {
                return const Padding(
                  padding: EdgeInsets.only(top: 24),
                  child: Center(child: Text('Could not load deals.')),
                );
              }

              final deals = snapshot.data ?? [];
              if (deals.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.only(top: 24),
                  child: Center(child: Text('No deals found yet.')),
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                        product: deal.productName,
                        market: deal.marketName,
                        branch: deal.branchName,
                        price: deal.price,
                        packaging: deal.packaging,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
