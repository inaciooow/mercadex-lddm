import 'package:mercadex/core/config/app_config.dart';
import 'package:mercadex/features/products/data/products_api.dart';
import 'package:mercadex/features/products/domain/product_deals.dart';

class ProductsRepository {
  const ProductsRepository({this.api = const ProductsApi()});

  final ProductsApi api;

  static const _mockProducts = [
    ProductDeals(
      id: 'banana-prata-1kg',
      name: 'Banana Prata',
      packaging: '1kg',
      deals: [
        ProductMarketDeal(
          id: 'banana-prata-freshmart',
          marketName: 'FreshMart',
          branchName: 'FreshMart Central',
          price: '3.99',
        ),
        ProductMarketDeal(
          id: 'banana-prata-value-foods',
          marketName: 'Value Foods',
          branchName: 'Value Foods Central',
          price: '4.19',
        ),
        ProductMarketDeal(
          id: 'banana-prata-daily-market',
          marketName: 'Daily Market',
          branchName: 'Daily Market Central',
          price: '4.49',
        ),
      ],
    ),
    ProductDeals(
      id: 'banana-nanica-1kg',
      name: 'Banana Nanica',
      packaging: '1kg',
      deals: [
        ProductMarketDeal(
          id: 'banana-nanica-value-foods',
          marketName: 'Value Foods',
          branchName: 'Value Foods Central',
          price: '4.29',
        ),
      ],
    ),
    ProductDeals(
      id: 'banana-organica-1kg',
      name: 'Banana Orgânica',
      packaging: '1kg',
      deals: [
        ProductMarketDeal(
          id: 'banana-organica-green-grocer',
          marketName: 'Green Grocer',
          branchName: 'Green Grocer Central',
          price: '5.99',
        ),
      ],
    ),
  ];

  Future<ProductDeals> getProductDeals(String productId) {
    if (!AppConfig.useMockData) {
      return api.getProductDeals(productId);
    }

    return Future.value(
      _mockProducts.where((product) => product.id == productId).first,
    );
  }
}
