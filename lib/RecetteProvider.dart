import 'package:flutter/material.dart';

class RecetteProvider extends ChangeNotifier {
  Map<String, int> _ventes = {
    'croiss': 0,
    'croiss_choc': 0,
    'feuill': 0,
    'feuill_g': 0,
    'pain_choc': 0,
    'cakes': 0
  };
  Map<String, List> _achats = {'Articles':[], 'Prix': []};
  int _total = 0;

  Map<String, int> get ventes => _ventes;
  Map<String, List> get achats => _achats;
  int get total => _total;

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
}