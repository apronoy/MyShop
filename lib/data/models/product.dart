class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final bool isFavorite;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.isFavorite = false,
  });

  Product copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    bool? isFavorite,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
