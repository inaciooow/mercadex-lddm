import 'dart:convert';

import 'package:mercadex/core/network/api_client.dart';
import 'package:mercadex/features/deals/domain/search_deal.dart';

class DealsApi {
  const DealsApi({this.client = const ApiClient()});

  final ApiClient client;

  Future<List<SearchDeal>> search(String query) async {
    final response = await client.get(
      '/search?query=${Uri.encodeQueryComponent(query)}',
    );

    if (response.statusCode != 200) {
      throw StateError('Could not load deals.');
    }

    final data = jsonDecode(response.body) as List<dynamic>;
    return data
        .map((item) => SearchDeal.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
