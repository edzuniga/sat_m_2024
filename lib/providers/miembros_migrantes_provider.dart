import 'package:flutter/material.dart';

class MiembrosMigrantesProvider extends ChangeNotifier {
  //Declaración de variables
  //TextEditing
  final TextEditingController _nomEncuestado = TextEditingController();
  final TextEditingController _numTelefono = TextEditingController();
  final TextEditingController _ocupacion = TextEditingController();
  final TextEditingController _p09Relacion = TextEditingController();
  final TextEditingController _p10Otro = TextEditingController();
  final TextEditingController _p11Otro = TextEditingController();
  final TextEditingController _p12Relacion = TextEditingController();
  final TextEditingController _p13Pais = TextEditingController();
  final TextEditingController _p14Descripcion = TextEditingController();
  final TextEditingController _p15Servicios = TextEditingController();
  final TextEditingController _p16Razones = TextEditingController();
  final TextEditingController _edad = TextEditingController();
  final TextEditingController _p12Numero = TextEditingController();
  final TextEditingController _p13Anio = TextEditingController();
  //INTEGERS
  int _retornado = 0;
  int _temporalidad = 0;
  int _comunidad = 0;
  int _genero = 0;
  int _idDepartamento = 0;
  int? _idMunicipio;
  int _nivelEducativo = 0;
  int _estadoCivil = 0;
  int? _nomComunidad;
  int _p09 = 0;
  int _p10 = 0;
  int _p11 = 0;
  int _p12 = 0;
  int _p13 = 0;
  int _p14 = 0;
  int _p15 = 0;
  int _p16 = 0;

  //GETTERS
  TextEditingController get nomEncuestado => _nomEncuestado;
  TextEditingController get numTelefono => _numTelefono;
  TextEditingController get ocupacion => _ocupacion;
  TextEditingController get p09Relacion => _p09Relacion;
  TextEditingController get p10Otro => _p10Otro;
  TextEditingController get p11Otro => _p11Otro;
  TextEditingController get p12Relacion => _p12Relacion;
  TextEditingController get p13Pais => _p13Pais;
  TextEditingController get p14Descripcion => _p14Descripcion;
  TextEditingController get p15Servicios => _p15Servicios;
  TextEditingController get p16Razones => _p16Razones;
  TextEditingController get edad => _edad;
  TextEditingController get p12Numero => _p12Numero;
  TextEditingController get p13Anio => _p13Anio;

  int get retornado => _retornado;
  List<DropdownMenuItem<String>> listadoretornado = const [
    DropdownMenuItem(
      value: "1",
      child: Text('Sí'),
    ),
    DropdownMenuItem(
      value: "2",
      child: Text('No'),
    ),
  ];

  int get temporalidad => _temporalidad;
  List<DropdownMenuItem<String>> listadotemporalidad = const [
    DropdownMenuItem(
      value: "1",
      child: Text('Menos de 1 mes'),
    ),
    DropdownMenuItem(
      value: "2",
      child: Text('1 - 3 meses'),
    ),
    DropdownMenuItem(
      value: "3",
      child: Text('Más de 3 meses'),
    ),
  ];

  int get comunidad => _comunidad;
  List<DropdownMenuItem<String>> listadocomunidad = const [
    DropdownMenuItem(
      value: "1",
      child: Text('Sí'),
    ),
    DropdownMenuItem(
      value: "2",
      child: Text('No'),
    ),
  ];

  int get genero => _genero;
  List<DropdownMenuItem<String>> listadogenero = const [
    DropdownMenuItem(
      value: "1",
      child: Text('Masculino'),
    ),
    DropdownMenuItem(
      value: "2",
      child: Text('Femenino'),
    ),
  ];

  int get idDepartamento => _idDepartamento;
  List<DropdownMenuItem<String>> listadoidDepartamento = [];
  //función para poblar el listado de departamentos de la BD
  poblarDepartamentos(List<DropdownMenuItem<String>> listado) {
    listadoidDepartamento.clear();
    listadoidDepartamento = listado;
    notifyListeners();
  }

  int? get idMunicipio => _idMunicipio;
  List<DropdownMenuItem<String>> listadoidMunicipio = [];
  //función para poblar el listado de departamentos de la BD
  poblarMunicipios(List<DropdownMenuItem<String>> listado) {
    listadoidMunicipio.clear();
    listadoidMunicipio = listado;
    notifyListeners();
  }

