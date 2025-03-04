
import 'package:ahigan/DrawerPages/addcategorie.dart';
import 'package:ahigan/DrawerPages/commande.dart';
import 'package:ahigan/DrawerPages/dashboard.dart';
import 'package:ahigan/DrawerPages/inscription.dart';
import 'package:ahigan/DrawerPages/marche.dart';
import 'package:ahigan/DrawerPages/produits.dart';
import 'package:ahigan/dafaults/defaults.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MainPage());
  }
}

var indexClicked = 0;

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final pages = [
    DashboardPage(),
    MarketInformations(),
    AddCategoriesToMarketPage(),
    Produit(),
    Commande(),
    Center(child: Text('Transactions')),
    Center(child: Text('Market Manager')),
    UsersPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Image.asset('assets/images/logo.png', height: 100), backgroundColor: Color(0xFF156651),),

      body: pages[indexClicked],
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF156651)
              ),
              padding: EdgeInsets.all(0),
              child: Container(
                child: Column(
                  children: [
                    SizedBox(height: 12,),
                    Container(
                      width: 200,
                      height: 100,
                  
                      child: Image.asset('assets/images/logo.png', height: 100,),
                    )
                  ],
                ),
              ),
            ),
            Expanded(child: ListView(

              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  onTap: () {
                    setState(() {
                      indexClicked=0;
                    });
                    Navigator.pop(context);
                  },
                leading: Icon(Defaults.drawerItemIcon[0],
                size: 25,
                color: indexClicked== 0 ? Defaults.drawerItemSelectedColor : Defaults.drawerItemColor,
                
                ),
                title: Text(Defaults.drawerItemText[0], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color:indexClicked== 0 ? Defaults.drawerItemSelectedColor : Defaults.drawerItemColor, ),),
                
                ),
                 ListTile(
                  onTap: () {
                    setState(() {
                      indexClicked=1;
                    });
                    Navigator.pop(context);
                  },
                  
                leading: Icon(Defaults.drawerItemIcon[1],
                size: 25,
                color: indexClicked== 1 ? Defaults.drawerItemSelectedColor : Defaults.drawerItemColor,
                
                ),
                title: Text(Defaults.drawerItemText[1], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color:indexClicked== 1 ? Defaults.drawerItemSelectedColor : Defaults.drawerItemColor, ),),
                
                ),
                 ListTile(
                  onTap: () {
                    setState(() {
                      indexClicked=2;
                    });
                    Navigator.pop(context);
                  },
                  
                leading: Icon(Defaults.drawerItemIcon[2],
                size: 25,
                color: indexClicked== 2 ? Defaults.drawerItemSelectedColor : Defaults.drawerItemColor,
                
                ),
                title: Text(Defaults.drawerItemText[2], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color:indexClicked== 2 ? Defaults.drawerItemSelectedColor : Defaults.drawerItemColor, ),),
                
                ),
                 ListTile(
                  onTap: () {
                    setState(() {
                      indexClicked=3;
                    });
                    Navigator.pop(context);
                  },
                  
                  leading: Icon(Defaults.drawerItemIcon[3],
                size: 25,
                color: indexClicked== 3 ? Defaults.drawerItemSelectedColor : Defaults.drawerItemColor,
                
                ),
                title: Text(Defaults.drawerItemText[3], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color:indexClicked== 3 ? Defaults.drawerItemSelectedColor : Defaults.drawerItemColor, ),),
                
                ),
                 ListTile(
                  onTap: () {
                    setState(() {
                      indexClicked=4;
                    });
                    Navigator.pop(context);
                  },
                  
                  leading: Icon(Defaults.drawerItemIcon[4],
                size: 25,
                color: indexClicked== 4 ? Defaults.drawerItemSelectedColor : Defaults.drawerItemColor,
                
                ),
                title: Text(Defaults.drawerItemText[4], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color:indexClicked== 4 ? Defaults.drawerItemSelectedColor : Defaults.drawerItemColor, ),),
                
                ),
                 ListTile(
                  onTap: () {
                    setState(() {
                      indexClicked=5;
                    });
                    Navigator.pop(context);
                  },
                  
                  leading: Icon(Defaults.drawerItemIcon[5],
                size: 25,
                color: indexClicked== 5 ? Defaults.drawerItemSelectedColor : Defaults.drawerItemColor,
                
                ),
                title: Text(Defaults.drawerItemText[5], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color:indexClicked== 5 ? Defaults.drawerItemSelectedColor : Defaults.drawerItemColor, ),),
                
                ),
                 ListTile(
                  onTap: () {
                    setState(() {
                      indexClicked=6;
                    });
                    Navigator.pop(context);
                  },
                  
                  leading: Icon(Defaults.drawerItemIcon[6],
                size: 25,
                color: indexClicked== 6 ? Defaults.drawerItemSelectedColor : Defaults.drawerItemColor,
                
                ),
                title: Text(Defaults.drawerItemText[6], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color:indexClicked== 6? Defaults.drawerItemSelectedColor : Defaults.drawerItemColor, ),),
                
                ),
                 ListTile(
                  onTap: () {
                    setState(() {
                      indexClicked=7;
                    });
                    Navigator.pop(context);
                  },
                  
                  leading: Icon(Defaults.drawerItemIcon[7],
                size: 25,
                color: indexClicked== 7 ? Defaults.drawerItemSelectedColor : Defaults.drawerItemColor,
                
                ),
                title: Text(Defaults.drawerItemText[7], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color:indexClicked== 7 ? Defaults.drawerItemSelectedColor : Defaults.drawerItemColor, ),),
                
                ),
                 
              ],


            ))
          ],
        ),
      ),
    );
  }
}
