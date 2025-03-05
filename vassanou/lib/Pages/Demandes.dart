import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vassanou/JsonModel/Commandes.dart';
import 'package:vassanou/Services/firebase/FirestoreServices.dart';

class Demandes extends StatefulWidget {
  const Demandes({super.key});

  @override
  State<Demandes> createState() {
    return DemandesState();
  }
}

class DemandesState extends State<Demandes> {
  bool voirRecherche = false;
  final searchController = TextEditingController();
  int indexSelectionne = 0;

  List<Commandes> commandesList = [];
  Commandes? selectedCommande;
  void loadCommande() {
    print("Démarrage du chargement des commandes...");
    Firestoreservices().getCommandes().listen((snapshot) {
      print("Données reçues: ${snapshot.docs.length} documents");
      List<Commandes> commandes = [];

      for (var doc in snapshot.docs) {
        try {
          String comId = doc.id;
          String? numCom = doc.get('numCom');
          String? prix = doc.get('prix');
          String? produitId = doc.get('produit');
          String? produitName = doc.get('nomProduit');
          String? userId = doc.get('userId');
          String? etat = doc.get('etat');
          String? photo = doc.get('photo');
          String? userName = doc.get('userName');

          print("commande trouvée: $comId (ID: $comId)");
          commandes.add(Commandes(
              idCom: comId,
              numCommande: numCom,
              produitId: produitId,
              produitName: produitName,
              prix: prix,
              userId: userId,
              etat: etat,
              photo: photo,
              userName: userName
              ));
        } catch (e) {
          print("Erreur sur un document: $e");
        }
      }

      setState(() {
        commandesList = commandes;
        print("Commandes chargées: ${commandes.length}");
      });
    }, onError: (error) {
      print("Erreur lors du chargement des commandes: $error");
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    loadCommande();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Uri what = Uri.parse('https://wa.me/+2290165435050');
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
          ],
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              SizedBox(
                height: 20,
              ),
               SizedBox(
                  height: hauteurEcran * 0.88,
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: commandesList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => Container(
                            margin: EdgeInsets.only(bottom: 20),
                            width: largeurEcran * 0.88,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.teal.shade700,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 5,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
child: Stack(
  children: [
    // Partie verte
    Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.teal.shade700,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              // Image
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(height: 35,),
                  Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage("assets/images/${commandesList[index].photo}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 10),
              
              // Texte du prix
              Text(
                "${commandesList[index].prix} FCFA",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              
                ],
              ),
              SizedBox(width: 60),
              
              // Nom du produit et état
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(height: 25,),
                    Text(
                      commandesList[index].produitName ?? '',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Etat: ${commandesList[index].etat}",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Icone WhatsApp
              GestureDetector(
                onTap: () async {
                  launchUrl(what);
                },
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    image: DecorationImage(
                      image: AssetImage("assets/images/wat.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),

    // Partie blanche en haut
    Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: [
              Text(
                "Commande N°: ",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                commandesList[index].numCommande ?? '',
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(width: 80),
              Text(
                "Client: ",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                commandesList[index].userName ?? '',
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    ),

    // Effet de coin plié
    Positioned(
      top: 0,
      right: 0,
      child: ClipPath(
        clipper: PliageClipper(),
        child: Container(
          width: 30,
          height: 30,
          color: Colors.white,
        ),
      ),
    ),
  ],
)



                          )))]))
    );
  }
}

class PliageClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height - size.width);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
