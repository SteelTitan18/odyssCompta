import 'package:cloud_firestore/cloud_firestore.dart';
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

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

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
        body: Column(children: [
          FutureBuilder<QuerySnapshot>(future: firestore.collection('orders').get(),builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            final documents = snapshot.data?.docs ?? [];

            if (documents.isEmpty) {
              return const Center(child: Text("Aucune commande trouvée"),);
            }

            return Expanded(child: ListView.builder(itemCount: documents.length ,itemBuilder: (context, index) {
              final document = documents[index];
              return ListTile(
                title: Text(document['delivery_date']),
                subtitle: Text((document['details'].split(';')).join('\n')),
              );
            }));
          })
        ],),
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
