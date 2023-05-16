import 'package:flutter/material.dart';
import 'package:odysscompta/FirestoreFunctions.dart';
import 'package:odysscompta/Orders.dart';
import 'HomePage.dart';

class OrderAdding extends StatefulWidget {
  const OrderAdding({super.key});

  @override
  State<OrderAdding> createState() => _OrderAddingState();
}

class _OrderAddingState extends State<OrderAdding> {
  static const title = 'Nouvelle commande';
  final date = TextEditingController(text: DateTime.now().toString());
  final customer = TextEditingController();
  bool paid = false;
  bool delivered = false;

  List<TextEditingController> articlesControllers = [
    TextEditingController(),
  ];
  List<TextEditingController> numbersControllers = [
    TextEditingController(),
  ];
  List<TextEditingController> pricesControllers = [
    TextEditingController(),
  ];

  int total = 0;

  @override
  void initState() {
    super.initState();

    for (TextEditingController controller in pricesControllers) {
      controller.addListener(calculTotal);
    }
  }

  void calculTotal() {
    int cpt = 0;
    int sum = 0;

    for (cpt = 0; cpt < pricesControllers.length; cpt++) {
      int price = int.parse(pricesControllers[cpt].text);
      int number = int.parse(numbersControllers[cpt].text);
      sum += price * number;
    }

    setState(() {
      total = sum;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text(title)),
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
          children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(16, 50, 16, 16),
              child: TextField(
                  controller: customer, //editing controller of this TextField
                  decoration: const InputDecoration(
                      icon: Icon(Icons.person), //icon of text field
                      labelText: "Client" //label text of field
                      )),
            ),
            Container(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  controller: date, //editing controller of this TextField
                  decoration: const InputDecoration(
                      icon: Icon(Icons.calendar_today), //icon of text field
                      labelText: "Date de livraion" //label text of field
                      ),
                  readOnly: true, // when true user cannot edit text
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(), //get today's date
                        firstDate: DateTime(
                            2000), //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2101));

                    if (pickedDate != null) {
                      print(
                          pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000
                      // format date in required form here we use yyyy-MM-dd that means time is removed
                      var month = pickedDate.month.toString();
                      var day = pickedDate.day.toString();
                      if (pickedDate.month < 10) {
                        month = "0${pickedDate.month}";
                      }
                      if (pickedDate.day < 10) {
                        day = "0${pickedDate.day}";
                      }
                      String formattedDate = "${pickedDate.year}-$month-$day";
                      print(
                          formattedDate); //formatted date output using intl package =>  2022-07-04
                      //You can format date as per your need

                      setState(() {
                        date.text =
                            formattedDate; //set foratted date to TextField value.
                      });
                    } else {
                      print("Date is not selected");
                    }
                  },
                )),
            Row(children: [
              MediaQuery(
                  data: MediaQuery.of(context).copyWith(),
                  child: Container(
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.1,
                        right: MediaQuery.of(context).size.width * 0.1,
                        bottom: MediaQuery.of(context).size.width * 0.05),
                    child: Row(
                      children: [
                        const Text(
                          "Payé",
                          style: TextStyle(fontSize: 20),
                        ),
                        Checkbox(
                            value: paid,
                            onChanged: (value) {
                              setState(() {
                                paid = value!;
                              });
                            })
                      ],
                    ),
                  )),
              MediaQuery(
                  data: MediaQuery.of(context).copyWith(),
                  child: Container(
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.1,
                          right: MediaQuery.of(context).size.width * 0.1,
                          bottom: MediaQuery.of(context).size.width * 0.05),
                      child: Row(
                        children: [
                          const Text(
                            "Livré",
                            style: TextStyle(fontSize: 20),
                          ),
                          Checkbox(
                              value: delivered,
                              onChanged: (value) {
                                setState(() {
                                  delivered = value!;
                                });
                              })
                        ],
                      )))
            ]),
            const Text(
              "Contenu",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Expanded(
                child: ListView.builder(
              itemCount: articlesControllers.length,
              itemBuilder: (context, index) {
                return MediaQuery(
                    data: MediaQuery.of(context).copyWith(),
                    child: Row(
                      children: [
                        Container(
                            margin: EdgeInsets.all(
                                MediaQuery.of(context).size.width * 0.02),
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: 60,
                            child: TextField(
                              controller: articlesControllers[index],
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Article',
                                  labelText: 'Article'),
                            )),
                        Container(
                            margin: EdgeInsets.all(
                                MediaQuery.of(context).size.width * 0.02),
                            width: MediaQuery.of(context).size.width * 0.15,
                            height: 50,
                            child: TextField(
                              controller: numbersControllers[index],
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Nombre',
                                  labelText: 'Nombre'),
                              keyboardType: TextInputType.number,
                            )),
                        Container(
                            margin: EdgeInsets.all(
                                MediaQuery.of(context).size.width * 0.02),
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: 50,
                            child: TextField(
                              controller: pricesControllers[index],
                              onChanged: (_) => calculTotal(),
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Prix',
                                  labelText: 'Prix unitiare'),
                              keyboardType: TextInputType.number,
                            )),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                articlesControllers.removeAt(index);
                                pricesControllers.removeAt(index);
                                numbersControllers.removeAt(index);
                              });
                            },
                            icon: const Icon(Icons.delete)),
                      ],
                    ));
              },
            )),
            Container(
                padding: const EdgeInsets.fromLTRB(100, 8, 100, 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xffFF7F50)),
                child: Text(
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                  "Total : $total",
                )),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: null,
                onPressed: () {
                  int cpt = 0;
                  var details = "";
                  var total = 0;
                  var deliveryDate = date.text;
                  var client = customer.text;

                  for (cpt = 0; cpt < articlesControllers.length; cpt++) {
                    if (articlesControllers[cpt].text != "" &&
                        numbersControllers[cpt].text != "" &&
                        pricesControllers[cpt].text != "") {
                      details +=
                          " ${articlesControllers[cpt].text} x${numbersControllers[cpt].text} à ${pricesControllers[cpt].text} l'unité ;";
                      total += int.parse(pricesControllers[cpt].text) *
                          int.parse(numbersControllers[cpt].text);
                    }
                  }
                  order_adding(client, details, total, deliveryDate, paid, delivered);

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Orders()),
                  );
                },
                child: const Text('Enregistrer'),
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              articlesControllers.add(TextEditingController());
              numbersControllers.add(TextEditingController());
              pricesControllers.add(TextEditingController());
            });
          },
          child: const Icon(Icons.add),
        ));
  }
}
