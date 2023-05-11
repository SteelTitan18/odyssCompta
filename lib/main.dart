import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:odysscompta/LostConnectionPage.dart';
import 'package:odysscompta/Selling.dart';
import 'package:odysscompta/Simple_Buying.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'RecetteProvider.dart';
import 'package:firebase_core/firebase_core.dart';

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
    Firebase.initializeApp();

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Odyssée des Saveurs : Comptabilité',
        theme: ThemeData(
          primarySwatch: Colors.amber,
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
    Firebase.initializeApp();
    CollectionReference accounts =
        FirebaseFirestore.instance.collection('accounts');

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(title: Text(title), automaticallyImplyLeading: false),
        body: SingleChildScrollView(
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
              FutureBuilder(
                  future: accounts.doc('accounts').get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      Map<String, dynamic> cash =
                          snapshot.data!.data() as Map<String, dynamic>;

                      return MediaQuery(
                          data: MediaQuery.of(context).copyWith(),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.blueAccent,
                            ),
                            margin: const EdgeInsets.only(top: 150, bottom: 16),
                            //padding: const EdgeInsets.all(8.0),
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 150,
                            child: Center(
                                child: Text(
                              "Caisse\n${cash['fund']}\tFCFA",
                              style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )),
                          ));
                    }

                    return MediaQuery(
                        data: MediaQuery.of(context).copyWith(),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blueAccent,
                          ),
                          margin: const EdgeInsets.only(top: 150, bottom: 16),
                          //padding: const EdgeInsets.all(8.0),
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 150,
                          child:
                              const Center(child: CircularProgressIndicator()),
                        ));
                  }),
              MediaQuery(
                  data: MediaQuery.of(context).copyWith(),
                  child: Container(
                      padding: const EdgeInsets.all(8.0),
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: 100,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.cyan,
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
                              MaterialPageRoute(
                                  builder: (context) => SellPage()),
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
                            fontSize: 20,
                            color: Color(0xffffffff),
                          ),
                        ),
                      ))),
              MediaQuery(
                  data: MediaQuery.of(context).copyWith(),
                  child: Container(
                      padding: const EdgeInsets.all(8.0),
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: 100,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.cyan,
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
                            fontSize: 20,
                            color: Color(0xffffffff),
                          ),
                        ),
                      ))),
              MediaQuery(
                  data: MediaQuery.of(context).copyWith(),
                  child: Container(
                      padding: const EdgeInsets.all(8.0),
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: 100,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.cyan,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          minimumSize: const Size(100, 0),
                        ),
                        onPressed: () {},
                        child: const Text(
                          "Statistiques",
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xffffffff),
                          ),
                        ),
                      ))),
              MediaQuery(
                  data: MediaQuery.of(context).copyWith(),
                  child: Container(
                      padding: const EdgeInsets.all(8.0),
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: 100,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.cyan,
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
                            fontSize: 20,
                            color: Color(0xffffffff),
                          ),
                        ),
                      )))
            ]))));
  }
}
