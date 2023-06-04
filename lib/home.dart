import 'package:flutter/material.dart';
import 'package:sos_restau/Categories/alimentation.dart';
import 'package:sos_restau/Categories/boissons.dart';
import 'package:sos_restau/Categories/categories.dart';
import 'package:sos_restau/Categories/fruits.dart';
import 'package:sos_restau/Categories/hygiene.dart';
import 'package:sos_restau/Categories/legumes.dart';
import 'package:sos_restau/Categories/pain_c.dart';
import 'package:sos_restau/Categories/viande.dart';
import 'package:sos_restau/historique.dart';
import 'package:sos_restau/panier.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sos_restau/profile.dart';
import 'Categories/produits_laitiers.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  void _goToHome(BuildContext context, String userId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

  void _goToPanier(BuildContext context, String userId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CartPage(userId: userId)),
    );
  }

  void _goToCommandes(BuildContext context, String userId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OrderHistoryPage(userId: userId)),
    );
  }

  void _goToProfile(BuildContext context, String userId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProfilePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid ?? '';
    TextEditingController searchController = TextEditingController();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Row(
              children: const [
                Text('Sos REstau'),
              ],
            ),
            actions: const [
              CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://randomuser.me/api/portraits/men/1.jpg',
                ),
              ),
              Text('John Doe'),
              SizedBox(width: 16),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(48),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Recherche des produits',
                    filled: true,
                    fillColor: Colors.white,
                    suffixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ),
              ),
            ),
          ),
          backgroundColor: const Color.fromARGB(150, 255, 239, 190),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width *
                        0.6, // Take 60% of the screen width
                    child: Container(
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromARGB(255, 83, 110, 232),
                            Color.fromARGB(255, 21, 38, 190)
                          ],
                        ),
                      ),
                      child: Stack(
                        children: [
                          Opacity(
                            opacity: 0.5,
                            child: Image.network(
                              "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/BACKGROUND%202.png?alt=media&token=0d003860-ba2f-4782-a5ee-5d5684cdc244",
                              fit: BoxFit.cover,
                            ),
                          ),
                          Image.network(
                            "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/Image.png?alt=media&token=8256c357-cf86-4f76-8c4d-4322d1ebc06c",
                          ),
                          const Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: EdgeInsets.all(25.0),
                              child: Text(
                                "Promo\néte",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 1,
                          child: Text(
                            'Catégories',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AllCategoriesPage()),
                                );
                              },
                              child: const Text('Voir Tout',
                                  style: TextStyle(color: Colors.blue),
                                  textAlign: TextAlign.end),
                            )),
                      ],
                    )),
                SizedBox(
                  height: 260, // Adjust the height as needed
                  child: GridView.count(
                    crossAxisCount: 4, // Number of columns
                    childAspectRatio: 1.0, // Width to height ratio of each item
                    padding: const EdgeInsets.all(8),
                    children: [
                      _CategoryCard(
                        image: 'assets/images/fruits.jpg',
                        title: 'Fruits',
                        onTap: () => _goToFruitsCategoryPage(context),
                      ),
                      _CategoryCard(
                        image: 'assets/images/veggies.jpg',
                        title: 'Légumes',
                        onTap: () => _goToVeggiesCategoryPage(context),
                      ),
                      _CategoryCard(
                        image: 'assets/images/bread.jpg',
                        title: 'Pain',
                        onTap: () => _goToBreadCategoryPage(context),
                      ),
                      _CategoryCard(
                        image: 'assets/images/drinks.jpg',
                        title: 'Boissons',
                        onTap: () => _goToDrinksCategoryPage(context),
                      ),
                      _CategoryCard(
                        image: 'assets/images/grocery.jpg',
                        title: 'Allimentation',
                        onTap: () => _goToGroceryCategoryPage(context),
                      ),
                      _CategoryCard(
                        image: 'assets/images/meat.jpg',
                        title: 'Viande',
                        onTap: () => _goToMeatCategoryPage(context),
                      ),
                      _CategoryCard(
                        image: 'assets/images/dairy.jpg',
                        title: 'Produits liatter',
                        onTap: () => _goToDairyCategoryPage(context),
                      ),
                      _CategoryCard(
                        image: 'assets/images/hygiene.jpg',
                        title: 'Hygiene',
                        onTap: () => _goToHygieneCategoryPage(context),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            color: const Color.fromARGB(255, 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  color: const Color.fromARGB(150, 255, 239, 190),
                  onPressed: () {
                    _goToHome;
                  },
                  icon: const Icon(Icons.home),
                ),
                IconButton(
                  color: const Color.fromARGB(150, 255, 239, 190),
                  onPressed: () {
                    _goToPanier(context, userId);
                  },
                  icon: const Icon(Icons.shopping_cart),
                ),
                IconButton(
                  color: const Color.fromARGB(150, 255, 239, 190),
                  onPressed: () {
                    _goToCommandes(context, userId);
                  },
                  icon: const Icon(Icons.history),
                ),
                IconButton(
                  color: const Color.fromARGB(150, 255, 239, 190),
                  onPressed: () {
                    _goToProfile(context, userId);
                  },
                  icon: const Icon(Icons.person),
                ),
              ],
            ),
          )),
    );
  }
}

void _goToFruitsCategoryPage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const FruitCategoryPage()),
  );
}

void _goToBreadCategoryPage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => BreadCategoryPage()),
  );
}

void _goToDairyCategoryPage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const DairyCategoryPage()),
  );
}

void _goToMeatCategoryPage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => MeatCategoryPage()),
  );
}

void _goToGroceryCategoryPage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const GroceryCategoryPage()),
  );
}

void _goToVeggiesCategoryPage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const VegetablesCategoryPage()),
  );
}

void _goToHygieneCategoryPage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => HygieneCategoryPage()),
  );
}

void _goToDrinksCategoryPage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const DrinkCategoryPage()),
  );
}

class _CategoryCard extends StatelessWidget {
  final String image;
  final String title;
  final VoidCallback onTap;

  const _CategoryCard({
    Key? key,
    required this.image,
    required this.title,
    required this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: SizedBox(
            width: 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      image,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
        ));
  }
}
