import 'package:flutter/material.dart';

class RecuperarProvider extends ChangeNotifier {
  bool _esperandoRecuperacion = false;
  bool _recuperacionSolicitada = false;
  bool get recuperacionSolicitada => _recuperacionSolicitada;
  bool get esperandoRecuperacion => _esperandoRecuperacion;

  set valorRecuperacionSolicitada(bool valor) {
    _recuperacionSolicitada = valor;
    notifyListeners();
  }

  set valorEsperandoRecuperacion(bool valor) {
    _esperandoRecuperacion = valor;
    notifyListeners();
  }

  resetearVariables() {
    _recuperacionSolicitada = false;
    _esperandoRecuperacion = false;
    notifyListeners();
  }
}
