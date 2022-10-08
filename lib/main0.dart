// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Odyssée des Saveurs : Comptabilité',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      routes: {
        //'/': (context) => MyHomePage(title: 'ODS : Comptabilité'),
        '/sellPage': (context) => const SellPage(title: "Ventes"),
        /*'/buyPage': (context) => BuyPage(title: "Dépenses"),
        '/statsPage': (context) => StatsPage(title: "Statistiques"),
        '/CaissPage': (context) => CaissPage(title: "Caisse"),*/
      },
      initialRoute: '/',
      home: const MyHomePage(title: 'ODS : Comptabilité'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: const MyAppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.brown,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize: const Size(100, 0),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/sellPage');
                },
                child: const Text(
                  "Vente",
                  style: TextStyle(
                    color: const Color(0xffffffff),
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.brown,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize: const Size(100, 0),
                ),
                onPressed: () {},
                child: const Text(
                  "Dépense",
                  style: TextStyle(
                    color: Color(0xffffffff),
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.brown,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize: const Size(100, 0),
                ),
                onPressed: () {},
                child: const Text(
                  "Statistiques",
                  style: TextStyle(
                    color: Color(0xffffffff),
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.brown,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize: const Size(100, 0),
                ),
                onPressed: () {},
                child: const Text(
                  "Caisse",
                  style: TextStyle(
                    color: Color(0xffffffff),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("ODS : Comptabilité"),
      elevation: 0,
      leading: const IconButton(
        icon: Icon(
          Icons.menu,
          color: Colors.white,
          size: 25,
        ),
        onPressed: null,
      ),
      actions: const [
        IconButton(
          icon: Icon(
            Icons.more_vert,
            color: Colors.white,
            size: 25,
          ),
          onPressed: null,
        ),
      ],
      backgroundColor: Colors.brown,
    );
  }
}

class SellPage extends StatelessWidget {
  const SellPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
        extendBodyBehindAppBar: true,
        appBar: const MyAppBar(),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Text("Croissants au chocolat"),
            const SizedBox(
              width: 200,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Nombre...',
                  labelText: 'Croissants simple',
                ),
              ),
            ),

            const SizedBox(
              width: 200,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Nombre...',
                  labelText: 'Croissants au chocolat',
                ),
              ),
            ),

            const SizedBox(
              width: 200,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Nombre...',
                  labelText: 'Pains au chocolat',
                ),
              ),
            ),

            const SizedBox(
              width: 200,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Nombre...',
                  labelText: 'Feuilletés simples',
                ),
              ),
            ),

            const SizedBox(
              width: 200,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Nombre...',
                  labelText: 'Grands feuilletés',
                ),
              ),
            ),

            const SizedBox(
              width: 200,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Nombre...',
                  labelText: 'Croissants au saucisse',
                ),
              ),
            ),

            const SizedBox(
              width: 200,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Nombre...',
                  labelText: 'Cakes',
                ),
              ),
            ),

            FloatingActionButton.extended(
                onPressed: () {},
                icon: const Icon(Icons.skip_next),
                backgroundColor: Colors.brown[800],
                label: const Text('Suivant',
                    textDirection: TextDirection.ltr,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)))
          ],
        )));
    return scaffold;
  }
}
