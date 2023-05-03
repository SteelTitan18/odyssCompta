import 'package:flutter/material.dart';



class RecetteProvider extends ChangeNotifier {


  Map<String, int> _ventes = {
    'croiss': 0,
    'croiss_choc': 0,
    'feuill': 0,
    'feuill_g': 0,
    'pain_choc': 0,
    'pain_rais': 0,
    'cakes': 0,
    'quiches': 0,
    'm_quiches': 0,
  };

  int _total = 0;
  String _date = DateTime.now().toString();
  List<String> _achats_label = [];
  List<String> _prix_label = [];

  Map<String, int> get ventes => _ventes;
  int get total => _total;
  String get date => _date;
  List<String> get achats_label => _achats_label;
  List<String> get prix_label => _prix_label;

  set ventes (Map<String, int> newVentes) {
    _ventes = newVentes;
    notifyListeners();
  }

  set total(int value) {
    _total = value;
    notifyListeners();
  }

  set date(String date) {
    _date = date;
    notifyListeners();
  }

  set achats_label(List<String> achats_label) {
    _achats_label = achats_label;
    notifyListeners();
  }

  set prix_label(List<String> prix_label) {
    _prix_label = prix_label;
    notifyListeners();
  }
}