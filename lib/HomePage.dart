import 'package:flutter/material.dart';
import 'package:odysscompta/dashboard.dart';

import 'Orders.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _HomePageState();
}

class _HomePageState extends State<MyHomePage> {
  final String title = "Odyssée des Saveurs";
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const DashBoard(),
    const Orders(),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white,
        backgroundColor: Colors.blueGrey,
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.delivery_dining),
            label: 'Commandes',
          ),
        ],
      ),
    );
  }
}
