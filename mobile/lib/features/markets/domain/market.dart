class Market {
  const Market({required this.id, required this.name});

  final String id;
  final String name;

  factory Market.fromJson(Map<String, dynamic> json) {
    return Market(id: json['id'] as String, name: json['name'] as String);
  }
}
