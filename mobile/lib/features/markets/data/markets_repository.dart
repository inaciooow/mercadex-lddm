import 'package:mercadex/core/config/app_config.dart';
import 'package:mercadex/features/markets/data/markets_api.dart';
import 'package:mercadex/features/markets/domain/market.dart';

class MarketsRepository {
  const MarketsRepository({this.api = const MarketsApi()});

  final MarketsApi api;

  static const _mockMarkets = [
    Market(id: 'freshmart', name: 'FreshMart'),
    Market(id: 'value-foods', name: 'Value Foods'),
    Market(id: 'green-grocer', name: 'Green Grocer'),
    Market(id: 'daily-market', name: 'Daily Market'),
  ];

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
      ),
    );
  }
}
