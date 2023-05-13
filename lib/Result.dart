import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'HomePage.dart';
import 'LostConnectionPage.dart';
import 'RecetteProvider.dart';
import 'package:odysscompta/Sheets_Manip.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';


class ResultPage extends StatelessWidget {
  const ResultPage({super.key});
  static Map<String, dynamic> dico = {};

  @override
  Widget build(BuildContext context) {
    final providerRecette = Provider.of<RecetteProvider>(context);

    Firebase.initializeApp();
    CollectionReference accounts = FirebaseFirestore.instance.collection('accounts');

    var total_Sell = 0;
    for (var value in providerRecette.ventes.values) {
      total_Sell = total_Sell + value;
    }
    num total_Buy = 0;
    int recipe = 0;
    int price = 0;
    var selling_details = '';
    var article = '';
    var liste = providerRecette.prix_label.toList();
    for (var value in liste) {
      price = int.parse(value);
      total_Buy = total_Buy + price;
    }

    recipe = providerRecette.total;
    final totalSell = TextEditingController(text: total_Sell.toString());
    final totalBuy = TextEditingController(text: total_Buy.toString());
    final recette = TextEditingController(text: recipe.toString());

    for (article in providerRecette.ventes.keys) {
      var article_i = article;
      switch (article) {
        case 'croiss':
          article = 'Croissant simple';
          break;
        case 'croiss_choc':
          article = 'Croissant chocolat';
          break;
        case 'feuill':
          article = 'Petit Feuilletté';
          break;
        case 'feuill_g':
          article = 'Grand Feuilletté';
          break;
        case 'pain_choc':
          article = 'Pain au Chocolat';
          break;
        case 'pain_rais':
          article = 'Pain au Raisin';
          break;
        case 'cakes':
          article = 'Cakes';
          break;
        case 'quiches':
          article = 'Petite Quiche';
          break;
        case 'm_quiches':
          article = 'Petite Quiche';
          break;
        default:
          break;
      }
      selling_details = '\n$selling_details$article : ${providerRecette.ventes[article_i]}';
    }

    dico = {
      'DATE': providerRecette.date.toString(),
      'VENTE': '$selling_details\nTotal = $total_Sell',
      'MONNAIE': '8000',
      'DEPENSES': "${providerRecette.achats_label.join("\n")}\n\nTotal",
      'MONTANTS': "${providerRecette.prix_label.join("\n")}\n\n$total_Buy",
      'A RENDRE': providerRecette.total,
      'PART BENE': '500',
      'RECETTE': providerRecette.total - 500
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Résultats'),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MyHomePage()),
                );
              },
              icon: const Icon(Icons.home))
        ],
      ),
      body: SingleChildScrollView(
        child: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: 200,
                margin: const EdgeInsets.fromLTRB(0, 100, 0, 0),
                child: TextField(
                  controller: totalSell,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Total des ventes'),
                )),
            Container(
                width: 200,
                margin: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                child: TextField(
                  controller: totalBuy,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Total des achats'),
                )),
            Container(
                width: 300,
                //padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                margin: const EdgeInsets.only(top: 50),
                child: TextField(
                  controller: recette,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Recette du jour'),
                )),
            Container(
              margin: const EdgeInsets.only(top: 150),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyan,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
                onPressed: () async {
                  try {
                    await InternetAddress.lookup('www.google.com');
                    if (await confirm(context,
                        title: const Text('Confirmation'),
                        content:
                            const Text('Voulez-vous enregistré cette vente ?'),
                        textOK: const Text('Oui'),
                        textCancel: const Text('Non'))) {
                      dailyRegistration(dico);
                      accounts.doc('accounts').update({'fund': FieldValue.increment(providerRecette.total - 500)});
                      accounts.doc('accounts').update({'bene_or_papa': FieldValue.increment(500)});
                      Fluttertoast.showToast(
                          msg: "Enregistrement effectué avec succès !",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.grey,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const MyHomePage()),
                      );
                    } else {
                      Navigator.pop(context);
                    }
                  } on SocketException {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LostConnectionPage()),
                    );
                  }
                },
                child: const Text(style: TextStyle(fontSize: 25, color: Colors.white), 'Terminer'),
              ),
            )
          ],
        )),
      ),
    );
  }
}
