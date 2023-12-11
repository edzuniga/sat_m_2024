import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  TextEditingController get email => _email;
  TextEditingController get password => _password;

  set valorEmail(String valor) {
    _email.text = valor;
  }

  set valorPassword(String valor) {
    _password.text = valor;
  }

  resetearVariables() {
    _email.clear();
    _password.clear();
    notifyListeners();
  }
}
