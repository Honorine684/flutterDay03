import 'package:ahigan/DrawerPages/addmarchepage.dart';
import 'package:ahigan/DrawerPages/assignepage.dart';
import 'package:ahigan/dafaults/defaults.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MarketInformations extends StatefulWidget {
  const MarketInformations({super.key});

  @override
  State<MarketInformations> createState() => _MarketInformationsState();
}

class _MarketInformationsState extends State<MarketInformations> {
  bool _showMarketsWithoutManager = true;

  Stream<QuerySnapshot> get _marketStream {
    if (_showMarketsWithoutManager) {
      return FirebaseFirestore.instance.collection('marché').where('manager', isEqualTo: '').snapshots();
    } else {
      return FirebaseFirestore.instance.collection('marché').where('manager', isNotEqualTo: '').snapshots();
    }
  }

  void _toggleMarketView() {
    setState(() {
      _showMarketsWithoutManager = !_showMarketsWithoutManager;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informations du Marché'),
        actions: [
          IconButton(
            color: Color(0xFF9fd5cd),
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const Addmarchepage();
                  },
                  fullscreenDialog: true,
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(17),
        child: Column(
          children: [
            SizedBox(height: 20),
            Row(
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
                              color: _showMarketsWithoutManager
                                  ? Defaults.selectbuton
                                  : Defaults.ianctivebuton,
                            ),
                            child: Center(
                              child: Text(
                                'Sans Manager',
                                style: TextStyle(
                                  color: _showMarketsWithoutManager
                                      ? Defaults.drawerItemSelectedColor
                                      : Defaults.inactivetext,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(width: 12,),


                  
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
                              color: !_showMarketsWithoutManager
                                  ? Defaults.selectbuton
                                  : Defaults.ianctivebuton,
                            ),
                            child: Center(
                              child: Text(
                                'Avec Manager',
                                style: TextStyle(
                                  color: !_showMarketsWithoutManager
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
            SizedBox(height: 15),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _marketStream,
                builder: (
                  BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot,
                ) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Quelque chose s\'est mal passé'));
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('Aucun marché sans manager'));
                  }

                  return ListView(
                    children: snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
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
                              Text('Category: ${data['category']}'),
                              if (!_showMarketsWithoutManager)
                                Text('Manager: ${data['manager']}'),
                            ],
                          ),
                          onTap: () {
                            if (_showMarketsWithoutManager) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return AssignManagerPage(marketId: document.id);
                                  },
                                  fullscreenDialog: true,
                                ),
                              );
                            }
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
      ),
    );
  }
}
