import 'dart:convert';

import 'package:mercadex/core/network/api_client.dart';
import 'package:mercadex/features/products/domain/product_deals.dart';

class ProductsApi {
  const ProductsApi({this.client = const ApiClient()});

  final ApiClient client;

  Future<ProductDeals> getProductDeals(String productId) async {
    final response = await client.get('/products/$productId/deals');

    if (response.statusCode != 200) {
      throw StateError('Could not load product deals.');
    }

    return ProductDeals.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>,
    );
  }
}
