import 'package:flutter/material.dart';
import 'package:odysscompta/main.dart';
import 'package:odysscompta/Sheets_Manip.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CofferPage extends StatefulWidget {
  const CofferPage({super.key});

  @override
  State<CofferPage> createState() => _CofferPageState();
}

class _CofferPageState extends State<CofferPage> {

  static const _appTitle = 'Caisse';
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
            body: SingleChildScrollView(
                child: Column(
              children: [
                Container(
                  width: 200,
                  margin: const EdgeInsets.fromLTRB(90, 100, 90, 3),
                  child: TextField(
                    controller: amountController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "En caisse",
                        labelText: 'En caisse'),
                  ),
                ),
                Container(
                    width: 200,
                    margin: const EdgeInsets.fromLTRB(0, 200, 0, 3),
                    child: ElevatedButton(
                      onPressed: () async {
                        refresh();
                        final prefs = await SharedPreferences.getInstance();
                        await Future.delayed(const Duration(seconds: 5));
                        int? amount = prefs.getDouble('amount1')?.toInt();
                        amountController.text = amount.toString();
                      },
                      child: const Text("Actualiser"),
                    )),
                Container(
                    width: 200,
                    margin: const EdgeInsets.fromLTRB(0, 16, 0, 3),
                    child: ElevatedButton(
                      onPressed: () {
                        amountUpdate(double.parse(amountController.text));
                      },
                      child: const Text("Mettre à jour"),
                    )),
              ],
            ))));
  }
}

Future<void> amountUpdate (double amount) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString("date", DateTime.now().toString());
  await prefs.setDouble("amount", amount);
}
