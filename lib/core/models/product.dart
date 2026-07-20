class Product {
  final int id;
  final String name;
  final double price;
  Product({required this.id, required this.name, required this.price});

  Product copyWith({
    String? name,
    double? price}) {
    return
      Product(id: id,
        name: name ?? this.name,
        price: price ?? this.price);
  }
}
