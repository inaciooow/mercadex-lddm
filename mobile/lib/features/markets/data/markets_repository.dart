import 'package:mercadex/core/config/app_config.dart';
import 'package:mercadex/features/markets/data/markets_api.dart';
import 'package:mercadex/features/markets/domain/market.dart';
import 'package:mercadex/features/products/data/products_repository.dart';

class MarketsRepository {
  const MarketsRepository({this.api = const MarketsApi()});

  final MarketsApi api;

  static const _mockMarkets = [
    Market(id: 'freshmart', name: 'Carrefour'),
    Market(id: 'value-foods', name: 'Pão de Açúcar'),
    Market(id: 'green-grocer', name: 'Assaí Atacadista'),
    Market(id: 'daily-market', name: 'Atacadão'),
  ];

  Future<List<Market>> getMarkets() {
    if (AppConfig.useMockData) {
      return Future.value(_mockMarkets);
    }

    return api.getMarkets();
  }

  Future<MarketDetail> getMarket(String marketId) async {
    if (!AppConfig.useMockData) {
      return api.getMarket(marketId);
    }

    final market = _mockMarkets.where((market) => market.id == marketId).first;
    final catalog = await Future.wait(
      ProductsRepository.mockSearchProducts.map(
        (product) => const ProductsRepository().getProductDeals(product.id),
      ),
    );
    final products =
        catalog
            .where(
              (product) =>
                  product.deals.any((deal) => deal.marketId == marketId),
            )
            .map(
              (product) => MarketProduct(
                id: product.id,
                name: product.name,
                packaging: product.packaging,
              ),
            )
            .toList()
          ..sort((a, b) => a.name.compareTo(b.name));
    return Future.value(
      MarketDetail(
        id: market.id,
        name: market.name,
        branches: [
          MarketBranch(
            id: '${market.id}-central',
            name: '${market.name} Central',
            address: 'Rua do Mercado',
          ),
        ],
        products: products,
      ),
    );
  }
}
