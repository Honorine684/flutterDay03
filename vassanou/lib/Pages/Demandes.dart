import 'package:flutter/material.dart';

class Demandes extends StatefulWidget{
  const Demandes({super.key});

  @override
  State<Demandes> createState() {
  return DemandesState();
  }
  
}
final List<Map<String, String>> demandes = [
  {
    "image": "assets/images/tomate.jpg",
    "texte": "Tomate solide",
    "quantite": "10kg",
    "prix": "\$12.32",
    "interresse":"Honor",
    "mesure":"dix"
  },
    {
    "image":"assets/images/tomate.jpg",
    "texte":"Tomate solide",
    "quantite":"10kg",
    "prix":"\$12.32",
    "interresse":"Honor",
    "mesure":"dix"
  },
    {
"image": "assets/images/tomate.jpg",
    "texte": "Tomate solide",
    "quantite": "10kg",
    "prix": "\$12.32",
    "interresse":"Honor",
    "mesure":"dix kg"
  },
  {
    "image": "assets/images/tomate.jpg",
    "texte": "Tomate solide",
    "quantite": "10kg",
    "prix": "\$12.32",
    "interresse":"Honor",
    "mesure":"dix"
  },
    {
    "image": "assets/images/tomate.jpg",
    "texte": "Tomate solide",
    "quantite":"10kg",
    "prix": "\$12.32",
    "interresse":"Honor",
    "mesure":"dix"
  },
    {
    "image": "assets/images/tomate.jpg",
    "texte": "Tomate solide",
    "quantite": "10kg",
    "prix": "\$12.32",
    "interresse":"Honor",
    "mesure":"dix"
  },
    {
    "image": "assets/images/tomate.jpg",
    "texte": "Tomate solide",
    "quantite":"10kg",
    "prix": "\$12.32",
    "interresse":"Honor",
    "mesure":"dix"
  },
];

class DemandesState extends State<Demandes>{
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
          
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Text("Vos demandes",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
            ),
            SizedBox(height: 20,),
            SizedBox(
              height: hauteurEcran * 0.88,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: demandes.length,
                shrinkWrap: true,
                itemBuilder: (context, index) => Row(
                  children: [
                    Card(
                      margin: EdgeInsets.only(bottom: 30),
                      elevation: 7,
                      child: Container(
                      width: largeurEcran*0.86,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.teal.shade700,
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 10,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                      height: 60,
                      width: 60,
                      margin: EdgeInsets.only(right: 10, bottom: 10),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage(demandes[index]["image"]!),
                              fit: BoxFit.cover)),
                    ),
                    Text(demandes[index]["prix"]!,
                        style: TextStyle(fontSize: 17,
                        color: Colors.white),
                        )
                          ],
                        ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //SizedBox(height: 10,),
                        Text(demandes[index]["texte"]!,
                        style: TextStyle(fontSize: largeurEcran*0.04,
                        fontWeight: FontWeight.bold,color: Colors.white),
                        ),
                        Text(demandes[index]["prix"]!,
                        style: TextStyle(fontSize: 12,
                        color: Colors.white),
                        )
                        
                      ],

                    ),
                    SizedBox(width: 80,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                       Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle
                        ),
                        
                        child: IconButton(
                        onPressed:()=>{}, 
                        icon: Icon(Icons.sell_outlined)),
                       ),
                       Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle
                        ),
                        
                        child: IconButton(
                        onPressed:()=>{
                          
                        }, 
                        icon: Icon(Icons.message)),
                       )

                          
                            
                        
                  
                      ],

                    ),
                        ],
                      ),
                      ))
                    /*Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          demandes[index]["texte"]!,
                          style: TextStyle(
                              fontSize: largeurEcran * 0.04,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          demandes[index]["quantite"]!,
                          style: TextStyle(fontSize: 12, color: Colors.black87),
                        ),
                      ],
                    ),*/
                  //  Spacer(),
                   /* Column(
                      children: [
                        Text(demandes[index]["prix"]!,
                            style: TextStyle(
                                fontSize: largeurEcran * 0.04,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue)),
                        Text(
                          demandes[index]["interresse"]!,
                          style: TextStyle(fontSize: 12, color: Colors.black87),
                        ),
                      ],
                    )*/
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
  
}