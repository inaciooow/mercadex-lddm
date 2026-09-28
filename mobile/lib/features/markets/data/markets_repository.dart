import 'package:mercadex/core/config/app_config.dart';
import 'package:mercadex/features/markets/data/markets_api.dart';
import 'package:mercadex/features/markets/domain/market.dart';

class MarketsRepository {
  const MarketsRepository({this.api = const MarketsApi()});

  final MarketsApi api;

  static const _mockMarkets = [
    Market(id: 'freshmart', name: 'Carrefour'),
    Market(id: 'value-foods', name: 'Pão de Açúcar'),
    Market(id: 'green-grocer', name: 'Assaí Atacadista'),
    Market(id: 'daily-market', name: 'Atacadão'),
  ];

  static const _mockProductsByMarket = {
    'freshmart': [
      MarketProduct(
        id: 'banana-prata-1kg',
        name: 'Banana Prata',
        packaging: '1kg',
      ),
    ],
    'value-foods': [
      MarketProduct(
        id: 'banana-nanica-1kg',
        name: 'Banana Nanica',
        packaging: '1kg',
      ),
      MarketProduct(
        id: 'banana-prata-1kg',
        name: 'Banana Prata',
        packaging: '1kg',
      ),
    ],
    'green-grocer': [
      MarketProduct(
        id: 'banana-organica-1kg',
        name: 'Banana Orgânica',
        packaging: '1kg',
      ),
    ],
    'daily-market': [
      MarketProduct(
        id: 'banana-prata-1kg',
        name: 'Banana Prata',
        packaging: '1kg',
      ),
    ],
  };

  Future<List<Market>> getMarkets() {
    if (AppConfig.useMockData) {
      return Future.value(_mockMarkets);
    }

    return api.getMarkets();
  }

  Future<MarketDetail> getMarket(String marketId) {
    if (!AppConfig.useMockData) {
      return api.getMarket(marketId);
    }

    final market = _mockMarkets.where((market) => market.id == marketId).first;
    return Future.value(
      MarketDetail(
        id: market.id,
        name: market.name,
        branches: [
          MarketBranch(
            id: '${market.id}-central',
            name: '${market.name} Central',
            address: 'Market Street',
          ),
        ],
        products: _mockProductsByMarket[marketId] ?? const [],
      ),
    );
  }
}
