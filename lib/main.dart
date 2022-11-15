import 'package:flutter/material.dart';
import 'package:odysscompta/Selling.dart';
import 'package:odysscompta/Buying.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Odyssée des Saveurs : Comptabilité',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: const MyHomePage(
        title: 'Odyssée des Saveurs : Comptabilité',
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(title: Text(title)),
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            children: [
              Container(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.brown,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      minimumSize: const Size(100, 0),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SellPage()),
                      );
                    },
                    child: const Text(
                      "Vente",
                      style: TextStyle(
                        color: Color(0xffffffff),
                      ),
                    ),
                  )),
              Container(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.brown,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      minimumSize: const Size(100, 0),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BuyPage()),
                      );
                    },
                    child: const Text(
                      "Dépense",
                      style: TextStyle(
                        color: Color(0xffffffff),
                      ),
                    ),
                  )),
              Container(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.brown,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      minimumSize: const Size(100, 0),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Statistiques",
                      style: TextStyle(
                        color: Color(0xffffffff),
                      ),
                    ),
                  )),
              Container(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.brown,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      minimumSize: const Size(100, 0),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Caisse",
                      style: TextStyle(
                        color: Color(0xffffffff),
                      ),
                    ),
                  )),
            ],
          ),
          Container(
              padding: const EdgeInsets.only(top: 25, left: 8, right: 8),
              width: 500,
              height: 100,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.brown,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize: const Size(100, 0),
                ),
                onPressed: () {},
                child: const Text(
                  "Fichier de compte",
                  style: TextStyle(
                    color: Color(0xffffffff),
                  ),
                ),
              ))
        ])));
  }
}


