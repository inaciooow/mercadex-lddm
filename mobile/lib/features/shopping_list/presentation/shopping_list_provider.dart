import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mercadex/features/shopping_list/domain/shopping_list_item.dart';

final shoppingListProvider =
    NotifierProvider<ShoppingListNotifier, List<ShoppingListItem>>(
      ShoppingListNotifier.new,
    );

class ShoppingListNotifier extends Notifier<List<ShoppingListItem>> {
  @override
  List<ShoppingListItem> build() => [];

  void add({
    required String productId,
    required String name,
    required String packaging,
  }) {
    final index = state.indexWhere((item) => item.productId == productId);
    if (index == -1) {
      state = [
        ...state,
        ShoppingListItem(
          productId: productId,
          name: name,
          packaging: packaging,
          quantity: 1,
        ),
      ];
      return;
    }

    state = [
      for (var itemIndex = 0; itemIndex < state.length; itemIndex++)
        itemIndex == index
            ? state[itemIndex].copyWith(quantity: state[itemIndex].quantity + 1)
            : state[itemIndex],
    ];
  }

  void decrement(String productId) {
    final item = state.where((item) => item.productId == productId).first;
    if (item.quantity == 1) {
      state = state.where((item) => item.productId != productId).toList();
      return;
    }

    state = [
      for (final item in state)
        item.productId == productId
            ? item.copyWith(quantity: item.quantity - 1)
            : item,
    ];
  }

  void remove(String productId) {
    state = state.where((item) => item.productId != productId).toList();
  }
}
