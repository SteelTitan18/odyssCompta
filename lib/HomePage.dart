import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'LostConnectionPage.dart';
import 'Orders.dart';
import 'Selling.dart';
import 'Simple_Buying.dart';
import 'main.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _HomePageState();
}

class _HomePageState extends State<MyHomePage> {
  final String title = "Odyssée des Saveurs";

  @override
  Widget build(BuildContext context) {
    CollectionReference accounts =
        FirebaseFirestore.instance.collection('accounts');

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            flexibleSpace: ClipRect(
              child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                  child: Container(color: Colors.transparent)),
            ),
            backgroundColor: Colors.transparent.withOpacity(0.1),
            title: Center(
                child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
            )),
            automaticallyImplyLeading: false),
        body: Stack(children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background_image.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
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
                                color: const Color(0xffFF7F50),
                              ),
                              margin:
                                  const EdgeInsets.only(top: 150, bottom: 16),
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: 150,
                              child: Center(
                                  child: Row(children: [
                                MediaQuery(
                                    data: MediaQuery.of(context).copyWith(),
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.09,
                                          right: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.09),
                                      child: const Icon(
                                        Icons.account_balance_wallet,
                                        color: Colors.white,
                                        size: 50,
                                      ),
                                    )),
                                Text(
                                  "${cash['fund']}\tFCFA",
                                  //"<<montant>>",
                                  style: const TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                )
                              ])),
                            ));
                      }

                      return MediaQuery(
                          data: MediaQuery.of(context).copyWith(),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color(0xffFF7F50),
                            ),
                            margin: const EdgeInsets.only(top: 150, bottom: 16),
                            //padding: const EdgeInsets.all(8.0),
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 150,
                            child: const Center(
                                child: CircularProgressIndicator()),
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
                                  builder: (context) => const SimpleBuyPage()),
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
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Orders()),
                            );
                          },
                          child: const Text(
                            "Commandes",
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
                        ))),
              ])))
        ]),
    );
  }
}
