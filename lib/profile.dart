// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:sos_restau/home.dart';

int _selectedIndex = 0;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final List<String> _menuItems = [
    'Order History',
    'Change Theme',
    'Manage Settings',
    'Statistics',
    'Contact Us',
  ];

  Widget _buildMenuItem(String title, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        height: 50.0,
        color: _selectedIndex == index ? Colors.grey[200] : null,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: _selectedIndex == index ? FontWeight.bold : null,
          ),
        ),
      ),
    );
  }

  Widget _buildSelectedView() {
    switch (_selectedIndex) {
      case 0:
        return const Center(
          child: Text('Order History'),
        );
      case 1:
        return const Center(
          child: Text('Change Theme'),
        );
      case 2:
        return const Center(
          child: Text('Manage Settings'),
        );
      case 3:
        return const Center(
          child: Text('Statistics'),
        );
      case 4:
        return const Center(
          child: Text('Contact Us'),
        );
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: Row(
          children: [
            Container(
              width: 200.0,
              child: ListView.builder(
                itemCount: _menuItems.length,
                itemBuilder: (BuildContext context, int index) {
                  return _buildMenuItem(_menuItems[index], index);
                },
              ),
            ),
            const VerticalDivider(),
            Expanded(
              child: _buildSelectedView(),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.orange.shade50,
          items: const [
            BottomNavigationBarItem(
              activeIcon: HomePage(),
              icon: Icon(Icons.home),
              label: 'Accueil',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Panier',
            ),
            BottomNavigationBarItem(
              activeIcon: ProfilePage(),
              icon: Icon(Icons.person),
              label: 'Profil',
            ),
          ],
        ));
  }
}
