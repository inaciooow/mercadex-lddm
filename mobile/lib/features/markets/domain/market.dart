class Market {
  const Market({required this.id, required this.name});

  final String id;
  final String name;

  factory Market.fromJson(Map<String, dynamic> json) {
    return Market(id: json['id'] as String, name: json['name'] as String);
  }
}

class MarketBranch {
  const MarketBranch({
    required this.id,
    required this.name,
    required this.address,
  });

  final String id;
  final String name;
  final String address;

  factory MarketBranch.fromJson(Map<String, dynamic> json) {
    return MarketBranch(
      id: json['id'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
    );
  }
}

class MarketProduct {
  const MarketProduct({
    required this.id,
    required this.name,
    required this.packaging,
  });

  final String id;
  final String name;
  final String packaging;

  factory MarketProduct.fromJson(Map<String, dynamic> json) {
    return MarketProduct(
      id: json['id'] as String,
      name: json['name'] as String,
      packaging: json['packaging'] as String,
    );
  }
}

class MarketDetail extends Market {
  const MarketDetail({
    required super.id,
    required super.name,
    required this.branches,
    required this.products,
  });

  final List<MarketBranch> branches;
  final List<MarketProduct> products;

  factory MarketDetail.fromJson(Map<String, dynamic> json) {
    return MarketDetail(
      id: json['id'] as String,
      name: json['name'] as String,
      branches: (json['branches'] as List<dynamic>)
          .map(
            (branch) => MarketBranch.fromJson(branch as Map<String, dynamic>),
          )
          .toList(),
      products: (json['products'] as List<dynamic>)
          .map(
            (product) =>
                MarketProduct.fromJson(product as Map<String, dynamic>),
          )
          .toList(),
    );
  }
}
