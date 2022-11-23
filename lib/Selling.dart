import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:odysscompta/Buying.dart';
import 'package:odysscompta/RecetteProvider.dart';
import 'package:provider/provider.dart';
import 'main.dart';

class SellPage extends StatelessWidget {
  SellPage({super.key});
  final croiss = TextEditingController();
  final croiss_choc = TextEditingController();
  final feuill = TextEditingController();
  final feuill_g = TextEditingController();
  final pain_choc = TextEditingController();
  final cakes = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final providerRecette = Provider.of<RecetteProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ventes'),
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
            padding: const EdgeInsets.fromLTRB(16, 100, 16, 16),
            child: TextField(
              controller: croiss,
              //initialValue: '0',
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Nombre...',
                  labelText: 'Croissants simples'),
            ),
          ),
          Container(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: croiss_choc,
                //initialValue: '0',
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Nombre...',
                    labelText: 'Croissants au chocolat',
                ),
              )),
          Container(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: pain_choc,
                //initialValue: '0',
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Nombre...',
                    labelText: 'Pains au chocolat'),
              )),
          Container(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: feuill,
                //initialValue: '0',
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Nombre...',
                    labelText: 'Feuilletés simples'),
              )),
          Container(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: feuill_g,
                //initialValue: '0',
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Nombre...',
                    labelText: 'Grands feuilletés'),
              )),
          Container(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: cakes,
                //initialValue: '0',
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Nombre...',
                    labelText: 'Cakes'),
              )),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: null,
              onPressed: () {
                providerRecette.total = 0;
                providerRecette.ventes['croiss'] = 0;
                providerRecette.ventes['croiss_choc'] = 0;
                providerRecette.ventes['feuill'] = 0;
                providerRecette.ventes['feuill_g'] = 0;
                providerRecette.ventes['pain_choc'] = 0;
                providerRecette.ventes['cakes'] = 0;

                providerRecette.ventes['croiss'] = ((croiss.text != "") ? int.parse(croiss.text) :0) * 200;
                providerRecette.total += providerRecette.ventes['croiss']!;
                providerRecette.ventes['croiss_choc'] = ((croiss_choc.text != "") ? int.parse(croiss_choc.text) :0) * 200;
                providerRecette.total += providerRecette.ventes['croiss_choc']!;
                providerRecette.ventes['feuill'] = ((feuill.text != "") ? int.parse(feuill.text) :0) * 200;
                providerRecette.total += providerRecette.ventes['feuill']!;
                providerRecette.ventes['feuill_g'] = ((feuill_g.text != "") ? int.parse(feuill_g.text) :0) * 500;
                providerRecette.total += providerRecette.ventes['feuill_g']!;
                providerRecette.ventes['pain_choc'] = ((pain_choc.text != "") ? int.parse(pain_choc.text) :0) * 250;
                providerRecette.total += providerRecette.ventes['pain_choc']!;
                providerRecette.ventes['cakes'] = ((cakes.text != "") ? int.parse(cakes.text) :0) * 150;
                providerRecette.total += providerRecette.ventes['cakes']!;
                print(providerRecette.total);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BuyPage()),
                );
              },
              child: const Text('Suivant'),
            ),
          )
        ],
      )),
    );
  }
}
