class Product {
  final String name;
  final String description;
  final double price;
  final String image;
  final bool available;
  String? flavor; // Add flavor property

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.available,
    this.flavor, // Initialize flavor as null
  });
}
