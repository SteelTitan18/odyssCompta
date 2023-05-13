import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:odysscompta/Sheets_Manip.dart';
import 'package:data_table_2/data_table_2.dart';

import 'HomePage.dart';


class SimpleBuyPage extends StatefulWidget {
  const SimpleBuyPage({super.key});

  @override
  State<SimpleBuyPage> createState() => _Simple_BuyPageState2();
}

class _Simple_BuyPageState2 extends State<SimpleBuyPage> {
  static const _appTitle = 'Achats';
  final achats = <Text>[];
  final prices = <Text>[];
  List<String> achatslabel = [];
  List<String> prixlabel = [];
  var total = 0;
  final date = TextEditingController(text: DateTime.now().toString());
  final labelController = TextEditingController();
  final priceController = TextEditingController();
  final accountController = TextEditingController();

  String? accountValue = 'Vente';
  var account = ['Vente', 'Personnel'];

  Map<String, dynamic> dico = {
    'DATE': DateTime.now().toString(),
    'TOTAL': '',
    'MOTIF': "",
    'MONTANT': '',
    'COMPTE': '',
  };

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    CollectionReference accounts = FirebaseFirestore.instance.collection('accounts');


    return Scaffold(
        appBar: AppBar(
          title: const Text(_appTitle),
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
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 50, 16, 16),
              child: TextField(
                controller: date,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Ne pas remplir si c\'est le compte du jour',
                    labelText: 'DATE DE L\' ACHAT'),
              ),
            ),
            Container(
                width: 200,
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 3),
                child: TextField(
                  controller: labelController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: "Article"),
                )),
            Container(
                width: 200,
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 3),
                child: TextField(
                  controller: priceController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: "Prix"),
                  keyboardType: TextInputType.number,
                )),
            Container(
              width: 200,
              padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
              child: DropdownButton(
                  value: accountValue,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: account.map((account) {
                    return DropdownMenuItem(
                        value: account, child: Text(account));
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      accountValue = newValue;
                    });
                  }),
            ),
            Expanded(
              child: DataTable2(
                columns: _createColumns(),
                rows: List<DataRow>.generate(
                    dico['MOTIF'].length,
                    (index) => _createRows(index)),
              ),
            ),
            Container(
                padding: const EdgeInsets.fromLTRB(100, 8, 100, 8),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                  color: const Color(0xffFF7F50)),
                child: Text(
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                  "Total : $total",
                )),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyan,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
                onPressed: () async {
                  if (await confirm(context,
                      title: const Text('Confirmation'),
                      content: const Text('Voulez-vous enregistré cet achat ?'),
                      textOK: const Text('Oui'),
                      textCancel: const Text('Non'))) {
                    dico['MONTANT'] = prixlabel.join("\n");
                    dico['MOTIF'] = achatslabel.join("\n");
                    dico['TOTAL'] = total;
                    buyingRegistration(dico);
                    accounts.doc('accounts').update({'fund': FieldValue.increment(-total)});
                    Fluttertoast.showToast(
                        msg: "Achat enregistré avec succès !",
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
                    //Navigator.pop(context);
                  }
                },
                child: const Text('Enregistrer'),
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              Text article = Text(
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    backgroundColor: Colors.blueGrey),
                labelController.text,
              );
              Text prix = Text(priceController.text.toString());
              if (date.text.toString() != '') {
                dico['DATE'] = date.text.toString();
              } else {
                dico['DATE'] = DateTime.now().toString();
              }
              achats.add(article);
              prices.add(prix);
              total = total + int.parse(priceController.text);
              achatslabel.add(labelController.text);
              prixlabel.add(priceController.text);
              //dico['MOTIF'] = achatslabel.join("\n");
              dico['MOTIF'] = achatslabel;
              //dico['MONTANT'] = prixlabel.join("\n");
              dico['MONTANT'] = prixlabel;
              dico['TOTAL'] = total;
              dico['COMPTE'] = accountValue;
              labelController.clear();
              priceController.clear();
            });
          },
          child: const Icon(Icons.add),
        ),
    );
  }

  List<DataColumn> _createColumns() {
    return [
      const DataColumn(label: Text('LIBELLÉ')),
      const DataColumn(label: Text('MONTANT')),
      //const DataColumn(label: Text('ACTIONS')),
      const DataColumn(label: Text('ACTIONS')),
    ];
  }

  DataRow _createRows(index) {
    return DataRow(
        cells: [
          DataCell(Text(dico['MOTIF'][index])),
          DataCell(Text(dico['MONTANT'][index].toString())),
          DataCell(IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              achats.removeAt(index);
              int prix =
              int.parse(prixlabel.elementAt(index));
              achatslabel.removeAt(index);
              prixlabel.removeAt(index);
              setState(() {
                total -= prix;
              });
              dico['MONTANT'] = prixlabel;
              dico['MOTIF'] = achatslabel;
            },
          )),
        ],
      );
  }
}
