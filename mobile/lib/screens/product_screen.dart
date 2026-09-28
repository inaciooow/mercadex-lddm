import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mercadex/features/products/data/products_repository.dart';
import 'package:mercadex/features/products/domain/product_deals.dart';
import 'package:mercadex/widgets/app_top_bar.dart';
import 'package:mercadex/widgets/deal_card.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key, required this.productId});

  final String productId;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late final Future<ProductDeals> _product;

  @override
  void initState() {
    super.initState();
    _product = const ProductsRepository().getProductDeals(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppTopBar(title: 'Product'),
      body: FutureBuilder<ProductDeals>(
        future: _product,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Could not load product deals.'));
          }

          final product = snapshot.data!;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                product.name,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 4),
              Text(product.packaging),
              const SizedBox(height: 24),
              Text(
                'Available at other markets',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              ...product.deals.map(
                (deal) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: DealCard(
                    product: product.name,
                    market: deal.marketName,
                    branch: deal.branchName,
                    price: deal.price,
                    packaging: product.packaging,
                    onMarketTap: () => context.push('/market/${deal.marketId}'),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
