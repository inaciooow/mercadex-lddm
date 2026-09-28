class SearchProduct {
  const SearchProduct({
    required this.id,
    required this.name,
    required this.packaging,
  });

  final String id;
  final String name;
  final String packaging;

  factory SearchProduct.fromJson(Map<String, dynamic> json) {
    return SearchProduct(
      id: json['id'] as String,
      name: json['name'] as String,
      packaging: json['packaging'] as String,
    );
  }
}
