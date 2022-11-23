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
  final achats = <String>[];
  final _ventes = {};
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
        primarySwatch: Colors.brown,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(_appTitle),
          actions: <Widget>[
            IconButton(onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MyHomePage(title: "Odyssée des Saveurs : Comptabilité")),
              );
            }, icon: const Icon(Icons.home))
          ],
        ),
        body: Column(
          children: [
            TextField(
              autofillHints: const [
                "Taxi",
                "Boeuf",
                "Carotte",
                "Bettérave",
                "Poisson",
                "Taxi",
                "Plastique"
              ],
              controller: labelController,
              decoration: const InputDecoration(
                hintText: "Article",
              ),
            ),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(hintText: "Prix"),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: achats.length,
                itemBuilder: (context, index) {
                  final achat = achats[index];

                  return Dismissible(
                    key: Key('$achat$index'),
                    onDismissed: (direction) => achats.removeAt(index),
                    background: Container(color: Colors.red),
                    child: ListTile(title: Text(achat)),
                  );
                },
              ),
            ),
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
                    setState(() {
                      achats.add("\n\n\t\t\t\t\t\tTotal == $total");
                    });
                  },
                  child: const Text(
                    "Calculer",
                    style: TextStyle(
                      color: Color(0xffffffff),
                    ),
                  ),
                )),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown,
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
            providerRecette.achats['Articles']?.add(labelController.text);
            providerRecette.achats['Prix']?.add(priceController.text);
            setState(() {
              achats.add(
                  "${labelController.text}\t\t\t\t\t\t${priceController.text}");
              providerRecette.
              total = total + int.parse(priceController.text);
              labelController.clear();
              priceController.clear();
            });
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
