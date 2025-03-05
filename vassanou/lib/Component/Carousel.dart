import 'package:flutter/material.dart';
import 'dart:async';

class CarouselContainer extends StatefulWidget {
  @override
  _CarouselContainerState createState() => _CarouselContainerState();
}

class _CarouselContainerState extends State<CarouselContainer> with WidgetsBindingObserver {
  final PageController _controller = PageController(initialPage: 0);
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _startAutoScroll();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (mounted) {
        _controller.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _startAutoScroll();
    } else if (state == AppLifecycleState.paused) {
      _timer?.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    double largeurEcran = MediaQuery.of(context).size.width;
    double hauteurEcran = MediaQuery.of(context).size.height;
    return PageView(
      controller: _controller,
      children: [
        // Ton premier conteneur
        Container(
          width: largeurEcran * 0.88,
          height: hauteurEcran * 0.25,
          margin: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.teal.shade700),
          child: Row(children: [
            SizedBox(
              width: largeurEcran * 0.5,
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child: Text(
                      "Vendez plus simplement",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child: Text(
                      "Avec Wassanou rencontrez plus de clients et aller plus rapidement",
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: 100,
                    height: 35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xFFebb65b)),
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "Lire plus",
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: largeurEcran * 0.38,
              child: Column(
                children: [
                  SizedBox(
                    height: 75,
                  ),
                  Image.asset(
                    "assets/images/sac.png",
                    width: 120,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            )
          ]),
        ),
        // Ajoute d'autres conteneurs ici
      ],
    );
  }
}
