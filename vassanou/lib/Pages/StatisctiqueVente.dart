import 'package:flutter/material.dart';
import 'package:vassanou/Component/bar_chart_sample2.dart';

class Statisctiquevente extends StatelessWidget {
  final List<Map<String, dynamic>> fakeData = [
    {'Date': '2025-01-01', 'Produit': 'Tomate', 'Quantité': 10, 'Revenu': 100},
    {'Date': '2025-01-02', 'Produit': 'Riz', 'Quantité': 5, 'Revenu': 50},
    {'Date': '2025-01-03', 'Produit': 'Huile', 'Quantité': 20, 'Revenu': 200},
    {'Date': '2025-01-04', 'Produit': 'Sodabi', 'Quantité': 15, 'Revenu': 150},
    {'Date': '2025-01-05', 'Produit': 'Cube', 'Quantité': 8, 'Revenu': 80},
  ];

  Statisctiquevente({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Statistiques des ventes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          
          child: Column(
            children: [
          DataTable(
            columns: [
              DataColumn(label: Text('Date')),
              DataColumn(label: Text('Produit')),
              DataColumn(label: Text('Quantité')),
              DataColumn(label: Text('Revenu')),
            ],
            rows: fakeData.map((data) {
              return DataRow(cells: [
                DataCell(Text(data['Date'])),
                DataCell(Text(data['Produit'])),
                DataCell(Text(data['Quantité'].toString())),
                DataCell(Text(data['Revenu'].toString())),
              ]);
            }).toList(),
          ),
          SizedBox(height: 20,),
              Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black.withOpacity(0.2)),
                  borderRadius: BorderRadius.circular(15)
                  
                ),
                child: BarChartSample7(),
              )
       ] ),
      ),
    ));
  }
}

