import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:odysscompta/env.dart';

/// Your google auth credentials
///
/// how to get credentials - https://medium.com/@a.marenkov/how-to-get-credentials-for-google-sheets-456b7e88c430
const _credentials = CREDENTIALS;

/// Your spreadsheet id
///
/// It can be found in the link to your spreadsheet -
/// link looks like so https://docs.google.com/spreadsheets/d/YOUR_SPREADSHEET_ID/edit#gid=0
/// [YOUR_SPREADSHEET_ID] in the path is the id your need
const _spreadsheetId = SPREADSHEET_ID;

Future<void> dailyRegistration(Map<String, dynamic> dico) async {
  // init GSheets
  final gsheets = GSheets(_credentials);
  // fetch spreadsheet by its id
  final ss = await gsheets.spreadsheet(_spreadsheetId);

  // get worksheet by its title
  var sheet = ss.worksheetByTitle('Ventes_Quotidiennes');
  var debt_sheet = ss.worksheetByTitle('Dettes');
  // create worksheet if it does not exist yet
  sheet ??= await ss.addWorksheet('Ventes_Quotidiennes');
  debt_sheet ??= await ss.addWorksheet('Dettes');

  await sheet.values.map.appendRow(dico);
  // await debt_sheet.values.map.appendRow(debtDico);
}

Future<void> buyingRegistration(Map<String, dynamic> dico) async {
  // init GSheets
  final gsheets = GSheets(_credentials);
  // fetch spreadsheet by its id
  final ss = await gsheets.spreadsheet(_spreadsheetId);

  // get worksheet by its title
  var sheet = ss.worksheetByTitle('Dépenses');
  var debt_sheet = ss.worksheetByTitle('Dettes');
  // create worksheet if it does not exist yet
  sheet ??= await ss.addWorksheet('Dépenses');
  debt_sheet ??= await ss.addWorksheet('Dettes');

  print(dico);
  await sheet.values.map.appendRow(dico);
  // await debt_sheet.values.map.appendRow(debtDico);
}

Future<void> refresh() async {
  final prefs = await SharedPreferences.getInstance();
  var date = prefs.getString("date");
  var _dateI = DateTime.parse(date!);
  double? amount = prefs.getDouble('amount');

  final gsheets = GSheets(_credentials);
  final ss = await gsheets.spreadsheet(_spreadsheetId);
  // get worksheet by its title
  var sheet1 = ss.worksheetByTitle('Dépenses');
  // create worksheet if it does not exist yet
  sheet1 ??= await ss.addWorksheet('Dépenses');
  // get worksheet by its title
  var sheet2 = ss.worksheetByTitle('Ventes_Quotidiennes');
  // create worksheet if it does not exist yet
  sheet2 ??= await ss.addWorksheet('Ventes_Quotidiennes');

  final dateColumn1 = await sheet2.values.column(1);
  final priceColumn1 = await sheet2.values.column(8);


  int cpt1;
  for (cpt1 = 0; cpt1 < dateColumn1.length; cpt1++) {
    try {
      var _date = DateTime.parse(dateColumn1[cpt1]);
      if (_date.isAfter(_dateI)) {
        amount = (amount! + double.parse(priceColumn1[cpt1]));
      }
    } catch (e) {
      continue;
    }
  }

  final dateColumn2 = await sheet1.values.column(1);
  final priceColumn2 = await sheet1.values.column(2);

  int cpt2;
  for (cpt2 = 0; cpt2 < dateColumn2.length; cpt2++) {
    try {
      var _date = DateTime.parse(dateColumn2[cpt2]);
      if (_date.isAfter(_dateI)) {
        amount = (amount! - double.parse(priceColumn2[cpt2]));
      }
    } catch (e) {
      continue;
    }
  }

  await prefs.setDouble("amount1", amount!);
}

void ShowToast() {
  Fluttertoast.showToast(
      msg: "Enregistrement effectué avec succès !",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
      fontSize: 16.0);
}
