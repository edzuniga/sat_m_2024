import 'package:flutter/material.dart';

class FamiliaMiembrosProvider extends ChangeNotifier {
  //Declaración de variables
  int _edadMigrante = 0;
  int _sexoMigrante = 0;
  int _tiempoMigrante = 0;
  int _miembroMigrante = 0;
  int _p26 = 0;

  //GETTERS
  int get edadMigrante => _edadMigrante;
  int get sexoMigrante => _sexoMigrante;
  int get tiempoMigrante => _tiempoMigrante;
  int get miembroMigrante => _miembroMigrante;
  int get p26 => _p26;

  //SETTERS
  set valorEdadMigrante(int valor) {
    _edadMigrante = valor;
    notifyListeners();
  }

  set valorSexoMigrante(int valor) {
    _sexoMigrante = valor;
    notifyListeners();
  }

  set valorTiempoMigrante(int valor) {
    _tiempoMigrante = valor;
    notifyListeners();
  }

  set valorMiembroMigrante(int valor) {
    _miembroMigrante = valor;
    notifyListeners();
  }

  set valorP26(int valor) {
    _p26 = valor;
    notifyListeners();
  }

  //Resetear Variables
  resetearVariables() {
    _edadMigrante = 0;
    _sexoMigrante = 0;
    _tiempoMigrante = 0;
    _miembroMigrante = 0;
    _p26 = 0;
    notifyListeners();
  }
}
