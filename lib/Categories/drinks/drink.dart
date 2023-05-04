class Drink {
  final String id;
  final String name;
  final String description;
  final String image;
  final double price;
  final bool available;
  final List<Flavor> flavors;

  const Drink({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.available,
    required this.flavors,
  });

  Flavor getFlavorById(String id) {
    return flavors.firstWhere((flavor) => flavor.id == id,
        orElse: () => const Flavor(id: '', name: ''));
  }
}

class Flavor {
  final String id;
  final String name;

  const Flavor({
    required this.id,
    required this.name,
  });
}
