import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'RecetteProvider.dart';
import 'package:odysscompta/Sheets_Insertion.dart';
import 'package:confirm_dialog/confirm_dialog.dart';

import 'main.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});
  static Map<String, dynamic> dico = {};

  @override
  Widget build(BuildContext context) {
    final providerRecette = Provider.of<RecetteProvider>(context);

    var total_Sell = 0;
    for (var value in providerRecette.ventes.values) {
      total_Sell = total_Sell + value;
    }
    num total_Buy = 0;
    var liste = providerRecette.achats['Prix']?.toList();
    for (var value in liste!) {
      value = int.parse(value);
      total_Buy = total_Buy + value;
    }
    final totalSell = TextEditingController(text: total_Sell.toString());
    final totalBuy = TextEditingController(text: total_Buy.toString());
    final recette =
        TextEditingController(text: providerRecette.total.toString());

    dico = {
      'DATE': providerRecette.date.toString(),
      'VENTE': total_Sell.toString(),
      'MONNAIE': '8000',
      'DEPENSES':
          "${providerRecette.achats_label.toString()}\nTotal = $total_Buy",
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
                      builder: (context) => const MyHomePage(
                          title: "Odyssée des Saveurs : Comptabilité")),
                );
              },
              icon: const Icon(Icons.home))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
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
                margin: const EdgeInsets.fromLTRB(50, 50, 8, 0),
                child: TextField(
                  controller: recette,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Recette du jour'),
                )),
            Container(
              margin: const EdgeInsets.fromLTRB(50, 200, 0, 0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
                onPressed: () async {
                  if (await confirm(context,
                      title: const Text('Confirmation'),
                      content:
                          const Text('Voulez-vous enregistré cette vente ?'),
                      textOK: const Text('Oui'),
                      textCancel: const Text('Non'))) {
                    dailyRegistration(dico);
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
                              const MyHomePage(title: "Odyssée des Saveurs")),
                    );
                  } else {
                    Navigator.pop(context);
                  }
                },
                child: const Text(style: TextStyle(fontSize: 30), 'Terminer'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
