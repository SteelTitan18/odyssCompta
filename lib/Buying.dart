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
  var achatslabel = '';
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
                )),
            Expanded(
              child: ListView.builder(
                itemCount: achats.length,
                itemBuilder: (context, index) {
                  final achat = achats[index];

                  return Dismissible(
                    key: Key('$achat$index'),
                    onDismissed: (direction) => achats.removeAt(index),
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ResultPage()),
                  );
                  providerRecette.achats_label = achatslabel;
                },
                child: const Text('Suivant'),
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (!(providerRecette.achats['Articles']!.contains(labelController.text))) {
              providerRecette.achats['Articles']?.add(labelController.text);
              providerRecette.achats['Prix']?.add(priceController.text);
            }
            setState(() {
              Text article = Text(
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20, color: Colors.white, backgroundColor: Colors.blueGrey),
                "${labelController.text}\t\t\t\t\t\t${priceController.text}",
              );
              achats.add(article);
              total = total + int.parse(priceController.text);
              providerRecette.total =
                  providerRecette.total - int.parse(priceController.text);
              achatslabel = "$achatslabel${labelController.text}\t\t\t${priceController.text}\n";
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
