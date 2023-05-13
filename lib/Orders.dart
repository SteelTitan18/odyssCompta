import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'OrderAdding.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  static const _appTitle = 'Commandes';

  @override
  Widget build(BuildContext context) {
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
        body: SingleChildScrollView(child: Column()),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const OrderAdding()),
            );
          },
          child: const Icon(Icons.add),
        ));
  }
}
