import 'package:ahigan/dafaults/defaults.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Commande extends StatefulWidget {
  const Commande({super.key});

  @override
  State<Commande> createState() => _MarketInformationsState();
}

class _MarketInformationsState extends State<Commande> {
  bool _showMarketsWithoutManager = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Commandes')),
      body: Padding(
        padding: EdgeInsets.all(17),
        child: Column(
          children: [
            SizedBox(height: 20),
            /*Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 1),
                Center(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    height: 50,
                    width: 230,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Color(0xFF9fd5cd)),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _showMarketsWithoutManager = true;
                            });
                          },
                          child: Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color:
                                  _showMarketsWithoutManager
                                      ? Defaults.selectbuton
                                      : Defaults.ianctivebuton,
                            ),
                            child: Center(
                              child: Text(
                                'Non',
                                style: TextStyle(
                                  color:
                                      _showMarketsWithoutManager
                                          ? Defaults.drawerItemSelectedColor
                                          : Defaults.inactivetext,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(width: 12),

                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _showMarketsWithoutManager = false;
                            });
                          },
                          child: Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color:
                                  !_showMarketsWithoutManager
                                      ? Defaults.selectbuton
                                      : Defaults.ianctivebuton,
                            ),
                            child: Center(
                              child: Text(
                                'livrée',
                                style: TextStyle(
                                  color:
                                      !_showMarketsWithoutManager
                                          ? Defaults.drawerItemSelectedColor
                                          : Defaults.inactivetext,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            */

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance
                        .collection('commandes')
                        .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Quelque chose s\'est mal passé'),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('Aucune commande trouvée'));
                  }

                  return ListView(
                    children:
                        snapshot.data!.docs.map((document) {
                          Map<String, dynamic> data =
                              document.data()! as Map<String, dynamic>;
                          return Card(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: ListTile(
                              contentPadding: EdgeInsets.all(10),
                              title: Text(
                                data['nomProduit'] ?? '',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Quantité: ${data['numCom'] ?? ''}'),
                                  Text('Prix: ${data['prix'] ?? ''}'),
                                  Text('Produit: ${data['produit'] ?? ''}'),
                                  Text('User: ${data['userId'] ?? ''}'),
                                  Text('Statut: ${data['etat'] ?? ''}'),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
