import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LostConnectionPage extends StatelessWidget {
  LostConnectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              padding: const EdgeInsets.fromLTRB(16, 100, 16, 16),
              child: Image.asset(
                  'assets/images/2031700-perdu-connexion-glitch-web-vectoriel.jpg')),
          Container(
            padding: const EdgeInsets.fromLTRB(16, 100, 16, 16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  )),
              onPressed: () async {
                try {
                  await InternetAddress.lookup('www.google.com');
                  Fluttertoast.showToast(
                      msg: "Connexion rétablie !",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.grey,
                      textColor: Colors.white,
                      fontSize: 16.0);
                  Navigator.pop(context);
                } on SocketException {
                  Fluttertoast.showToast(
                      msg: "Pas de connexion internet !",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.grey,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              },
              child: const Text("Reconnexion"),
            ),
          )
        ],
      )),
    );
  }
}
