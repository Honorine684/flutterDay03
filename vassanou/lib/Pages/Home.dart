import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() {
    return HomeSate();
  }
}

final List<Map<String, String>> categories = [
  {
    "image": "assets/images/fruit.png",
    "texte": "Crudités",
    "nom": "fruit et legume"
  },
  {
    "image": "assets/images/fruit.png",
    "texte": "Divers",
    "nom": "Lait et Sucré"
  },
  {
    "image": "assets/images/fruit.png",
    "texte": "Dinner",
    "nom": "Lait et Sucré"
  },
  {
    "image": "assets/images/fruit.png",
    "texte": "fast food",
    "nom": "Lait et Sucré"
  },
  {
    "image": "assets/images/fruit.png",
    "texte": "Dessert",
    "nom": "Lait et Sucré"
  },
  {"image": "assets/images/fruit.png", "texte": "Sain", "nom": "Lait et Sucré"},
  {"image": "assets/images/fruit.png", "texte": "Plus", "nom": "Lait et Sucré"}
];

final List<Map<String, String>> products = [
  {
    "image": "assets/images/tomate.jpg",
    "texte": "Tomate solide",
    "auteur": "10kg",
    "prix": "\$12.32"
  },
  {
    "image": "assets/images/tomate.jpg",
    "texte": "Tomate solide",
    "auteur": "10kg",
    "prix": "\$12.32"
  },
  {
    "image": "assets/images/tomate.jpg",
    "texte": "Tomate solide",
    "auteur": "10kg",
    "prix": "\$12.32"
  },
  {
    "image": "assets/images/tomate.jpg",
    "texte": "Tomate solide",
    "auteur": "10kg",
    "prix": "\$12.32"
  },
  {
    "image": "assets/images/tomate.jpg",
    "texte": "Tomate solide",
    "auteur": "10kg",
    "prix": "\$12.32"
  },
  {
    "image": "assets/images/tomate.jpg",
    "texte": "Tomate solide",
    "auteur": "10kg",
    "prix": "\$12.32"
  },
  {
    "image": "assets/images/tomate.jpg",
    "texte": "Tomate solide",
    "auteur": "10kg",
    "prix": "\$12.32"
  },
];

class HomeSate extends State<Home> {
  bool voirRecherche = false;
  final searchController = TextEditingController();
  int indexSelectionne = 0;
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final largeurEcran = MediaQuery.of(context).size.width;
    final hauteurEcran = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: AnimatedCrossFade(
            firstChild: Row(
              children: [
                Icon(
                  Icons.shopping_cart_checkout,
                  color: Colors.teal.shade700,
                ),
                Text(
                  "Vassanou",
                  style: TextStyle(color: Colors.teal.shade700, fontSize: 15),
                )
              ],
            ),
            secondChild: TextField(
              keyboardType: TextInputType.text,
              cursorColor: Color(0xFF075E54),
              decoration: InputDecoration(
                hintText: 'Rechercher...',
                hintStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(80),
                  borderSide: BorderSide(width: 0, style: BorderStyle.none),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.all(10),
              ),
              controller: searchController,
            ),
            crossFadeState: voirRecherche
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: Duration(milliseconds: 300)),
        actions: [
          Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Colors.teal.shade100),
              width: largeurEcran * 0.25,
              height: hauteurEcran * 0.25,
              child: IconButton(
                  onPressed: () => setState(() {
                        voirRecherche = !voirRecherche;
                        if (!voirRecherche) {
                          searchController.clear();
                        }
                      }),
                  icon: Icon(voirRecherche ? Icons.close : Icons.search))),
          CircleAvatar(
            child: Image.asset(
              "assets/images/login.png",
              width: largeurEcran * 0.1,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
                width: largeurEcran * 0.88,
                height: hauteurEcran * 0.25,
                margin: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.teal.shade700),
                child: Row(children: [
                  SizedBox(
                    width: largeurEcran * 0.5,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: EdgeInsets.all(5),
                          child: Text(
                            "Vendez plus simplement",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(5),
                          child: Text(
                            "Avec Wassanou rencontrez plus de clients et aller plus rapidement",
                            style: TextStyle(fontSize: 10, color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: 100,
                          height: 35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xFFebb65b)),
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              "Lire plus",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                      width: largeurEcran * 0.38,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 75,
                          ),
                          Image.asset(
                            "assets/images/sac.png",
                            width: 120,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ))
                ])),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Categories",
                    textDirection: TextDirection.ltr,
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text(
                  "See all",
                  style: TextStyle(color: Colors.teal.shade700),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        indexSelectionne = index;
                      });
                    },
                    child: Container(
                        height: 30,
                        width: 150,
                        margin: EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border:
                              Border.all(color: Colors.black.withOpacity(0.2)),
                          color: indexSelectionne == index
                              ? Colors.teal.shade700
                              : Colors.white,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  categories[index]["texte"]!,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: indexSelectionne == index
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  categories[index]["nom"]!,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: indexSelectionne == index
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  height: 8,
                                  width: 100,
                                ),
                                Image.asset(
                                  categories[index]["image"]!,
                                  height: 30,
                                  width: 30,
                                ),
                              ],
                            )
                          ],
                        )),
                  ),
                )),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Vos produits",
                    textDirection: TextDirection.ltr,
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(
              height: 10,
            ),
           
               GridView.builder(
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 8,
                  childAspectRatio: 0.75,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) => Container(
                 /* width: largeurEcran * 0.4,
                  height: hauteurEcran * 0.7,*/
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color(0xFFf5f5f5)),
                  child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.start, 
                     // mainAxisSize: MainAxisSize.min, 
                    children: [
                      Row(
                        children: [
                          /*SizedBox(
                            height: 10,
                            width: 8,
                          ),*/
                          /*IconButton(
                            onPressed: (){}, 
                            icon:  Icon(
                            Icons.edit,
                            color: Color(0xFFEBB65B),
                          ),
                            ),*/
                         
                          Text(
                            "Modifier",
                            style: TextStyle(
                                fontSize: 10, color: Color(0xFFEBB65B)),
                          )
                        ],
                      ),
                      Image.asset(
                        products[index]["image"]!,
                        width: 100,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            products[index]["texte"]!,
                            style: TextStyle(
                                color: Colors.teal.shade700,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            products[index]["auteur"]!,
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                         // SizedBox(width: 8,),
                          Text(products[index]["prix"]!,
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold)),
                          
                        ],
                      ),
                      SizedBox(height: 20,width: 20,),
                      Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //SizedBox(width: 80,),
                              /*IconButton(
                                onPressed: (){

                                }, 
                                icon: Icon(Icons.delete, color: Color(0xFFE9494F)),
                                ),*/
                              
                              
                              Text("Supprimer",
                                  style: TextStyle(
                                      fontSize: 10, color: Color(0xFFE9494F))),
                            ],
                          )
                    ],
                  ),
                ),
              
            )
          ],
        ),
      ),
    );
  }
}
