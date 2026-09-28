import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mercadex/features/shopping_list/presentation/shopping_list_provider.dart';
import 'package:mercadex/widgets/app_top_bar.dart';
import 'package:mercadex/widgets/product_avatar.dart';
import 'package:mercadex/core/theme/app_colors.dart';

class ShoppingListScreen extends ConsumerWidget {
  const ShoppingListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(shoppingListProvider);

    return Scaffold(
      appBar: const AppTopBar(title: 'Lista de compras'),
      bottomNavigationBar: SafeArea(
        top: false,
        minimum: const EdgeInsets.all(16),
        child: FilledButton.icon(
          onPressed: items.isEmpty ? null : () => context.push('/compare'),
          icon: const Icon(Icons.compare_arrows),
          label: const Text('Comparar supermercados'),
        ),
      ),
      body: items.isEmpty
          ? const Center(child: Text('Sua lista de compras está vazia.'))
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: items.length,
              separatorBuilder: (_, _) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final item = items[index];
                return Card(
                  child: Column(
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () => context.push('/product/${item.productId}'),
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Row(
                            children: [
                              const ProductAvatar(),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            color: AppColors.deepGreen,
                                            fontWeight: FontWeight.w700,
                                          ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      item.packaging,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            tooltip: 'Diminuir',
                            onPressed: () => ref
                                .read(shoppingListProvider.notifier)
                                .decrement(item.productId),
                            icon: const Icon(Icons.remove_circle_outline),
                          ),
                          Text('${item.quantity}'),
                          IconButton(
                            tooltip: 'Aumentar',
                            onPressed: () => ref
                                .read(shoppingListProvider.notifier)
                                .add(
                                  productId: item.productId,
                                  name: item.name,
                                  packaging: item.packaging,
                                ),
                            icon: const Icon(Icons.add_circle_outline),
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () => ref
                                .read(shoppingListProvider.notifier)
                                .remove(item.productId),
                            child: const Text('Remover'),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
