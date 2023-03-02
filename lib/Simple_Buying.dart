import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:odysscompta/Sheets_Manip.dart';
import 'package:odysscompta/main.dart';

class Simple_BuyPage extends StatefulWidget {
  const Simple_BuyPage({super.key});

  @override
  State<Simple_BuyPage> createState() => _Simple_BuyPageState();
}

class _Simple_BuyPageState extends State<Simple_BuyPage> {
  static const _appTitle = 'Achats';
  final achats = <Text>[];
  var achatslabel = <String>[];
  var total = 0;
  final date = TextEditingController(text: DateTime.now().toString());
  final labelController = TextEditingController();
  final priceController = TextEditingController();
  final accountController = TextEditingController();

  String? accountValue = 'Vente';
  var accounts = ['Vente', 'Personnel'];

  Map<String, dynamic> dico = {
    'DATE': DateTime.now().toString(),
    'MONTANT': '',
    'COMPTE': '',
    'MOTIF': "",
  };

  @override
  Widget build(BuildContext context) {
    //final providerRecette = Provider.of<RecetteProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _appTitle,
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(_appTitle),
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
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 100, 16, 16),
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
              padding: const EdgeInsets.fromLTRB(0, 16, 0, 3),
              child: DropdownButton(
                  value: accountValue,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: accounts.map((accounts) {
                    return DropdownMenuItem(
                        value: accounts, child: Text(accounts));
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      accountValue = newValue;
                    });
                  }),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: achats.length,
                itemBuilder: (context, index) {
                  final achat = achats[index];

                  return Dismissible(
                    key: Key('$achat$index'),
                    onDismissed: (direction) => articleDismiss(index),
                    background: Container(color: Colors.red),
                    child: ListTile(title: achat),
                  );
                },
              ),
            ),
            Container(
                color: Colors.brown,
                padding: const EdgeInsets.fromLTRB(100, 8, 100, 8),
                child: Text(
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                  "Total : $total",
                )),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
                onPressed: () async {
                  if (await confirm(context,
                      title: const Text('Confirmation'),
                      content: const Text('Voulez-vous enregistré cet achat ?'),
                      textOK: const Text('Oui'),
                      textCancel: const Text('Non'))) {
                    buyingRegistration(dico);
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
                              const MyHomePage(title: "Odyssée des Saveurs")),
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
                "${labelController.text}\t\t\t\t\t\t${priceController.text}",
              );
              if (date.text.toString() != '') {
                dico['DATE'] = date.text.toString();
              } else {
                dico['DATE'] = DateTime.now().toString();
              }
              achats.add(article);
              total = total + int.parse(priceController.text);
              achatslabel.add(
                  "${labelController.text}\t\t\t${priceController.text}");
              dico['MONTANT'] = total;
              dico['MOTIF'] = achatslabel.join("\n");
              dico['COMPTE'] = accountValue;
              labelController.clear();
              priceController.clear();
            });
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void articleDismiss(int index) {
    achats.removeAt(index);
    int prix =
        int.parse(achatslabel.elementAt(index).toString().split("\t\t\t")[1]);
    achatslabel.removeAt(index);
    setState(() {
      total -= prix;
    });
    dico['MONTANT'] = total;
    dico['MOTIF'] = achatslabel.join("\n");
  }
}
