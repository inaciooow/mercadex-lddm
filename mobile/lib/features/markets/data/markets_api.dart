import 'dart:convert';

import 'package:mercadex/core/network/api_client.dart';
import 'package:mercadex/features/markets/domain/market.dart';

class MarketsApi {
  const MarketsApi({this.client = const ApiClient()});

  final ApiClient client;

  Future<List<Market>> getMarkets() async {
    final response = await client.get('/markets');

    if (response.statusCode != 200) {
      throw StateError('Could not load markets.');
    }

    final data = jsonDecode(response.body) as List<dynamic>;
    return data
        .map((item) => Market.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