  int? get nomComunidad => _nomComunidad;
  List<DropdownMenuItem<String>> listadoNomComunidad = [];
  //función para poblar el listado de departamentos de la BD
  poblarComunidades(List<DropdownMenuItem<String>> listado) {
    listadoNomComunidad.clear();
    listadoNomComunidad = listado;
    notifyListeners();
  }

  int get nivelEducativo => _nivelEducativo;
  List<DropdownMenuItem<String>> listadonivelEducativo = const [
    DropdownMenuItem(
      value: "1",
      child: Text('Primaria'),
    ),
    DropdownMenuItem(
      value: "2",
      child: Text('Secundaria'),
    ),
    DropdownMenuItem(
      value: "3",
      child: Text('Técnico'),
    ),
    DropdownMenuItem(
      value: "4",
      child: Text('Universitario'),
    ),
    DropdownMenuItem(
      value: "5",
      child: Text('Otro'),
    ),
  ];

  int get estadoCivil => _estadoCivil;
  List<DropdownMenuItem<String>> listadoestadoCivil = const [
    DropdownMenuItem(
      value: "1",
      child: Text('Soltero/a'),
    ),
    DropdownMenuItem(
      value: "2",
      child: Text('Casado/a'),
    ),
    DropdownMenuItem(
      value: "3",
      child: Text('Divorciado/a'),
    ),
    DropdownMenuItem(
      value: "4",
      child: Text('Viudo/a'),
    ),
    DropdownMenuItem(
      value: "5",
      child: Text('Unión libre'),
    ),
  ];

  int get p09 => _p09;
  List<DropdownMenuItem<String>> listadop09 = const [
    DropdownMenuItem(
      value: "1",
      child: Text('Sí'),
    ),
    DropdownMenuItem(
      value: "2",
      child: Text('No'),
    ),
  ];

  int get p10 => _p10;
  List<DropdownMenuItem<String>> listadop10 = const [
    DropdownMenuItem(
      value: "1",
      child: Text('1. Búsqueda de mejores oportunidades económicas'),
    ),
    DropdownMenuItem(
      value: "2",
      child: Text('2. Huir de la violencia o inseguridad'),
    ),
    DropdownMenuItem(
      value: "3",
      child: Text('3. Reunificación familiar'),
    ),
    DropdownMenuItem(
      value: "4",
      child: Text('4. Otro (especificar)'),
    ),
  ];

  int get p11 => _p11;
  List<DropdownMenuItem<String>> listadop11 = const [
    DropdownMenuItem(
      value: "1",
      child: Text('1. Estados Unidos'),
    ),
    DropdownMenuItem(
      value: "2",
      child: Text('2. México'),
    ),
    DropdownMenuItem(
      value: "3",
      child: Text('3. Otro país (especificar)'),
    ),
  ];

  int get p12 => _p12;
  List<DropdownMenuItem<String>> listadop12 = const [
    DropdownMenuItem(
      value: "1",
      child: Text('Sí'),
    ),
    DropdownMenuItem(
      value: "2",
      child: Text('No'),
    ),
  ];

  int get p13 => _p13;
  List<DropdownMenuItem<String>> listadop13 = const [
    DropdownMenuItem(
      value: "1",
      child: Text('Sí'),
    ),
    DropdownMenuItem(
      value: "2",
      child: Text('No'),
    ),
  ];

  int get p14 => _p14;
  List<DropdownMenuItem<String>> listadop14 = const [
    DropdownMenuItem(
      value: "1",
      child: Text('Sí'),
    ),
    DropdownMenuItem(
      value: "2",
      child: Text('No'),
    ),
  ];

  int get p15 => _p15;
  List<DropdownMenuItem<String>> listadop15 = const [
    DropdownMenuItem(
      value: "1",
      child: Text('Sí'),
    ),
    DropdownMenuItem(
      value: "2",
      child: Text('No'),
    ),
  ];

  int get p16 => _p16;
  List<DropdownMenuItem<String>> listadop16 = const [
    DropdownMenuItem(
      value: "1",
      child: Text('Sí'),
    ),
    DropdownMenuItem(
      value: "2",
      child: Text('No'),
    ),
  ];

