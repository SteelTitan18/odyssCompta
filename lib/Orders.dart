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
          title: const Center(child: Text(_appTitle)),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MyHomePage()),
                  );
                },
                icon: const Icon(Icons.home))
          ],
        ),
        body: Column(
          children: [
            FutureBuilder<QuerySnapshot>(
                future: firestore.collection('orders').get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final documents = snapshot.data?.docs ?? [];

                  if (documents.isEmpty) {
                    return Center(
                      child: Container(
                          padding: const EdgeInsets.only(top: 32),
                          child: const Text("Aucune commande trouvée")),
                    );
                  }

                  return Expanded(
                      child: ListView.builder(
                          itemCount: documents.length,
                          itemBuilder: (context, index) {
                            final document = documents[index];
                            return Container(
                              margin: const EdgeInsets.only(
                                  left: 16, right: 16, top: 16),
                              padding:
                                  const EdgeInsets.only(top: 16, bottom: 16),
                              decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListTile(
                                title:
                                    Text("Client: ${document['customer']}\n"),
                                subtitle: Column(children: [
                                  Text(
                                    (document['details'].split(';')).join('\n'),
                                  ),
                                  Text(
                                    "${document['amount'].toString()} FCFA",
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    document["paid"] ? "Payé" : "Non payé",
                                    style: TextStyle(
                                        color: document["paid"]
                                            ? Colors.green
                                            : Colors.red),
                                  ),
                                  Text(
                                    document["delivered"]
                                        ? "Livré"
                                        : "Non livré",
                                    style: TextStyle(
                                        color: document["delivered"]
                                            ? Colors.green
                                            : Colors.orangeAccent),
                                  ),
                                  Text(
                                      "\nA livrer le ${document['delivery_date']}"),
                                ]),
                                trailing: PopupMenuButton(
                                    itemBuilder: (BuildContext context) {
                                  return const [
                                    PopupMenuItem(
                                      value: 0,
                                      child: ListTile(
                                          leading: Icon(Icons.delivery_dining),
                                          title: Text("Livrer")),
                                    ),
                                    PopupMenuItem(
                                      value: 1,
                                      child: ListTile(
                                          leading: Icon(Icons.payments),
                                          title: Text("Valider le payement")),
                                    ),
                                    PopupMenuItem(
                                      value: 2,
                                      child: ListTile(
                                          leading: Icon(Icons.delete),
                                          title: Text("Supprimer")),
                                    )
                                  ];
                                },
                                    // on selected we show the dialog box
                                    onSelected: (value) {
                                  // if value 1 show dialog
                                      CollectionReference orders = FirebaseFirestore.instance.collection('orders');
                                      CollectionReference accounts = FirebaseFirestore.instance.collection('accounts');
                                  if (value == 0) {
                                    setState(() {
                                        orders.doc(document.id).update(
                                            {'delivered': true});
                                    });
                                    // if value 2 show dialog
                                  } else if (value == 1) {
                                    setState(() {
                                      orders.doc(document.id).update(
                                          {'paid': true});
                                      accounts.doc('accounts').update(
                                          {'fund': FieldValue.increment(document['amount'])});
                                    });
                                  }
                                  else {
                                    setState(() {
                                      orders.doc(document.id).delete();
                                    });
                                  }
                                }),
                              ),
                            );
                          }));
                })
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const OrderAdding()),
            );
          },
          child: const Icon(Icons.add),
        ));
  }
}
