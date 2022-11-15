import 'package:flutter/material.dart';
import 'package:odysscompta/Buying.dart';

import 'main.dart';

class SellPage extends StatelessWidget {
  const SellPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ventes'),
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
      body: SingleChildScrollView(
          child:
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container (
              padding: const EdgeInsets.fromLTRB(16, 100, 16, 16),
              child: const TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Nombre...',
                    labelText: 'Croissants simples'
                ),
              ),
            ),

            Container(
                padding: const EdgeInsets.all(16.0),
                child: const TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Nombre...',
                      labelText: 'Croissants au chocolat'
                  ),
                )
            ),

            Container(
                padding: const EdgeInsets.all(16.0),
                child: const TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Nombre...',
                      labelText: 'Pains au chocolat'
                  ),
                )
            ),

            Container(
                padding: const EdgeInsets.all(16.0),
                child: const TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Nombre...',
                      labelText: 'Feuilletés simples'
                  ),
                )
            ),

            Container(
                padding: const EdgeInsets.all(16.0),
                child: const TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Nombre...',
                      labelText: 'Grands feuilletés'
                  ),
                )
            ),

            Container(
                padding: const EdgeInsets.all(16.0),
                child: const TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Nombre...',
                      labelText: 'Cakes'
                  ),
                )
            ),

            Container(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: null,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BuyPage()),
                  );
                },
                child: const Text('Suivant'),
              ),
            )
          ],)
      ),
    );
  }
}
