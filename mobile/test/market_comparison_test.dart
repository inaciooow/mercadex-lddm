import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mercadex/features/markets/presentation/market_comparison_provider.dart';
import 'package:mercadex/features/shopping_list/presentation/shopping_list_provider.dart';

void main() {
  test(
    'Comparison ranks complete baskets and updates after quantity changes',
    () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      expect(await container.read(marketComparisonProvider.future), isEmpty);

      final list = container.read(shoppingListProvider.notifier);
      list.add(productId: 'arroz-5kg', name: 'Arroz', packaging: '5kg');
      list.add(productId: 'manteiga-200g', name: 'Manteiga', packaging: '200g');

      final results = await container.read(marketComparisonProvider.future);
      expect(results.map((market) => market.marketId), [
        'green-grocer',
        'daily-market',
        'freshmart',
        'value-foods',
      ]);
      expect(results.map((market) => market.totalCents), [
        4298,
        4338,
        4378,
        4558,
      ]);

      list.add(productId: 'arroz-5kg', name: 'Arroz', packaging: '5kg');
      final updated = await container.read(marketComparisonProvider.future);
      expect(updated.first.totalCents, 7297);
    },
  );
}
