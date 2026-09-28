import 'package:mercadex/core/config/app_config.dart';
import 'package:mercadex/features/deals/data/deals_api.dart';
import 'package:mercadex/features/deals/domain/search_deal.dart';

class DealsRepository {
  const DealsRepository({this.api = const DealsApi()});

  final DealsApi api;

  static const _mockDeals = [
    SearchDeal(
      id: 'banana-prata-freshmart',
      productId: 'banana-prata-1kg',
      productName: 'Banana Prata',
      packaging: '1kg',
      marketName: 'FreshMart',
      branchName: 'FreshMart Central',
      price: '3.99',
    ),
    SearchDeal(
      id: 'banana-nanica-value-foods',
      productId: 'banana-nanica-1kg',
      productName: 'Banana Nanica',
      packaging: '1kg',
      marketName: 'Value Foods',
      branchName: 'Value Foods Central',
      price: '4.29',
    ),
    SearchDeal(
      id: 'banana-organica-green-grocer',
      productId: 'banana-organica-1kg',
      productName: 'Banana Orgânica',
      packaging: '1kg',
      marketName: 'Green Grocer',
      branchName: 'Green Grocer Central',
      price: '5.99',
    ),
  ];

  Future<List<SearchDeal>> search(String query) {
    if (!AppConfig.useMockData) {
      return api.search(query);
    }

    final normalizedQuery = query.trim().toLowerCase();
    return Future.value(
      _mockDeals
          .where(
            (deal) => deal.productName.toLowerCase().contains(normalizedQuery),
          )
          .toList(),
    );
  }
}
