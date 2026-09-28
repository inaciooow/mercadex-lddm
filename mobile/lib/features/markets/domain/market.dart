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

class MarketDetail extends Market {
  const MarketDetail({
    required super.id,
    required super.name,
    required this.branches,
  });

  final List<MarketBranch> branches;

  factory MarketDetail.fromJson(Map<String, dynamic> json) {
    return MarketDetail(
      id: json['id'] as String,
      name: json['name'] as String,
      branches: (json['branches'] as List<dynamic>)
          .map(
            (branch) => MarketBranch.fromJson(branch as Map<String, dynamic>),
          )
          .toList(),
    );
  }
}
