import 'package:flutter/material.dart';
import 'package:odysscompta/Buying.dart';         
import 'main.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Résultats'),
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
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [

        ],),
      ),
    );
  }
}