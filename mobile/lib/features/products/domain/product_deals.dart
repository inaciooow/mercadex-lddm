class ProductMarketDeal {
  const ProductMarketDeal({
    required this.id,
    required this.marketId,
    required this.marketName,
    required this.branchName,
    required this.price,
  });

  final String id;
  final String marketId;
  final String marketName;
  final String branchName;
  final String price;

  factory ProductMarketDeal.fromJson(Map<String, dynamic> json) {
    final market = json['market'] as Map<String, dynamic>;
    final branch = json['branch'] as Map<String, dynamic>;

    return ProductMarketDeal(
      id: json['id'] as String,
      marketId: market['id'] as String,
      marketName: market['name'] as String,
      branchName: branch['name'] as String,
      price: json['price'] as String,
    );
  }
}

class ProductDeals {
  const ProductDeals({
    required this.id,
    required this.name,
    required this.packaging,
    required this.deals,
  });

  final String id;
  final String name;
  final String packaging;
  final List<ProductMarketDeal> deals;

  factory ProductDeals.fromJson(Map<String, dynamic> json) {
    return ProductDeals(
      id: json['id'] as String,
      name: json['name'] as String,
      packaging: json['packaging'] as String,
      deals: (json['deals'] as List<dynamic>)
          .map(
            (deal) => ProductMarketDeal.fromJson(deal as Map<String, dynamic>),
          )
          .toList(),
    );
  }
}
