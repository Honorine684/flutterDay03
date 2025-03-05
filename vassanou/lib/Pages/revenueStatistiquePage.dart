import 'package:flutter/material.dart';
import 'package:vassanou/Component/bar_chart_sample2.dart';

class RevenueStatisticsPage extends StatelessWidget {
  final List<Map<String, dynamic>> fakeRevenueData = [
    {'Date': '2025-01-01', 'Produit': 'Tomate', 'Revenu': 100},
    {'Date': '2025-01-02', 'Produit': 'Riz', 'Revenu': 50},
    {'Date': '2025-01-03', 'Produit': 'Cube', 'Revenu': 200},
    {'Date': '2025-01-04', 'Produit': 'Sodabi', 'Revenu': 150},
    {'Date': '2025-01-05', 'Produit': 'Oignon', 'Revenu': 80},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Statistiques des revenus'),
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
              DataColumn(label: Text('Revenu')),
            ],
            rows: fakeRevenueData.map((data) {
              return DataRow(cells: [
                DataCell(Text(data['Date'])),
                DataCell(Text(data['Produit'])),
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
            ],
          )
        ),
      ),
      
    );
  }
}

