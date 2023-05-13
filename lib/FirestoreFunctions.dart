import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<void> order_adding(String details, int total, String deliveryDate, bool paid, bool delivered) async {
  CollectionReference orders = FirebaseFirestore.instance.collection('orders');
  DocumentReference accounts = FirebaseFirestore.instance.collection('accounts').doc('accounts');
  if (paid == true) {
  accounts.update({'fund': FieldValue.increment(total)});
  }
  orders.add({
    'details': details,
    'delivery_date': deliveryDate,
    'amount': total,
    'paid': paid,
    'delivered': delivered
  }).then((value) => Fluttertoast.showToast(
      msg: "Commande enregistrée avec succès",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
      fontSize: 16.0));
}