class DairyProduct {
  final String id;
  final String name;
  final String description;
  final String image;
  final double price;
  final bool available;
  final List<Unit> units;
  final bool isLiquid;

  const DairyProduct({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.available,
    required this.units,
    required this.isLiquid,
  });

  Unit getUnitById(String id) {
    return units.firstWhere((unit) => unit.id == id,
        orElse: () => const Unit(id: '', name: ''));
  }
}

class Unit {
  final String id;
  final String name;

  const Unit({
    required this.id,
    required this.name,
  });

  static const Unit kilogram = Unit(id: 'kg', name: 'Kilogramme');
  static const Unit pack = Unit(id: 'p', name: 'pack ');
}
