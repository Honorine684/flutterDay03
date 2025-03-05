import 'package:flutter/material.dart';
import 'cart_page.dart';

class Home extends StatelessWidget {
  final Function(CartItem) addToCart;

  Home({required this.addToCart});

  @override
  Widget build(BuildContext context) {
    final List<String> cities = [
      'Marché de Cadjèhoun',
      'Marché Aïdjèdo',
      'Marché de Gbégamey',
      'Marché de Mènontin',
      'Marché de Wologuèdè',
      'Marché de Tokplégbé',
      'Marché de Midombo',
      'Marché de PK3',
      'Marché de Sainte Trinité',
    ];

    final Map<String, List<Map<String, String>>> categoryItems = {
      'Ustensiles': [
        {'image': 'assets/dish.jpg', 'title': 'Ustensile 1', 'price': '500 CFA'},
        {'image': 'assets/dish.jpg', 'title': 'Ustensile 2', 'price': '700 CFA'},
        {'image': 'assets/dish.jpg', 'title': 'Ustensile 3', 'price': '900 CFA'},
        {'image': 'assets/dish.jpg', 'title': 'Ustensile 4', 'price': '1200 CFA'},
      ],
      'Produits congelés': [
        {'image': 'assets/poisson.jpg', 'title': 'Congelé 1', 'price': '1500 CFA'},
        {'image': 'assets/poisson.jpg', 'title': 'Congelé 2', 'price': '2000 CFA'},
        {'image': 'assets/poisson.jpg', 'title': 'Congelé 3', 'price': '2500 CFA'},
        {'image': 'assets/poisson.jpg', 'title': 'Congelé 4', 'price': '3000 CFA'},
      ],
      'Fruits': [
        {'image': 'assets/tomato.jpg', 'title': 'Fruit 1', 'price': '500 CFA'},
        {'image': 'assets/tomato.jpg', 'title': 'Fruit 2', 'price': '700 CFA'},
        {'image': 'assets/tomato.jpg', 'title': 'Fruit 3', 'price': '900 CFA'},
        {'image': 'assets/tomato.jpg', 'title': 'Fruit 4', 'price': '1200 CFA'},
      ],
      'Légumes': [
        {'image': 'assets/panierfruit.jpg', 'title': 'Légume 1', 'price': '500 CFA'},
        {'image': 'assets/panierfruit.jpg', 'title': 'Légume 2', 'price': '700 CFA'},
        {'image': 'assets/panierfruit.jpg', 'title': 'Légume 3', 'price': '900 CFA'},
        {'image': 'assets/panierfruit.jpg', 'title': 'Légume 4', 'price': '1200 CFA'},
      ],
      'viande/poissons': [
        {'image': 'assets/poisson.jpg', 'title': 'Poisson 1', 'price': '1500 CFA'},
        {'image': 'assets/poisson.jpg', 'title': 'Poisson 2', 'price': '2000 CFA'},
        {'image': 'assets/poisson.jpg', 'title': 'Poisson 3', 'price': '2500 CFA'},
        {'image': 'assets/poisson.jpg', 'title': 'Poisson 4', 'price': '3000 CFA'},
      ],
    };

    String selectedCity = cities.first; // Texte par défaut du dropdown
    String selectedCategory = 'Ustensiles'; // Catégorie par défaut

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF156651),
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.location_on, color: Color.fromARGB(255, 241, 243, 242)),
                SizedBox(width: 5),
                DropdownButton<String>(
                  value: selectedCity,
                  items: cities.map((String city) {
                    return DropdownMenuItem<String>(
                      value: city,
                      child: Text(
                        city,
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    selectedCity = value!;
                  },
                  style: TextStyle(color: Colors.white),
                  icon: Icon(Icons.arrow_drop_down, color: Colors.white),
                  dropdownColor: Color(0xFF156651),
                ),
              ],
            ),
            Icon(Icons.notifications, color: Color.fromARGB(255, 241, 243, 242)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Rechercher un produit',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Icon(Icons.settings, size: 30, color: Color(0xFF156651)),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Container(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildProductContainer('assets/tomato.jpg', 'Tomates Fraîches', '1 kg - 1200 CFA', isTopSection: true),
                    _buildProductContainer('assets/dish.jpg', 'Dish', '1 - 5000 CFA', isTopSection: true),
                    _buildProductContainer('assets/platscok.jpg', 'Assiette en coquille', '1 - 1000 CFA', isTopSection: true),
                    _buildProductContainer('assets/panierfruit.jpg', 'Panier Bio', '1 panier - 2500 CFA', isTopSection: true),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0), // Ajout de padding pour l'intervalle
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Catégorie', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text('Voir tout', style: TextStyle(color: Colors.blue)),
                ],
              ),
            ),
            Container(
              height: 105,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildCategoryContainer(Icons.kitchen, 'Ustensiles', isSelected: selectedCategory == 'Ustensiles', onTap: () {
                    selectedCategory = 'Ustensiles';
                  }),
                  _buildCategoryContainer(Icons.ac_unit, 'viande/poissons', isSelected: selectedCategory == 'viande/poissons', onTap: () {
                    selectedCategory = 'viande/poissons';
                  }),
                  _buildCategoryContainer(Icons.apple, 'Fruits', isSelected: selectedCategory == 'Fruits', onTap: () {
                    selectedCategory = 'Fruits';
                  }),
                  _buildCategoryContainer(Icons.grass, 'Légumes', isSelected: selectedCategory == 'Légumes', onTap: () {
                    selectedCategory = 'Légumes';
                  }),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Articles de la catégorie : $selectedCategory',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.7,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: categoryItems[selectedCategory]!.map((item) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[200],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                              child: Image.asset(
                                item['image']!,
                                height: 100,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item['title']!, style: TextStyle(fontWeight: FontWeight.bold)),
                                  SizedBox(height: 5),
                                  Text(item['price']!, style: TextStyle(color: Colors.grey[700])),
                                ],
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                addToCart(CartItem(
                                  title: item['title']!,
                                  price: item['price']!,
                                ));
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                minimumSize: Size(60, 25),
                              ),
                              child: Text('Acheter', style: TextStyle(fontSize: 10)),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductContainer(String imagePath, String title, String price, {bool isTopSection = false}) {
    return Container(
      width: isTopSection ? 140 : 100,
      margin: EdgeInsets.only(right: isTopSection ? 10 : 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[200],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            child: Image.asset(
              imagePath,
              height: isTopSection ? 120 : 100,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Text(price, style: TextStyle(color: Colors.grey[700])),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryContainer(IconData icon, String title, {required bool isSelected, required Function onTap}) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        width: 100,
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isSelected ? Colors.grey[400] : Colors.grey[200],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Color(0xFF156651)),
            SizedBox(height: 5),
            Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}