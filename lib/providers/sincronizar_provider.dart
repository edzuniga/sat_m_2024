import 'package:flutter/material.dart';

class SincronizarProvider extends ChangeNotifier {
  //Variable
  bool _sincronizando = false;

  //GETTER
  bool get sincronizando => _sincronizando;

  //SETTER
  set valorSincronizando(bool valor) {
    _sincronizando = valor;
    notifyListeners();
  }

  //Resetear variables
  resetearVariable() {
    _sincronizando = false;
    notifyListeners();
  }
}
