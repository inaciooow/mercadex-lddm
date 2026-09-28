import 'package:flutter_test/flutter_test.dart';
import 'package:mercadex/features/markets/data/markets_repository.dart';
import 'package:mercadex/features/products/data/products_repository.dart';

void main() {
  test(
    'Every mock market lists all products with an offer there, once',
    () async {
      const markets = MarketsRepository();
      const products = ProductsRepository();
      final catalog = await Future.wait(
        ProductsRepository.mockSearchProducts.map(
          (product) => products.getProductDeals(product.id),
        ),
      );

      for (final market in await markets.getMarkets()) {
        final detail = await markets.getMarket(market.id);
        final expected = catalog
            .where(
              (product) =>
                  product.deals.any((deal) => deal.marketId == market.id),
            )
            .map((product) => product.id)
            .toSet();
        expect(detail.products.map((product) => product.id).toSet(), expected);
        expect(detail.products.length, expected.length);
        expect(
          detail.products.any((product) => product.id == 'manteiga-200g'),
          isTrue,
        );
      }
    },
  );
}
