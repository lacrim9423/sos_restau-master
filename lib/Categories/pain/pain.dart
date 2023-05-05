class Bread {
  final String id;
  final String name;
  final String description;
  final String image;
  final double price;
  final bool available;
  final int increment;

  const Bread({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.available,
    required this.increment,
  });
}

final List<Bread> _breads = [
  const Bread(
    id: '1',
    name: 'Baguette',
    description:
        'Traditionnal French bread, perfect for sandwiches or with cheese.',
    image: 'assets/images/baguette.png',
    price: 1.99,
    available: true,
    increment: 10,
  ),
  const Bread(
    id: '2',
    name: 'Tortilla',
    description: 'Thin and soft flatbread, ideal for wraps or quesadillas.',
    image: 'assets/images/tortilla.png',
    price: 2.49,
    available: true,
    increment: 10,
  ),
  const Bread(
    id: '3',
    name: 'Chawarma',
    description: 'Middle Eastern flatbread, perfect for shawarmas or falafels.',
    image: 'assets/images/chawarma.png',
    price: 1.5,
    available: false,
    increment: 10,
  ),
  const Bread(
    id: '4',
    name: 'Kesra',
    description: 'Traditional Algerian flatbread, great with dips or stews.',
    image: 'assets/images/kesra.png',
    price: 2.99,
    available: true,
    increment: 10,
  ),
  const Bread(
    id: '5',
    name: 'Petit pain',
    description: 'Small French bread, perfect for breakfast or with soup.',
    image: 'assets/images/petit_pain.png',
    price: 0.99,
    available: true,
    increment: 10,
  ),
  const Bread(
    id: '6',
    name: 'Pain maison',
    description: 'Homemade bread, made with love and patience.',
    image: 'assets/images/pain_maison.png',
    price: 3.99,
    available: true,
    increment: 10,
  ),
  const Bread(
    id: '7',
    name: 'Chapati',
    description: 'Indian flatbread, perfect for curries or chutneys.',
    image: 'assets/images/chapati.png',
    price: 1.49,
    available: true,
    increment: 10,
  ),
];
