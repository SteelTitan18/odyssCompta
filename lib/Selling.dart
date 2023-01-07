import 'package:flutter/material.dart';
import 'package:odysscompta/Buying.dart';
import 'package:odysscompta/RecetteProvider.dart';
import 'package:provider/provider.dart';
import 'main.dart';

class SellPage extends StatelessWidget {
  SellPage({super.key});
  final date = TextEditingController(text: DateTime.now().toString());
  final croiss = TextEditingController();
  final croiss_res = TextEditingController();
  final croiss_choc = TextEditingController();
  final croiss_choc_res = TextEditingController();
  final feuill = TextEditingController();
  final feuill_res = TextEditingController();
  final feuill_g = TextEditingController();
  final feuill_g_res = TextEditingController();
  final pain_choc = TextEditingController();
  final pain_choc_res = TextEditingController();
  final pain_rais = TextEditingController();
  final pain_rais_res = TextEditingController();
  final cakes = TextEditingController();
  final cakes_res = TextEditingController();

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
              controller: date,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Ne pas remplir si c\'est le compte du jour',
                  labelText: 'DATE DE LA VENTE'),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: croiss,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Nombre...',
                  labelText: 'Croissants simples'),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(200, 3, 16, 16),
            height: 60,
            child: TextField(
              controller: croiss_res,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Restants'),
            ),
          ),
          Container(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: croiss_choc,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Nombre...',
                  labelText: 'Croissants au chocolat',
                ),
              )),
          Container(
            padding: const EdgeInsets.fromLTRB(200, 3, 16, 16),
            height: 60,
            child: TextField(
              controller: croiss_choc_res,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Restants'),
            ),
          ),
          Container(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: pain_choc,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Nombre...',
                    labelText: 'Pains au chocolat'),
              )),
          Container(
            padding: const EdgeInsets.fromLTRB(200, 3, 16, 16),
            height: 60,
            child: TextField(
              controller: pain_choc_res,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Restants'),
            ),
          ),
          Container(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: pain_rais,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Nombre...',
                    labelText: 'Pains au raisin'),
              )),
          Container(
            padding: const EdgeInsets.fromLTRB(200, 3, 16, 16),
            height: 60,
            child: TextField(
              controller: pain_rais_res,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Restants'),
            ),
          ),
          Container(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: feuill,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Nombre...',
                    labelText: 'Feuilletés simples'),
              )),
          Container(
            padding: const EdgeInsets.fromLTRB(200, 3, 16, 16),
            height: 60,
            child: TextField(
              controller: feuill_res,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Restants'),
            ),
          ),
          Container(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: feuill_g,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Nombre...',
                    labelText: 'Grands feuilletés'),
              )),
          Container(
            padding: const EdgeInsets.fromLTRB(200, 3, 16, 16),
            height: 60,
            child: TextField(
              controller: feuill_g_res,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Restants'),
            ),
          ),
          Container(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: cakes,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Nombre...',
                    labelText: 'Cakes'),
              )),
          Container(
            padding: const EdgeInsets.fromLTRB(200, 3, 16, 16),
            height: 60,
            child: TextField(
              controller: cakes_res,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Restants'),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: null,
              onPressed: () {
                if (date.text.toString() != '') {
                  providerRecette.date = date.text.toString();
                } else {
                  providerRecette.date = DateTime.now().toString();
                }
                providerRecette.total = 0;
                providerRecette.ventes['croiss'] = 0;
                providerRecette.ventes['croiss_choc'] = 0;
                providerRecette.ventes['feuill'] = 0;
                providerRecette.ventes['feuill_g'] = 0;
                providerRecette.ventes['pain_choc'] = 0;
                providerRecette.ventes['pain_rais'] = 0;
                providerRecette.ventes['cakes'] = 0;

                providerRecette.achats['Articles'] = [];
                providerRecette.achats['Prix'] = [];

                providerRecette.ventes['croiss'] =
                    (((croiss.text != "") ? int.parse(croiss.text) : 0) -
                            ((croiss_res.text != "")
                                ? int.parse(croiss_res.text)
                                : 0)) *
                        200;
                providerRecette.total += providerRecette.ventes['croiss']!;
                providerRecette.ventes['croiss_choc'] =
                    (((croiss_choc.text != "")
                            ? int.parse(croiss_choc.text)
                            : 0) - ((croiss_choc_res.text != "")
                        ? int.parse(croiss_choc_res.text)
                        : 0)) *
                        200;
                providerRecette.total += providerRecette.ventes['croiss_choc']!;
                providerRecette.ventes['feuill'] =
                    (((feuill.text != "") ? int.parse(feuill.text) : 0) - ((feuill_res.text != "") ? int.parse(feuill_res.text) : 0)) * 200;
                providerRecette.total += providerRecette.ventes['feuill']!;
                providerRecette.ventes['feuill_g'] =
                    (((feuill_g.text != "") ? int.parse(feuill_g.text) : 0) - ((feuill_g_res.text != "") ? int.parse(feuill_g_res.text) : 0)) *
                        500;
                providerRecette.total += providerRecette.ventes['feuill_g']!;
                providerRecette.ventes['pain_choc'] =
                    (((pain_choc.text != "") ? int.parse(pain_choc.text) : 0) - ((pain_choc_res.text != "") ? int.parse(pain_choc_res.text) : 0)) *
                        250;
                providerRecette.total += providerRecette.ventes['pain_choc']!;
                providerRecette.ventes['pain_rais'] =
                    (((pain_rais.text != "") ? int.parse(pain_rais.text) : 0) - ((pain_rais_res.text != "") ? int.parse(pain_rais_res.text) : 0)) *
                        500;
                providerRecette.total += providerRecette.ventes['pain_rais']!;
                providerRecette.ventes['cakes'] =
                    (((cakes.text != "") ? int.parse(cakes.text) : 0) - ((cakes_res.text != "") ? int.parse(cakes_res.text) : 0)) * 150;
                providerRecette.total += providerRecette.ventes['cakes']!;
                print(providerRecette.total);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BuyPage()),
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
