import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class CommandeStats extends StatefulWidget {
  const CommandeStats({super.key});

  @override
  _CommandeStatsPageState createState() => _CommandeStatsPageState();
}

class _CommandeStatsPageState extends State<CommandeStats> {
  Map<String, int> commandesStats = {}; // Stocke le nombre de 'nomProduit' par jour

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      print("🔄 Chargement des données Firebase...");
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('commandes').get();
      Map<String, int> stats = {};

      for (var doc in snapshot.docs) {
        var data = doc.data() as Map<String, dynamic>?; // Sécurisation du cast

        if (data != null && data.containsKey('date') && data.containsKey('nomProduit')) {
          Timestamp timestamp = data['date'];
          String formattedDate = DateFormat('yyyy-MM-dd').format(timestamp.toDate());

          stats[formattedDate] = (stats[formattedDate] ?? 0) + 1;
        } else {
          print("⚠️ Document sans champ 'date' ou 'nomProduit' : ${doc.id}");
        }
      }

      print("📊 Commandes regroupées par jour : $stats");

      setState(() {
        commandesStats = stats;
      });
    } catch (e) {
      print('❌ Erreur lors du chargement des données : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistiques des Commandes'),
        backgroundColor: Colors.blueAccent,
      ),
      body:
      
      
      
       commandesStats.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  barGroups: commandesStats.entries.map((entry) {
                    int index = commandesStats.keys.toList().indexOf(entry.key);
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: entry.value.toDouble(), // Utilisation du nombre total de 'nomProduit'
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
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) =>
                            Text(value.toInt().toString()), // Axe Y (nombre de commandes)
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 50,
                        getTitlesWidget: (value, meta) {
                          List<String> keys = commandesStats.keys.toList();
                          if (value.toInt() >= keys.length) return Container();
                          return Text(
                            keys[value.toInt()],
                            style: const TextStyle(fontSize: 10),
                          ); // Axe X (dates)
                        },
                      ),
                    ),
                  ),
                  gridData: FlGridData(show: true),
                  borderData: FlBorderData(show: true),
                ),
              ),
            ),
    );
  }
}
