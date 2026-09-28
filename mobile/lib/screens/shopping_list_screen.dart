import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mercadex/features/shopping_list/presentation/shopping_list_provider.dart';
import 'package:mercadex/widgets/app_top_bar.dart';

class ShoppingListScreen extends ConsumerWidget {
  const ShoppingListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(shoppingListProvider);

    return Scaffold(
      appBar: const AppTopBar(title: 'Lista de compras'),
      body: items.isEmpty
          ? const Center(child: Text('Sua lista de compras está vazia.'))
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: items.length,
              separatorBuilder: (_, _) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final item = items[index];
                return Card(
                  child: ListTile(
                    title: Text(item.name),
                    subtitle: Text(item.packaging),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () => ref
                              .read(shoppingListProvider.notifier)
                              .decrement(item.productId),
                          icon: const Icon(Icons.remove_circle_outline),
                        ),
                        Text('${item.quantity}'),
                        IconButton(
                          onPressed: () => ref
                              .read(shoppingListProvider.notifier)
                              .add(
                                productId: item.productId,
                                name: item.name,
                                packaging: item.packaging,
                              ),
                          icon: const Icon(Icons.add_circle_outline),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
