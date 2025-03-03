import 'package:ahigan/bar_chart_sample2.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int marketCount = 0;
  int managerCount = 0;
  int userCount = 0;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    // Fetch market count
    FirebaseFirestore.instance.collection('marché').snapshots().listen((snapshot) {
      setState(() {
        marketCount = snapshot.docs.length;
      });
    });

    // Fetch manager count based on markets with assigned managers
    FirebaseFirestore.instance.collection('marché').snapshots().listen((snapshot) {
      int count = 0;
      for (var doc in snapshot.docs) {
        if (doc.data().containsKey('manager') && doc.data()['manager'].toString().isNotEmpty) {
          count++;
        }
      }
      setState(() {
        managerCount = count;
      });
    });

    // Fetch user count
    FirebaseFirestore.instance.collection('users').snapshots().listen((snapshot) {
      setState(() {
        userCount = snapshot.docs.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tableau de Bord', style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: Color(0xFF9fd5cd),
      ),
      body: SingleChildScrollView(
        child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Card(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16),
                      title: Text(
                        'Nombre de Marchés',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        '$marketCount',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 5,),
                Expanded(
                  child: Card(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16),
                      title: Text(
                        'Nombre de Gestionnaires',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        '$managerCount',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Card(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                contentPadding: EdgeInsets.all(16),
                title: Text(
                  'Nombre de Marchand',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  '$userCount',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            BarChartSample2()
          ],
        ),
      )
      ),
    );
  }
}
