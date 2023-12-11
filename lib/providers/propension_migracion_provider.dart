import 'package:flutter/foundation.dart';

class PropensionMigracionProvider extends ChangeNotifier {
  //Variables
  double _p9 = 0;
  double _p11 = 0;
  double _p16 = 0;
  double _p17 = 0;
  double _p20 = 0;
  double _p21 = 0;
  double _p23 = 0;
  double _p26 = 0;
  double _p27 = 0;
  double _p28 = 0;
  double _p40 = 0;
  double _p42 = 0;
  double _p44 = 0;
  double _p46 = 0;
  double _p47 = 0;
  double _p48 = 0;
  double _p49 = 0;
  double _propension = 0;

  //Getters
  double get p9 => _p9;
  double get p11 => _p11;
  double get p16 => _p16;
  double get p17 => _p17;
  double get p20 => _p20;
  double get p21 => _p21;
  double get p23 => _p23;
  double get p26 => _p26;
  double get p27 => _p27;
  double get p28 => _p28;
  double get p40 => _p40;
  double get p42 => _p42;
  double get p44 => _p44;
  double get p46 => _p46;
  double get p47 => _p47;
  double get p48 => _p48;
  double get p49 => _p49;
  double get propension => _propension;

  //Setters
  actualizarPropension() {
    _propension = _p9 +
        _p11 +
        _p16 +
        _p17 +
        _p20 +
        _p21 +
        _p23 +
        _p26 +
        _p27 +
        _p28 +
        _p40 +
        _p42 +
        _p44 +
        _p46 +
        _p47 +
        _p48 +
        _p49;

    notifyListeners();
  }

  set valorP9(double valor) {
    _p9 = valor;
    notifyListeners();
  }

  set valorP11(double valor) {
    _p11 = valor;
    notifyListeners();
  }

  set valorP16(double valor) {
    _p16 = valor;
    notifyListeners();
  }

  set valorP17(double valor) {
    _p17 = valor;
    notifyListeners();
  }

  set valorP20(double valor) {
    _p20 = valor;
    notifyListeners();
  }

  set valorP21(double valor) {
    _p21 = valor;
    notifyListeners();
  }

  set valorP23(double valor) {
    _p23 = valor;
    notifyListeners();
  }

  set valorP26(double valor) {
    _p26 = valor;
    notifyListeners();
  }

  set valorP27(double valor) {
    _p27 = valor;
    notifyListeners();
  }

  set valorP28(double valor) {
    _p28 = valor;
    notifyListeners();
  }

  set valorP40(double valor) {
    _p40 = valor;
    notifyListeners();
  }

  set valorP42(double valor) {
    _p42 = valor;
    notifyListeners();
  }

  set valorP44(double valor) {
    _p44 = valor;
    notifyListeners();
  }

  set valorP46(double valor) {
    _p46 = valor;
    notifyListeners();
  }

  set valorP47(double valor) {
    _p47 = valor;
    notifyListeners();
  }

  set valorP48(double valor) {
    _p48 = valor;
    notifyListeners();
  }

  set valorP49(double valor) {
    _p49 = valor;
    notifyListeners();
  }

  //Resetar variables
  resetearVariables() {
    _p9 = 0;
    _p11 = 0;
    _p16 = 0;
    _p17 = 0;
    _p20 = 0;
    _p21 = 0;
    _p23 = 0;
    _p26 = 0;
    _p27 = 0;
    _p28 = 0;
    _p40 = 0;
    _p42 = 0;
    _p44 = 0;
    _p46 = 0;
    _p47 = 0;
    _p48 = 0;
    _p49 = 0;

    _propension = 0;

    notifyListeners();
  }
}
