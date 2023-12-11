import 'package:flutter/material.dart';

class CondicionesComunidadesProvider extends ChangeNotifier {
  //Declaración de variables
  bool _condicionAcepta = false;
  bool _condicion9 = false;
  bool _condicion12 = false;
  bool _condicion14 = false;
  bool _condicion21 = false;
  bool _condicion23y24 = false;
  bool _condicion26 = false;
  bool _condicion27 = false;

  //Getters
  bool get condicionAcepta => _condicionAcepta;
  bool get condicion9 => _condicion9;
  bool get condicion12 => _condicion12;
  bool get condicion14 => _condicion14;
  bool get condicion21 => _condicion21;
  bool get condicion23y24 => _condicion23y24;
  bool get condicion26 => _condicion26;
  bool get condicion27 => _condicion27;

  //Setters
  set valorCondicionAcepta(bool valor) {
    _condicionAcepta = valor;
    notifyListeners();
  }

  set valorCondicion9(bool valor) {
    _condicion9 = valor;
    notifyListeners();
  }

  set valorCondicion12(bool valor) {
    _condicion12 = valor;
    notifyListeners();
  }

  set valorCondicion14(bool valor) {
    _condicion14 = valor;
    notifyListeners();
  }

  set valorCondicion21(bool valor) {
    _condicion21 = valor;
    notifyListeners();
  }

  set valorCondicion23y24(bool valor) {
    _condicion23y24 = valor;
    notifyListeners();
  }

  set valorCondicion26(bool valor) {
    _condicion26 = valor;
    notifyListeners();
  }

  set valorCondicion27(bool valor) {
    _condicion27 = valor;
    notifyListeners();
  }

  //Reset
  resetearCondiciones() {
    _condicionAcepta = false;
    _condicion9 = false;
    _condicion12 = false;
    _condicion14 = false;
    _condicion21 = false;
    _condicion23y24 = false;
    _condicion26 = false;
    _condicion27 = false;
    notifyListeners();
  }
}
