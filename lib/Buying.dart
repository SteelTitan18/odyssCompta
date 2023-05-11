import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:odysscompta/Result.dart';
import 'package:odysscompta/main.dart';
import 'package:provider/provider.dart';
import 'RecetteProvider.dart';

class BuyPage extends StatefulWidget {
  const BuyPage({super.key});

  @override
  State<BuyPage> createState() => _BuyPageState();
}

class _BuyPageState extends State<BuyPage> {
  static const _appTitle = 'Achats';
  final achats = <Text>[];
  final prices = <Text>[];
  List<String> achatslabel = [];
  List<String> prixlabel = [];
  var total = 0;
  final labelController = TextEditingController();
  final priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final providerRecette = Provider.of<RecetteProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _appTitle,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
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
            Expanded(
              child: DataTable2(
                columns: _createColumns(),
                rows: List<DataRow>.generate(achatslabel.length,
                    (index) => _createRows(index, providerRecette)),
              ),
            ),
            Container(
                padding: const EdgeInsets.fromLTRB(100, 8, 100, 8),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10), color: const Color(0xffFF7F50)),
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ResultPage()),
                  );
                },
                child: const Text('Suivant'),
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (!(providerRecette.achats_label
                .contains(labelController.text))) {
              providerRecette.achats_label.add(labelController.text);
              providerRecette.prix_label.add(priceController.text);
            }
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
              achats.add(article);
              prices.add(prix);
              total = total + int.parse(priceController.text);
              providerRecette.total =
                  providerRecette.total - int.parse(priceController.text);
              achatslabel.add(labelController.text);
              prixlabel.add(priceController.text);
              labelController.clear();
              priceController.clear();
            });
          },
          child: const Icon(Icons.add),
        ),
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

  DataRow _createRows(index, RecetteProvider providerRecette) {
    return DataRow(
      cells: [
        DataCell(Text(achatslabel[index])),
        DataCell(Text(prixlabel[index].toString())),
        DataCell(IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            //print(achatslabel.elementAt(index));
            //achats.removeAt(index);
            int prix = int.parse(prixlabel.elementAt(index));
            achatslabel.removeAt(index);
            prixlabel.removeAt(index);
            setState(() {
              total -= prix;
              providerRecette.total += prix;
              providerRecette.achats_label.removeAt(index);
              providerRecette.prix_label.removeAt(index);
            });
          },
        )),
      ],
    );
  }
}
