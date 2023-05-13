import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'HomePage.dart';
import 'RecetteProvider.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => RecetteProvider())],
        child: const MyApp()),
  );
}

final Uri url = Uri.parse(
    "https://docs.google.com/spreadsheets/d/1NfYGeGzFMZrX0bGFFCjKM2KmA0-vL8-q-PnRJC-v38k/edit#gid=0");

void account_doc() async {
  if (!await launchUrl(url)) throw 'Fichier de compte inaccessible';
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //Firebase.initializeApp();

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.cyan,
        ),
        home: ChangeNotifierProvider<RecetteProvider>(
          create: (_) => RecetteProvider(),
          child: const MyHomePage(),
        ));
  }
}
