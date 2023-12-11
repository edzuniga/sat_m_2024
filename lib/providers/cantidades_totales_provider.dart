import 'package:flutter/material.dart';

class CantidadesTotalesProvider extends ChangeNotifier {
  //Declaración de variables
  int _totalComunidadesHn = 0;
  int _totalFamiliasHn = 0;

  //Getters
  int get totalComunidadesHn => _totalComunidadesHn;
  int get totalFamiliasHn => _totalFamiliasHn;

  //Setters
  set valorTotalComunidadesHn(int valor) {
    _totalComunidadesHn = valor;
    notifyListeners();
  }

  set valorTotalFamiliasHn(int valor) {
    _totalFamiliasHn = valor;
    notifyListeners();
  }
}
