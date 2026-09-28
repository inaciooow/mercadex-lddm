import 'package:mercadex/core/config/app_config.dart';
import 'package:mercadex/features/products/data/products_api.dart';
import 'package:mercadex/features/products/domain/product_deals.dart';
import 'package:mercadex/features/products/domain/search_product.dart';

class ProductsRepository {
  const ProductsRepository({this.api = const ProductsApi()});

  final ProductsApi api;

  static const mockSearchProducts = [
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
    SearchProduct(
      id: 'coke-2l',
      name: 'Coca-Cola Original 2L',
      packaging: '2L',
    ),
    SearchProduct(id: 'arroz-5kg', name: 'Arroz Tipo 1', packaging: '5kg'),
    SearchProduct(id: 'feijao-1kg', name: 'Feijão Carioca', packaging: '1kg'),
    SearchProduct(id: 'cafe-500g', name: 'Café Tradicional', packaging: '500g'),
    SearchProduct(id: 'leite-1l', name: 'Leite Integral', packaging: '1L'),
    SearchProduct(
      id: 'macarrao-500g',
      name: 'Macarrão Espaguete',
      packaging: '500g',
    ),
    SearchProduct(
      id: 'molho-tomate-300g',
      name: 'Molho de Tomate',
      packaging: '300g',
    ),
    SearchProduct(id: 'tomate-1kg', name: 'Tomate Italiano', packaging: '1kg'),
    SearchProduct(
      id: 'peito-frango-1kg',
      name: 'Peito de Frango',
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
      mockSearchProducts
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

    final existingProduct = _mockProducts
        .where((product) => product.id == productId)
        .firstOrNull;
    if (existingProduct != null) {
      return Future.value(existingProduct);
    }

    final product = mockSearchProducts
        .where((product) => product.id == productId)
        .first;
    return Future.value(
      ProductDeals(
        id: product.id,
        name: product.name,
        packaging: product.packaging,
        deals: [
          ProductMarketDeal(
            id: '${product.id}-carrefour',
            marketId: 'freshmart',
            marketName: 'Carrefour',
            branchName: 'Carrefour Central',
            price: '9.99',
          ),
        ],
      ),
    );
  }
}
