import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Your google auth credentials
///
/// how to get credentials - https://medium.com/@a.marenkov/how-to-get-credentials-for-google-sheets-456b7e88c430
const _credentials = r'''
{
  "type": "service_account",
  "project_id": "comptabiliteods",
  "private_key_id": "cdd8156ebf1be3ee3cf23302ac9443f3819f84a1",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDFHfkxr0RWuE8Z\n1lTiGd9XRbNIU9JTKFicqs40Rgo/Gwgci2EoxnLEbnMXaPGtDgWgo/0jfkS7tY9r\ngGDK9qag8GqZFY6TzWWS1rEE/HzpXiR6EX9MTeauC8hOpIgG28vpbqI8L2WFatYv\nOqFEozbXxrHk6xS5ZqW1mulvvaKlLksHxn8yPo4vuWistOwY+dw5S97uVg6q0enK\n7IkermCU5v6oOYzmPvlTAPtUrdmGAn+jzq+JKvQXp/079FdAywzd6hRsgcbvsbkx\n3KApB18hWJP8Cbobrl2v4VeAw83wOXEtcauvwIzANJ1WHf90DYBJv/wMtK9LDC+K\n4Cjz+TkNAgMBAAECggEACshd9lLRGTFR2mb4E7o4lmyQpxc2vSfK2R8a0o82Rkdz\nRSR2tyVL5+Tm1NP/zGik9CmkUkm49s+yvb2zDcc6TDl6i087kmg88zBdVJl/N8DX\nm/nTDdiBEupAFdU4P6/MUsOjiklJc2fpuYGqirem61zKJGyboJy12d5UgLFN8V0j\nTZN7/NPDGgl5k7NsxN/Usxw5aqVBmQmIfFFveK3uXn0hOEmbyerHgonTkH8cRaRB\n9VYx2MLnQJ7P+WNrglXrfdGciFvbqgBDtkj6bk12gExY1VVQOXJ1++mo+DgsW5zY\nSWHSN4qMx0S0Rq/iseKDXMwzfs3iWihml4wYhSUYAQKBgQDt7l8NdGwbkhUMso3h\nvs/O1SVAdEuEWZElVxcUI3vp6Y1R86SBvwTZrwGGKd+lnqacHFjXWYn8LXvG6rc/\n2hYleNV9IrYbV9rxEPuUtzyui5ODLGI8P35wXSLTHv38RV9SqaV2OWsCTmPZzDna\nGU67wIqPKU2STb+5MImiG4EfDQKBgQDUFiJsXRTKmwe3Xh/ds0+SgEqSRm+jN9J5\noHhIoNYg8vACuRfb19n6IN4aPa46a21XT8Aq86nSdY7I+fL5/4/a6sAEnfVfDZjR\nzP78NuMgJHSB37XyoV50ZtXgSyBAptay4sN0RqZaQbkWs6dZkhJw5O21y8+Sqvtu\nbiP28KICAQKBgCn8j5+DNPSkkbxc4fa9QlSgfmNiYlUnrRpmxPbT0DEV+s9EbHpM\n6CE15dH0H7hNR99yjSbrcRMkP5x5nP7SkGfqa9oaPwKSPVufAJZcw4OVs+FI+sjg\n94ICnXueE3nqEAk5UK6NMVoF1U8A4BChuKgfMRRUWJEB0VxvuUn3CpEdAoGBAIrq\nDJYJycqDDOTQI/MktaPxn+Z7eDfiIlxD/UUlA9wFA6vk7Hm0wjORP6jUacAeCTo9\nJFN90efl1CZTgRC6kdEEHc1oYQVndIdGzGUK1m2BM0a17wkDJUj86m3FB1URcmMt\nIHSSqfdIQSFbfuuuP6HucLy4yDb7A0Drp2bhalwBAoGAQWkkmj4BWNT0vI+0PH0X\nMvPb9vCjF0Z5/C/AiG4X6N7Z0CpmqYveXk8OScgSpcLmVMiGPkQUOr4vlACAF2rp\nx6JThZ8DkRmjsjliqyn4QcsIg1ZKNU++9Sbn0PzK3QAY2nthIR5mmlq1YA5PCO2f\nls+TIiHc/p9xvPzaRhvq6Ts=\n-----END PRIVATE KEY-----\n",
  "client_email": "comptabiliteods@comptabiliteods.iam.gserviceaccount.com",
  "client_id": "108348032847913402307",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/comptabiliteods%40comptabiliteods.iam.gserviceaccount.com"
}
''';

/// Your spreadsheet id
///
/// It can be found in the link to your spreadsheet -
/// link looks like so https://docs.google.com/spreadsheets/d/YOUR_SPREADSHEET_ID/edit#gid=0
/// [YOUR_SPREADSHEET_ID] in the path is the id your need
const _spreadsheetId = '1NfYGeGzFMZrX0bGFFCjKM2KmA0-vL8-q-PnRJC-v38k/';

Future<void> dailyRegistration(Map<String, dynamic> dico) async {
  // init GSheets
  final gsheets = GSheets(_credentials);
  // fetch spreadsheet by its id
  final ss = await gsheets.spreadsheet(_spreadsheetId);

  // get worksheet by its title
  var sheet = ss.worksheetByTitle('Ventes_Quotidiennes');
  // create worksheet if it does not exist yet
  sheet ??= await ss.addWorksheet('Ventes_Quotidiennes');

  await sheet.values.map.appendRow(dico);
  // prints {index: 5, letter: f, number: 6, label: f6}
  if (kDebugMode) {
    print(await sheet.values.map.lastRow());
  }
}

Future<void> buyingRegistration(Map<String, dynamic> dico) async {
  // init GSheets
  final gsheets = GSheets(_credentials);
  // fetch spreadsheet by its id
  final ss = await gsheets.spreadsheet(_spreadsheetId);

  // get worksheet by its title
  var sheet = ss.worksheetByTitle('Dépenses');
  // create worksheet if it does not exist yet
  sheet ??= await ss.addWorksheet('Dépenses');

  await sheet.values.map.appendRow(dico);
  // prints {index: 5, letter: f, number: 6, label: f6}
  if (kDebugMode) {
    print(await sheet.values.map.lastRow());
  }
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
      if (kDebugMode) {
        //print("erreur");
      }
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
      //print("erreur");
    }
  }

  await prefs.setDouble("amount1", amount!);
}

/*Future<void> test() async {
  final prefs = await SharedPreferences.getInstance();
  var date = DateTime(2023, 1, 1);
  final double? amount = prefs.getDouble('amount');
  print(amount);
// ...

// Initialisez une instance de GSheets
  final gsheets = GSheets(_credentials);

  final ss = await gsheets.spreadsheet(_spreadsheetId);

  // get worksheet by its title
  var sheet = ss.worksheetByTitle('Dépenses');
  // create worksheet if it does not exist yet
  sheet ??= await ss.addWorksheet('Dépenses');

// Obtenez une colonne en spécifiant son numéro de colonne
  final column = await sheet.values.column(1);

// Obtenez les valeurs de la colonne
  //final values = await column.;

// Utilisez les valeurs
  for (var value in column) {
    try {
      var _date = DateTime.parse(value);
      if (_date.isAfter(date)) {
        print(_date);
      }
    } catch (e) {
      print('erreur');
    }
    continue;
  }
}*/

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
