import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vassanou/JsonModel/CategorieProduit.dart';
import 'package:vassanou/JsonModel/Produit.dart';
import 'package:vassanou/Pages/PageDetailsProduits.dart';
import 'package:vassanou/Pages/editPage.dart';
import 'package:vassanou/Services/firebase/Auth.dart';
import 'package:vassanou/Services/firebase/FirestoreServices.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() {
    return HomeSate();
  }
}


class HomeSate extends State<Home> {
  bool voirRecherche = false;
  final searchController = TextEditingController();
  int indexSelectionne = 0;
  List<Produit> produits = [];
  String? userCategorieCommerceId;
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
 @override
  void initState() {
    super.initState();
    getUserCategorieCommerce();
    loadProduits("");
  }
void loadProduits(String selectedCategorieId) {
  print("Chargement des produits pour la catégorie: $selectedCategorieId");
  
  Firestoreservices().getProduits().listen((snapshot) {
    print("Données reçues: ${snapshot.docs.length} produits");
    List<Produit> listeProduits = [];

    for (var doc in snapshot.docs) {
      try {
        // Filtrer par catégorie si une catégorie est sélectionnée
        if (selectedCategorieId.isEmpty || doc.get('categorieProduitId') == selectedCategorieId) {
          String produitId = doc.id;
          String categorieProduitId = doc.get('categorieProduitId');
          String categorieProduitLibelle = doc.get('categorieProduitLibelle');
          String nom = doc.get('nom');
          String description = doc.get('description');
          String idMesure = doc.get('idMesure');
          String uniteMesure = doc.get('uniteMesure');
          double prixUnitaire = doc.get('prixUnitaire').toDouble();
          String photo = doc.get('photo');
          String userId = doc.get('userId');

          // Vérifier si le produit appartient à l'utilisateur actuel
          final User? currentUser = Auth().currentUser;
          if (currentUser != null && userId == currentUser.uid) {
            listeProduits.add(Produit(
              id: produitId,
              categorieProduitId: categorieProduitId,
              categorieProduitLibelle: categorieProduitLibelle,
              nom: nom,
              description: description,
              idMesure: idMesure,
              uniteMesure: uniteMesure,
              prixUnitaire: prixUnitaire,
              photo: photo,
              userId: userId,
            ));
          }
        }
      } catch (e) {
        print("Erreur sur un document produit: $e");
      }
    }

    setState(() {
      produits = listeProduits;
      print("Produits chargés: ${produits.length}");
    });
  }, onError: (error) {
    print("Erreur lors du chargement des produits: $error");
  });
}

  void getUserCategorieCommerce() async {
    try {
      // Récupérer l'utilisateur actuellement connecté
      final User? user = Auth().currentUser;
      if (user != null) {
        // Récupérer les données de l'utilisateur depuis Firestore
        final userData = await Firestoreservices().getUserData(user.uid);
        if (userData != null && userData.exists) {
          final categorieCommerceId = userData.get('categorieId');
          setState(() {
            userCategorieCommerceId = categorieCommerceId;
            print("Catégorie de commerce de l'utilisateur: $userCategorieCommerceId");
            
            // Maintenant que nous avons l'ID, chargeons les catégories de produits
            if (userCategorieCommerceId != null) {
              loadCategories(userCategorieCommerceId!);
            }
          });
        }
      }
    } catch (e) {
      print("Erreur lors de la récupération de la catégorie de commerce: $e");
    }
  }
  
  List<Categorieproduit> categorieproduit = [];
  Categorieproduit? selectedProduit;
  void loadCategories(String categorieCommerceId) {
    print("Démarrage du chargement des catégories...");
    Firestoreservices().getCategorieProduit().listen((snapshot) {
      print("Données reçues: ${snapshot.docs.length} documents");
      List<Categorieproduit> categories = [];

      for (var doc in snapshot.docs) {
        if(categorieCommerceId == doc.get('categorieCommerceId')){
          try {

          
          String categoryId = doc.id;
          String categorieCommerceId = doc.get('categorieCommerceId');
          String libelle = doc.get('libcat'); 
          String description = doc.get('description');
          String photo = doc.get('photo');


          print("Catégorie trouvée: $libelle (ID: $categoryId)");
          categories
              .add(Categorieproduit(
              id: categoryId, 
              categorieCommerceId: categorieCommerceId,
              libelle: libelle,
              description: description,
              photo: photo,
              ));
        } catch (e) {
          print("Erreur sur un document: $e");
        }
        }
        
      }

      setState(() {
        categorieproduit = categories;
        print("Catégories chargées: ${categories.length}");
        if (categories.isNotEmpty && selectedProduit == null) {
          selectedProduit = categories[0];
          print("Catégorie par défaut: ${selectedProduit?.libelle}");
        }
      });
    }, onError: (error) {
      print("Erreur lors du chargement des catégories: $error");
    });
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
                  itemCount: categorieproduit.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        indexSelectionne = index;
                        selectedProduit = categorieproduit[index];
                        loadProduits(selectedProduit!.id);
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
                                categorieproduit[index].libelle,
                                  
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
                                  categorieproduit[index].description,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: indexSelectionne == index
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                  overflow: TextOverflow.ellipsis,
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
                                  "assets/images/${categorieproduit[index].photo}",
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
                itemCount: produits.length,
                itemBuilder: (context, index) => 
                GestureDetector(
                  onTap: () => 
                  Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>PageDetailsProduits(produit: produits[index]),
        ),
      ),
                  child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.black.withOpacity(0.2)),
                      ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(onPressed: (){
                            Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>Editpage(produit: produits[index]),
        ),
      );
                          },
                          icon: Icon(Icons.edit,color: Color(0xffE9494F),))
                        ],
                      ),
                      Image.asset(
                        "assets/images/${produits[index].photo}",
                        width: 100,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                      Text(
                            produits[index].nom,
                            style: TextStyle(
                                color: Colors.teal.shade700,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          
                          Text("en ${produits[index].uniteMesure}",
                              style: TextStyle(
                                  fontSize: 10, )),
                      
                      SizedBox(height: 12,),
                      Row(
                            children: [
                              SizedBox(width: 5,),
                              Text(
                            NumberFormat.simpleCurrency().format(produits[index].prixUnitaire),
                            style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                              IconButton(
                                onPressed: (){
                                  Firestoreservices().deleteProduit(produits[index].id);
                                }, 
                                icon: Icon(Icons.delete, color: Color(0xFFE9494F)),
                                ),
                              
                            ],
                          )
                    ],
                  ),
                ),
                )
              
            )
          ],
        ),
      ),
    );
  }
}