  //SETTERS
  set valornomEncuestado(String valor) {
    _nomEncuestado.text = valor;
    notifyListeners();
  }

  set valornumTelefono(String valor) {
    _numTelefono.text = valor;
    notifyListeners();
  }

  set valornomComunidad(int? valor) {
    _nomComunidad = valor;
    notifyListeners();
  }

  set valorocupacion(String valor) {
    _ocupacion.text = valor;
    notifyListeners();
  }

  set valorp09Relacion(String valor) {
    _p09Relacion.text = valor;
    notifyListeners();
  }

  set valorp10Otro(String valor) {
    _p10Otro.text = valor;
    notifyListeners();
  }

  set valorp11Otro(String valor) {
    _p11Otro.text = valor;
    notifyListeners();
  }

  set valorp12Relacion(String valor) {
    _p12Relacion.text = valor;
    notifyListeners();
  }

  set valorp13Pais(String valor) {
    _p13Pais.text = valor;
    notifyListeners();
  }

  set valorp14Descripcion(String valor) {
    _p14Descripcion.text = valor;
    notifyListeners();
  }

  set valorp15Servicios(String valor) {
    _p15Servicios.text = valor;
    notifyListeners();
  }

  set valorp16Razones(String valor) {
    _p16Razones.text = valor;
    notifyListeners();
  }

  set valorretornado(int valor) {
    _retornado = valor;
    notifyListeners();
  }

  set valortemporalidad(int valor) {
    _temporalidad = valor;
    notifyListeners();
  }

  set valorcomunidad(int valor) {
    _comunidad = valor;
    notifyListeners();
  }

  set valoredad(String valor) {
    _edad.text = valor;
    notifyListeners();
  }

  set valorgenero(int valor) {
    _genero = valor;
    notifyListeners();
  }

  set valoridDepartamento(int valor) {
    _idDepartamento = valor;
    notifyListeners();
  }

  set valoridMunicipio(int? valor) {
    _idMunicipio = valor;
    notifyListeners();
  }

  set valornivelEducativo(int valor) {
    _nivelEducativo = valor;
    notifyListeners();
  }

  set valorestadoCivil(int valor) {
    _estadoCivil = valor;
    notifyListeners();
  }

  set valorp09(int valor) {
    _p09 = valor;
    notifyListeners();
  }

  set valorp10(int valor) {
    _p10 = valor;
    notifyListeners();
  }

  set valorp11(int valor) {
    _p11 = valor;
    notifyListeners();
  }

  set valorp12(int valor) {
    _p12 = valor;
    notifyListeners();
  }

  set valorp12Numero(String valor) {
    _p12Numero.text = valor;
    notifyListeners();
  }

  set valorp13(int valor) {
    _p13 = valor;
    notifyListeners();
  }

  set valorp13Anio(String valor) {
    _p13Anio.text = valor;
    notifyListeners();
  }

  set valorp14(int valor) {
    _p14 = valor;
    notifyListeners();
  }

  set valorp15(int valor) {
    _p15 = valor;
    notifyListeners();
  }

  set valorp16(int valor) {
    _p16 = valor;
    notifyListeners();
  }

  //Resetear Varibales
  resetearVariables() {
    _nomEncuestado.clear();
    _numTelefono.clear();
    _nomComunidad = null;
    _ocupacion.clear();
    _p09Relacion.clear();
    _p10Otro.clear();
    _p11Otro.clear();
    _p12Relacion.clear();
    _p13Pais.clear();
    _p14Descripcion.clear();
    _p15Servicios.clear();
    _p16Razones.clear();
    _retornado = 0;
    _temporalidad = 0;
    _comunidad = 0;
    _edad.clear();
    _genero = 0;
    _idDepartamento = 0;
    _idMunicipio = null;
    _nivelEducativo = 0;
    _estadoCivil = 0;
    _p09 = 0;
    _p10 = 0;
    _p11 = 0;
    _p12 = 0;
    _p12Numero.clear();
    _p13 = 0;
    _p13Anio.clear();
    _p14 = 0;
    _p15 = 0;
    _p16 = 0;

    notifyListeners();
  }
}
