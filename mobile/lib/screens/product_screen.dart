import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mercadex/features/products/data/products_repository.dart';
import 'package:mercadex/features/products/domain/product_deals.dart';
import 'package:mercadex/features/shopping_list/presentation/shopping_list_provider.dart';
import 'package:mercadex/widgets/app_top_bar.dart';
import 'package:mercadex/widgets/app_notification.dart';
import 'package:mercadex/widgets/deal_card.dart';

class ProductScreen extends ConsumerStatefulWidget {
  const ProductScreen({super.key, required this.productId});

  final String productId;

  @override
  ConsumerState<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends ConsumerState<ProductScreen> {
  late final Future<ProductDeals> _product;

  @override
  void initState() {
    super.initState();
    _product = const ProductsRepository().getProductDeals(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppTopBar(title: 'Produto'),
      body: FutureBuilder<ProductDeals>(
        future: _product,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text('Não foi possível carregar as ofertas.'),
            );
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
              const SizedBox(height: 16),
              Container(
                height: 220,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  Icons.shopping_bag_outlined,
                  size: 112,
                  color: Theme.of(context).colorScheme.primary,
                  semanticLabel: 'Foto do produto em breve',
                ),
              ),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: () {
                  ref
                      .read(shoppingListProvider.notifier)
                      .add(
                        productId: product.id,
                        name: product.name,
                        packaging: product.packaging,
                      );
                  showAppNotification(
                    context,
                    '${product.name} adicionado à lista.',
                  );
                },
                icon: const Icon(Icons.add_shopping_cart_outlined),
                label: const Text('Adicionar à lista de compras'),
              ),
              const SizedBox(height: 24),
              Text(
                'Preços nos supermercados',
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
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () =>
                    context.push('/product/${product.id}/informar-preco'),
                icon: const Icon(Icons.sell_outlined),
                label: const Text('Informar preço'),
              ),
            ],
          );
        },
      ),
    );
  }
}
