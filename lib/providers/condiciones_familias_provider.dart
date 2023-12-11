import 'package:flutter/material.dart';

class CondicionesFamiliasProvider extends ChangeNotifier {
  //Declaración de variables
  bool _condicionNinaNino = false;
  bool _condicionNnPatrocinados = false;
  bool _condicion8 = false;
  bool _condicion10 = false;
  bool _condicionP14 = false;
  bool _condicionP17 = false;
  bool _condicionP24 = false;
  bool _condicionP29 = false;
  bool _condicionP32 = false;
  bool _condicionP37 = false;
  bool _condicionP14y24 = false;
  bool _condicionP20y21 = false;
  bool _condicionP40 = false;

  //getters de variables
  bool get condicionNinaNino => _condicionNinaNino;
  bool get condicionNnPatrocinados => _condicionNnPatrocinados;
  bool get condicion8 => _condicion8; //Multi
  bool get condicion10 => _condicion10; //Multi
  bool get condicionP14 => _condicionP14;
  bool get condicionP17 => _condicionP17;
  bool get condicionP24 => _condicionP24;
  bool get condicionP29 => _condicionP29;
  bool get condicionP32 => _condicionP32;
  bool get condicionP37 => _condicionP37;
  bool get condicionP14y24 => _condicionP14y24;
  bool get condicionP20y21 => _condicionP20y21;
  bool get condicionP40 => _condicionP40;

  //Setters de variables
  set valorCondicionP40(bool valor) {
    _condicionP40 = valor;
    notifyListeners();
  }

  set valorCondicionP20y21(bool valor) {
    _condicionP20y21 = valor;
    notifyListeners();
  }

  set valorCondicionP14y24(bool valor) {
    _condicionP14y24 = valor;
    notifyListeners();
  }

  set valorCondicionNinaNino(bool valor) {
    _condicionNinaNino = valor;
    notifyListeners();
  }

  set valorCondicionNnPatrocinados(bool valor) {
    _condicionNnPatrocinados = valor;
    notifyListeners();
  }

  set valorCondicion8(bool valor) {
    _condicion8 = valor;
    notifyListeners();
  }

  set valorCondicion10(bool valor) {
    _condicion10 = valor;
    notifyListeners();
  }

  set valorCondicionP14(bool valor) {
    _condicionP14 = valor;
    notifyListeners();
  }

  set valorCondicionP17(bool valor) {
    _condicionP17 = valor;
    notifyListeners();
  }

  set valorCondicionP24(bool valor) {
    _condicionP24 = valor;
    notifyListeners();
  }

  set valorCondicionP29(bool valor) {
    _condicionP29 = valor;
    notifyListeners();
  }

  set valorCondicionP32(bool valor) {
    _condicionP32 = valor;
    notifyListeners();
  }

  set valorCondicionP37(bool valor) {
    _condicionP37 = valor;
    notifyListeners();
  }

  //resetear variables (condiciones)
  resetearCondicionesFamilias() {
    _condicionNinaNino = false;
    _condicionNnPatrocinados = false;
    _condicion8 = false;
    _condicion10 = false;
    _condicionP14 = false;
    _condicionP17 = false;
    _condicionP24 = false;
    _condicionP29 = false;
    _condicionP32 = false;
    _condicionP37 = false;
    _condicionP14y24 = false;
    _condicionP20y21 = false;
    _condicionP40 = false;

    notifyListeners();
  }
}
