import 'package:flutter/foundation.dart';

class MiembrosMigrantesCondicionesProvider extends ChangeNotifier {
  //Declaración de variables
  bool _condicion0 = false;
  bool _condicionP09 = false;
  bool _condicionP10 = false;
  bool _condicionP11 = false;
  bool _condicionP12 = false;
  bool _condicionP13 = false;
  bool _condicionP14 = false;
  bool _condicionP15 = false;
  bool _condicionP16 = false;

  //GETTERS
  bool get condicion0 => _condicion0;
  bool get condicionP09 => _condicionP09;
  bool get condicionP10 => _condicionP10;
  bool get condicionP11 => _condicionP11;
  bool get condicionP12 => _condicionP12;
  bool get condicionP13 => _condicionP13;
  bool get condicionP14 => _condicionP14;
  bool get condicionP15 => _condicionP15;
  bool get condicionP16 => _condicionP16;

  //SETTERS
  set valorCondicion0(bool valor) {
    _condicion0 = valor;
    notifyListeners();
  }

  set valorCondicionP09(bool valor) {
    _condicionP09 = valor;
    notifyListeners();
  }

  set valorCondicionP10(bool valor) {
    _condicionP10 = valor;
    notifyListeners();
  }

  set valorCondicionP11(bool valor) {
    _condicionP11 = valor;
    notifyListeners();
  }

  set valorCondicionP12(bool valor) {
    _condicionP12 = valor;
    notifyListeners();
  }

  set valorCondicionP13(bool valor) {
    _condicionP13 = valor;
    notifyListeners();
  }

  set valorCondicionP14(bool valor) {
    _condicionP14 = valor;
    notifyListeners();
  }

  set valorCondicionP15(bool valor) {
    _condicionP15 = valor;
    notifyListeners();
  }

  set valorCondicionP16(bool valor) {
    _condicionP16 = valor;
    notifyListeners();
  }

  //Resetear variables
  resetearVariables() {
    _condicion0 = false;
    _condicionP09 = false;
    _condicionP10 = false;
    _condicionP11 = false;
    _condicionP12 = false;
    _condicionP13 = false;
    _condicionP14 = false;
    _condicionP15 = false;
    _condicionP16 = false;

    notifyListeners();
  }
}
