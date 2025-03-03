import 'package:ahigan/dafaults/defaults.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multiselect/multiselect.dart';

class AddCategoriesToMarketPage extends StatefulWidget {
  const AddCategoriesToMarketPage({super.key});

  @override
  State<AddCategoriesToMarketPage> createState() => _AddCategoriesToMarketPageState();
}

class _AddCategoriesToMarketPageState extends State<AddCategoriesToMarketPage> {
  List<String> categories = [];
  bool _showMarketsWithoutCategories = true;

  Stream<QuerySnapshot> get _marketStream {
    if (_showMarketsWithoutCategories) {
      return FirebaseFirestore.instance.collection('marché').where('category', isEqualTo: []).snapshots();
    } else {
      return FirebaseFirestore.instance.collection('marché').where('category', isNotEqualTo: []).snapshots();
    }
  }

  void _toggleMarketView() {
    setState(() {
      _showMarketsWithoutCategories = !_showMarketsWithoutCategories;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Catégory'),
        actions: [
          IconButton(
            color: Color(0xFF9fd5cd),
            icon: Icon(Icons.add),
            onPressed: _toggleMarketView,
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(8),
                height: 60,
                width: 250,
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
                          _showMarketsWithoutCategories = true;
                        });
                      },
                      child: Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: _showMarketsWithoutCategories
                              ? Defaults.selectbuton
                              : Defaults.ianctivebuton,
                        ),
                        child: Center(
                          child: Text(
                            'Sans Catégories',
                            style: TextStyle(
                              color: _showMarketsWithoutCategories
                                  ? Defaults.drawerItemSelectedColor
                                  : Defaults.inactivetext,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: 25,),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _showMarketsWithoutCategories = false;
                        });
                      },
                      child: Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: !_showMarketsWithoutCategories
                              ? Defaults.selectbuton
                              : Defaults.ianctivebuton,
                        ),
                        child: Center(
                          child: Text(
                            'Avec Catégories',
                            style: TextStyle(
                              color: !_showMarketsWithoutCategories
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
            ],
          ),
          SizedBox(height: 15),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _marketStream,
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Quelque chose s\'est mal passé'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('Aucun marché disponible'));
                }

                return ListView(
                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                    List<String> categories = data['category'] != null && data['category'] is List ? List<String>.from(data['category']) : [];
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(10),
                        title: Text(
                          data['name'],
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Lieu: ${data['lieu']}'),
                            Text('Stand: ${data['stand']}'),
                            Text('Catégories: ${categories.join(', ')}'),
                          ],
                        ),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Ajouter des Catégories'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    DropDownMultiSelect(
                                      selectedValuesStyle: TextStyle(color: Colors.transparent),
                                      separator: '__',
                                      onChanged: (List<String> x) {
                                        setState(() {
                                          categories = x;
                                        });
                                      },
                                      options: ['Légume', 'Fruit', 'Céréale', 'Cosmétique', 'Électronique'],
                                      selectedValues: categories,
                                      whenEmpty: 'Sélectionner les catégories',
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Annuler'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      if (categories.isNotEmpty) {
                                        try {
                                          await FirebaseFirestore.instance.collection('marché').doc(document.id).update({
                                            'category': FieldValue.arrayUnion(categories),
                                          });
                                          setState(() {
                                            categories = [];
                                          });
                                          Navigator.of(context).pop();
                                        } catch (error) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text('Erreur lors de l\'ajout des catégories : $error'),
                                            ),
                                          );
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('Veuillez sélectionner au moins une catégorie.'),
                                          ),
                                        );
                                      }
                                    },
                                    child: Text('Ajouter'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
