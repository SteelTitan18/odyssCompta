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
  Map<String, List> _achats = {'Articles':[], 'Prix': []};
  int _total = 0;
  String _date = DateTime.now().toString();
  String _achats_label = '';

  Map<String, int> get ventes => _ventes;
  Map<String, List> get achats => _achats;
  int get total => _total;
  String get date => _date;
  String get achats_label => _achats_label;

  set ventes (Map<String, int> newVentes) {
    _ventes = newVentes;
    notifyListeners();
  }
  set achats(Map<String, List> value) {
    _achats = value;
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

  set achats_label(String achats_label) {
    _achats_label = achats_label;
    notifyListeners();
  }
}