import 'package:flutter/material.dart';
import 'cart_page.dart';
import 'home.dart';
import 'profil.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BottomNavBarExample(),
    );
  }
}

class BottomNavBarExample extends StatefulWidget {
  @override
  _BottomNavBarExampleState createState() => _BottomNavBarExampleState();
}

class _BottomNavBarExampleState extends State<BottomNavBarExample> {
  int _selectedIndex = 0;
  List<CartItem> cartItems = [];

  // Méthode pour réinitialiser le panier
  void resetCart() {
    setState(() {
      cartItems.clear();
    });
  }

  // Méthode pour ajouter un article au panier
  void addToCart(CartItem item) {
    setState(() {
      var existingItem = cartItems.firstWhere(
        (element) => element.title == item.title,
        orElse: () => CartItem(title: '', price: ''),
      );
      if (existingItem.title.isNotEmpty) {
        existingItem.quantity++;
      } else {
        cartItems.add(item);
      }
    });
  }

  // Méthode pour retirer un article du panier
  void removeFromCart(CartItem item) {
    setState(() {
      cartItems.remove(item);
    });
  }

  // Getter pour initialiser _pages
  List<Widget> get _pages => [
        Home(addToCart: addToCart),
        CartPage(
          cartItems: cartItems,
          onResetCart: resetCart,
          onRemoveItem: removeFromCart,
        ),
        Profil(),
      ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Color(0xFF156651)),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart, color: Color(0xFF156651)),
            label: 'Panier',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Color(0xFF156651)),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
