import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mercadex/features/products/data/products_repository.dart';
import 'package:mercadex/features/products/domain/search_product.dart';
import 'package:mercadex/widgets/app_search_field.dart';
import 'package:mercadex/widgets/app_top_bar.dart';
import 'package:mercadex/widgets/product_search_card.dart';

class SearchResultsScreen extends StatefulWidget {
  const SearchResultsScreen({super.key, required this.query});

  final String query;

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  late Future<List<SearchProduct>> _products;

  @override
  void initState() {
    super.initState();
    _products = _loadProducts();
  }

  @override
  void didUpdateWidget(covariant SearchResultsScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.query == widget.query) {
      return;
    }

    setState(() {
      _products = _loadProducts();
    });
  }

  Future<List<SearchProduct>> _loadProducts() {
    if (widget.query.trim().isEmpty) {
      return Future.value([]);
    }

    return const ProductsRepository().search(widget.query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppTopBar(title: 'Search deals'),
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
          FutureBuilder<List<SearchProduct>>(
            future: _products,
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
                  child: Center(child: Text('Could not load products.')),
                );
              }

              final products = snapshot.data ?? [];
              if (products.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.only(top: 24),
                  child: Center(child: Text('No deals found yet.')),
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${products.length} products found'),
                  const SizedBox(height: 16),
                  ...products.map(
                    (product) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: ProductSearchCard(
                        name: product.name,
                        packaging: product.packaging,
                        onTap: () => context.push('/product/${product.id}'),
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
