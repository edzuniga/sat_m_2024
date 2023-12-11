import 'package:flutter/material.dart';

class IndicePobrezaProvider extends ChangeNotifier {
  //Declaración de variables
  double _indiceICP = 0;
  double _ppi1 = 0;
  double _ppi2 = 0;
  double _ppi3 = 0;
  double _ppi4 = 0;
  double _ppi5 = 0;
  double _ppi6 = 0;
  double _ppi7 = 0;
  double _ppi8 = 0;
  double _ppi9 = 0;
  double _ppi10 = 0;

  //Getters
  double get indiceICP => _indiceICP;
  double get ppi1 => _ppi1;
  double get ppi2 => _ppi2;
  double get ppi3 => _ppi3;
  double get ppi4 => _ppi4;
  double get ppi5 => _ppi5;
  double get ppi6 => _ppi6;
  double get ppi7 => _ppi7;
  double get ppi8 => _ppi8;
  double get ppi9 => _ppi9;
  double get ppi10 => _ppi10;

  //Setters
  valorIndiceICP() {
    _indiceICP = _ppi1 +
        _ppi2 +
        _ppi3 +
        _ppi4 +
        _ppi5 +
        _ppi6 +
        _ppi7 +
        _ppi8 +
        _ppi9 +
        _ppi10;
    notifyListeners();
  }

  set valorPpi1(double valor) {
    _ppi1 = valor;
    notifyListeners();
  }

  set valorPpi2(double valor) {
    _ppi2 = valor;
    notifyListeners();
  }

  set valorPpi3(double valor) {
    _ppi3 = valor;
    notifyListeners();
  }

  set valorPpi4(double valor) {
    _ppi4 = valor;
    notifyListeners();
  }

  set valorPpi5(double valor) {
    _ppi5 = valor;
    notifyListeners();
  }

  set valorPpi6(double valor) {
    _ppi6 = valor;
    notifyListeners();
  }

  set valorPpi7(double valor) {
    _ppi7 = valor;
    notifyListeners();
  }

  set valorPpi8(double valor) {
    _ppi8 = valor;
    notifyListeners();
  }

  set valorPpi9(double valor) {
    _ppi9 = valor;
    notifyListeners();
  }

  set valorPpi10(double valor) {
    _ppi10 = valor;
    notifyListeners();
  }

  resetearVariables() {
    _indiceICP = 0;
    _ppi1 = 0;
    _ppi2 = 0;
    _ppi3 = 0;
    _ppi4 = 0;
    _ppi5 = 0;
    _ppi6 = 0;
    _ppi7 = 0;
    _ppi8 = 0;
    _ppi9 = 0;
    _ppi10 = 0;

    notifyListeners();
  }
}
