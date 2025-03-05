import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int marketCount = 0;
  int managerCount = 0;
  int userCount = 0;
  Map<String, int> commandesStats = {};

  @override
  void initState() {
    super.initState();
    _fetchData();
    _fetchCommandeStats();
  }

  Future<void> _fetchData() async {
    FirebaseFirestore.instance.collection('marché').snapshots().listen((snapshot) {
      setState(() {
        marketCount = snapshot.docs.length;
        managerCount = snapshot.docs.where((doc) => doc.data().containsKey('manager') && doc['manager'].toString().isNotEmpty).length;
      });
    });

    FirebaseFirestore.instance.collection('users').snapshots().listen((snapshot) {
      setState(() {
        userCount = snapshot.docs.length;
      });
    });
  }

  Future<void> _fetchCommandeStats() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('commandes').get();
      Map<String, int> stats = {};

      for (var doc in snapshot.docs) {
        var data = doc.data() as Map<String, dynamic>?;
        if (data != null && data['date'] != null && data['nomProduit'] != null) {
          Timestamp timestamp = data['date'] as Timestamp;
          String formattedDate = DateFormat('yyyy-MM-dd').format(timestamp.toDate());

          stats[formattedDate] = (stats[formattedDate] ?? 0) + 1;
        }
      }

      setState(() {
        commandesStats = stats.map((key, value) => MapEntry(key, value.isFinite ? value : 0));
      });
    } catch (e) {
      print('Erreur lors du chargement des statistiques de commandes : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tableau de Bord',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
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
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        title: const Text('Nombre de Marchés', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        subtitle: Text('$marketCount', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Card(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        title: const Text('Nombre de Gestionnaires', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        subtitle: Text('$managerCount', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ],
              ),
              Card(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  title: const Text('Nombre de Marchand', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  subtitle: Text('$userCount', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 25),
              commandesStats.isEmpty || commandesStats.values.any((v) => v.isNaN || v.isInfinite)
                  ? const Center(child: Text('Aucune donnée disponible'))
                  : SizedBox(
                      height: 300,
                      child: BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,
                          barGroups: commandesStats.entries.map((entry) {
                            int index = commandesStats.keys.toList().indexOf(entry.key);
                            return BarChartGroupData(
                              x: index,
                              barRods: [
                                BarChartRodData(
                                  toY: entry.value.toDouble(),
                                  color: Colors.blueAccent,
                                  width: 20,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ],
                            );
                          }).toList(),
                          titlesData: FlTitlesData(
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) => Text(value.toInt().toString()),
                              ),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  List<String> keys = commandesStats.keys.toList();
                                  return value.toInt() < keys.length
                                      ? Text(keys[value.toInt()], style: const TextStyle(fontSize: 10))
                                      : Container();
                                },
                              ),
                            ),
                          ),
                          gridData: FlGridData(show: true),
                          borderData: FlBorderData(show: true),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
