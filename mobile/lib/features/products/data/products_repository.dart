import 'package:mercadex/core/config/app_config.dart';
import 'package:mercadex/features/products/data/products_api.dart';
import 'package:mercadex/features/products/domain/product_deals.dart';
import 'package:mercadex/features/products/domain/search_product.dart';

class ProductsRepository {
  const ProductsRepository({this.api = const ProductsApi()});

  final ProductsApi api;

  static const _mockSearchProducts = [
    SearchProduct(
      id: 'banana-prata-1kg',
      name: 'Banana Prata',
      packaging: '1kg',
    ),
    SearchProduct(
      id: 'banana-nanica-1kg',
      name: 'Banana Nanica',
      packaging: '1kg',
    ),
    SearchProduct(
      id: 'banana-organica-1kg',
      name: 'Banana Orgânica',
      packaging: '1kg',
    ),
  ];

  static const _mockProducts = [
    ProductDeals(
      id: 'banana-prata-1kg',
      name: 'Banana Prata',
      packaging: '1kg',
      deals: [
        ProductMarketDeal(
          id: 'banana-prata-freshmart',
          marketId: 'freshmart',
          marketName: 'Carrefour',
          branchName: 'Carrefour Central',
          price: '3.99',
        ),
        ProductMarketDeal(
          id: 'banana-prata-value-foods',
          marketId: 'value-foods',
          marketName: 'Pão de Açúcar',
          branchName: 'Pão de Açúcar Central',
          price: '4.19',
        ),
        ProductMarketDeal(
          id: 'banana-prata-daily-market',
          marketId: 'daily-market',
          marketName: 'Atacadão',
          branchName: 'Atacadão Central',
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
          marketId: 'value-foods',
          marketName: 'Pão de Açúcar',
          branchName: 'Pão de Açúcar Central',
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
          marketId: 'green-grocer',
          marketName: 'Assaí Atacadista',
          branchName: 'Assaí Atacadista Central',
          price: '5.99',
        ),
      ],
    ),
  ];

  Future<List<SearchProduct>> search(String query) {
    if (!AppConfig.useMockData) {
      return api.search(query);
    }

    final normalizedQuery = query.trim().toLowerCase();
    return Future.value(
      _mockSearchProducts
          .where(
            (product) => product.name.toLowerCase().contains(normalizedQuery),
          )
          .toList(),
    );
  }

  Future<ProductDeals> getProductDeals(String productId) {
    if (!AppConfig.useMockData) {
      return api.getProductDeals(productId);
    }

    return Future.value(
      _mockProducts.where((product) => product.id == productId).first,
    );
  }
}
