import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mercadex/features/home/presentation/providers/home_products_provider.dart';
import 'package:mercadex/features/products/data/products_repository.dart';
import 'package:mercadex/features/products/domain/search_product.dart';
import 'package:mercadex/core/widgets/app_search_field.dart';
import 'package:mercadex/core/widgets/app_top_bar.dart';
import 'package:mercadex/features/products/presentation/widgets/product_search_card.dart';

class SearchResultsPage extends ConsumerStatefulWidget {
  const SearchResultsPage({super.key, required this.query});

  final String query;

  @override
  ConsumerState<SearchResultsPage> createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends ConsumerState<SearchResultsPage> {
  late Future<List<SearchProduct>> _products;

  @override
  void initState() {
    super.initState();
    _products = _loadProducts();
  }

  @override
  void didUpdateWidget(covariant SearchResultsPage oldWidget) {
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
      appBar: const AppTopBar(title: 'Buscar produtos'),
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
                ? 'Pesquise um produto'
                : 'Resultados para "${widget.query}"',
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
                  child: Center(
                    child: Text('Não foi possível carregar os produtos.'),
                  ),
                );
              }

              final products = snapshot.data ?? [];
              if (products.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.only(top: 24),
                  child: Center(child: Text('Nenhum produto encontrado.')),
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    products.length == 1
                        ? '1 produto encontrado'
                        : '${products.length} produtos encontrados',
                  ),
                  const SizedBox(height: 16),
                  ...products.map(
                    (product) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: ProductSearchCard(
                        name: product.name,
                        packaging: product.packaging,
                        onTap: () {
                          ref
                              .read(recentProductsProvider.notifier)
                              .add(product);
                          context.push('/product/${product.id}');
                        },
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
