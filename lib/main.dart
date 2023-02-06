import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:odysscompta/Coffer.dart';
import 'package:odysscompta/LostConnectionPage.dart';
import 'package:odysscompta/Selling.dart';
import 'package:odysscompta/Simple_Buying.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'RecetteProvider.dart';

void main() {
  runApp(
    MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => RecetteProvider())],
        child: const MyApp()),
  );
}

final Uri url = Uri.parse(
    "https://docs.google.com/spreadsheets/d/1NfYGeGzFMZrX0bGFFCjKM2KmA0-vL8-q-PnRJC-v38k/edit#gid=0");

void account_doc() async {
  if (!await launchUrl(url)) throw 'Fichier de compte inaccessible';
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
        home: ChangeNotifierProvider<RecetteProvider>(
          create: (_) => RecetteProvider(),
          //builder: (_) => RecetteProvider(),
          child: const MyHomePage(
            title: 'Odyssée des Saveurs : Comptabilité',
          ),
        ));
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
                    onPressed: () async {
                      try {
                        await InternetAddress.lookup('www.google.com');
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SellPage()),
                        );
                      } on SocketException {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LostConnectionPage()),
                        );
                      }
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
                            builder: (context) => const Simple_BuyPage()),
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CofferPage()),
                      );
                    },
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
                onPressed: () {
                  account_doc();
                },
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
