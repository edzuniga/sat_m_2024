import 'package:flutter/material.dart';

class SatmComunidadesProvider extends ChangeNotifier {
  //---------------DECLARACIÓN DE VARIABLES----------------//
  //Declaración de TEXT EDITING CONTROLLERS
  final TextEditingController _nomEncuestado = TextEditingController();
  final TextEditingController _telEncuestado = TextEditingController();
  final TextEditingController _identidad = TextEditingController();
  final TextEditingController _edad = TextEditingController();
  final TextEditingController _nino = TextEditingController();
  final TextEditingController _idPatrocinio = TextEditingController();

  final TextEditingController _facilitador = TextEditingController();
  List<DropdownMenuItem<String>> listadoFacilitador = [];
  poblarFacilitador(List<DropdownMenuItem<String>> listado) {
    listadoFacilitador.clear();
    listadoFacilitador = listado;
    notifyListeners();
  }

  final TextEditingController _telFacilitador = TextEditingController();
  final TextEditingController _fecha = TextEditingController();
  final TextEditingController _observaciones = TextEditingController();
  final TextEditingController _lat = TextEditingController();
  final TextEditingController _lon = TextEditingController();
  final TextEditingController _alt = TextEditingController();
  final TextEditingController _acc = TextEditingController();
  final TextEditingController _start = TextEditingController();
  final TextEditingController _end = TextEditingController();
  final TextEditingController _today = TextEditingController();
  final TextEditingController _sign = TextEditingController();
  final TextEditingController _anoCursado = TextEditingController();

  //Declaración de CHECKBOX
  int _acepta = 0;

  //AGREGADO
  int _idPais = 0;
  List<DropdownMenuItem<String>> listadoPaises = [];
  //función para poblar el listado de departamentos de la BD
  poblarPaises(List<DropdownMenuItem<String>> listado) {
    listadoPaises.clear();
    listadoPaises = listado;
    notifyListeners();
  }

  //Declaración de DROPDOWNS
  int _idDepartamento = 0;
  List<DropdownMenuItem<String>> listadoDepartamentos = [];
  //función para poblar el listado de departamentos de la BD
  poblarDepartamentos(List<DropdownMenuItem<String>> listado) {
    listadoDepartamentos.clear();
    listadoDepartamentos = listado;
    notifyListeners();
  }

  int? _idMunicipio;
  List<DropdownMenuItem<String>> listadoMunicipios = [];
  //función para poblar el listado de departamentos de la BD
  poblarMunicipios(List<DropdownMenuItem<String>> listado) {
    listadoMunicipios.clear();
    listadoMunicipios = listado;
    notifyListeners();
  }

  int? _comunidad;
  List<DropdownMenuItem<String>> listadoComunidades = [];
  //función para poblar el listado de departamentos de la BD
  poblarComunidades(List<DropdownMenuItem<String>> listado) {
    listadoComunidades.clear();
    listadoComunidades = listado;
    notifyListeners();
  }

  int _sexo = 0;
  List<DropdownMenuItem<String>> listadoSexo = const [
    DropdownMenuItem(value: "1", child: Text('Femenino')),
    DropdownMenuItem(value: "2", child: Text('Masculino'))
  ];

  int _educacion = 0;
  List<DropdownMenuItem<String>> listadoEducacion = const [
    DropdownMenuItem(value: "1", child: Text('Ninguna')),
    DropdownMenuItem(value: "2", child: Text('Primaria')),
    DropdownMenuItem(value: "3", child: Text('Media')),
    DropdownMenuItem(value: "4", child: Text('Universitaria'))
  ];

  int _estado = 0;
  List<DropdownMenuItem<String>> listadoEstado = const [
    DropdownMenuItem(value: "1", child: Text('Soltero/a')),
    DropdownMenuItem(value: "2", child: Text('Unión Libre')),
    DropdownMenuItem(value: "3", child: Text('Casado/a')),
    DropdownMenuItem(value: "4", child: Text('Divorciado/a')),
    DropdownMenuItem(value: "5", child: Text('Viudo/a')),
  ];

  int _ambosPadres = 0;
  List<DropdownMenuItem<String>> listadoAmbosPadres = const [
    DropdownMenuItem(value: "1", child: Text('Sí')),
    DropdownMenuItem(value: "2", child: Text('No')),
    DropdownMenuItem(value: "3", child: Text('NS/NR'))
  ];

  int _nnPatrocinado = 0;
  List<DropdownMenuItem<String>> listadoNnPatrocinado = const [
    DropdownMenuItem(value: "1", child: Text('Sí')),
    DropdownMenuItem(value: "2", child: Text('No')),
    DropdownMenuItem(value: "3", child: Text('NS/NR'))
  ];

  int _b1 = 0;
  List<DropdownMenuItem<String>> listadoB1 = const [
    DropdownMenuItem(value: "1", child: Text('Sí')),
    DropdownMenuItem(value: "2", child: Text('No')),
    DropdownMenuItem(value: "3", child: Text('NS/NR'))
  ];

  int _b2 = 0;
  List<DropdownMenuItem<String>> listadoB2 = [];
  poblarB2(List<DropdownMenuItem<String>> listado) {
    listadoB2.clear();
    listadoB2 = listado;
    notifyListeners();
  }

  int _c1 = 0;
  List<DropdownMenuItem<String>> listadoC1 = const [
    DropdownMenuItem(value: "1", child: Text('Cerámica/granito')),
    DropdownMenuItem(value: "2", child: Text('Plancha de cemento (firme)')),
    DropdownMenuItem(value: "3", child: Text('Madera')),
    DropdownMenuItem(value: "4", child: Text('Tierra')),
  ];

  int _c2 = 0;
  List<DropdownMenuItem<String>> listadoC2 = const [
    DropdownMenuItem(
        value: "1", child: Text('1. Servicio público por tubería')),
    DropdownMenuItem(
        value: "2", child: Text('2. Servicio privado por tubería')),
    DropdownMenuItem(value: "3", child: Text('3. Pozo malacate')),
    DropdownMenuItem(value: "4", child: Text('4. Pozo con bomba')),
    DropdownMenuItem(
        value: "5", child: Text('5. Río, riachuelo, ojo de agua, etc.')),
    DropdownMenuItem(value: "6", child: Text('6. Carro cisterna')),
    DropdownMenuItem(
        value: "7", child: Text('7. Pick-up con drones o barriles')),
    DropdownMenuItem(value: "8", child: Text('8. Llave pública o comunitaria')),
    DropdownMenuItem(value: "9", child: Text('9. Del vecino / otra vivienda')),
  ];

  int _c3 = 0;
  List<DropdownMenuItem<String>> listadoC3 = const [
    DropdownMenuItem(value: "1", child: Text('1. Servicio público')),
    DropdownMenuItem(value: "2", child: Text('2. Servicio privado colectivo')),
    DropdownMenuItem(value: "3", child: Text('3. Planta propia')),
    DropdownMenuItem(value: "4", child: Text('4. Energía solar')),
    DropdownMenuItem(value: "5", child: Text('5. Vela')),
    DropdownMenuItem(value: "6", child: Text('6. Candil o lámpara de gas')),
    DropdownMenuItem(value: "7", child: Text('7. Ocote')),
  ];

  int _d1 = 0;
  List<DropdownMenuItem<String>> listadoD1 = const [
    DropdownMenuItem(value: "1", child: Text('Sí')),
    DropdownMenuItem(value: "2", child: Text('No')),
    DropdownMenuItem(value: "3", child: Text('NS/NR'))
  ];

  int _d2 = 0;
  List<DropdownMenuItem<String>> listadoD2 = const [
    DropdownMenuItem(value: "1", child: Text('Sí')),
    DropdownMenuItem(value: "2", child: Text('No')),
    DropdownMenuItem(value: "3", child: Text('NS/NR'))
  ];

  int _d3 = 0;
  List<DropdownMenuItem<String>> listadoD3 = const [
    DropdownMenuItem(value: "1", child: Text('Sí')),
    DropdownMenuItem(value: "2", child: Text('No')),
    DropdownMenuItem(value: "3", child: Text('NS/NR'))
  ];

  int _d4 = 0;
  List<DropdownMenuItem<String>> listadoD4 = const [
    DropdownMenuItem(value: "1", child: Text('Sí')),
    DropdownMenuItem(value: "2", child: Text('No')),
    DropdownMenuItem(value: "3", child: Text('NS/NR'))
  ];

  int _d9 = 0;
  List<DropdownMenuItem<String>> listadoD9 = const [
    DropdownMenuItem(value: "1", child: Text('Económica')),
    DropdownMenuItem(value: "2", child: Text('Reunificación familiar')),
    DropdownMenuItem(value: "3", child: Text('Violencia')),
  ];

  int _d5 = 0;
  List<DropdownMenuItem<String>> listadoD5 = const [
    DropdownMenuItem(value: "1", child: Text('Sí')),
    DropdownMenuItem(value: "2", child: Text('No')),
    DropdownMenuItem(value: "3", child: Text('NS/NR'))
  ];

  int _d6 = 0;
  List<DropdownMenuItem<String>> listadoD6 = const [
    DropdownMenuItem(value: "1", child: Text('Sí')),
    DropdownMenuItem(value: "2", child: Text('No')),
    DropdownMenuItem(value: "3", child: Text('NS/NR'))
  ];

  int _d7 = 0;
  List<DropdownMenuItem<String>> listadoD7 = const [
    DropdownMenuItem(value: "1", child: Text('Sí')),
    DropdownMenuItem(value: "2", child: Text('No')),
    DropdownMenuItem(value: "3", child: Text('NS/NR'))
  ];

  int _d8 = 0;
  List<DropdownMenuItem<String>> listadoD8 = const [
    DropdownMenuItem(value: "1", child: Text('Sí')),
    DropdownMenuItem(value: "2", child: Text('No')),
    DropdownMenuItem(value: "3", child: Text('NS/NR'))
  ];

  int _e1 = 0;
  List<DropdownMenuItem<String>> listadoE1 = const [
    DropdownMenuItem(value: "1", child: Text('Sí')),
    DropdownMenuItem(value: "2", child: Text('No')),
    DropdownMenuItem(value: "3", child: Text('NS/NR'))
  ];

  int _e2 = 0;
  List<DropdownMenuItem<String>> listadoE2 = const [
    DropdownMenuItem(value: "1", child: Text('Sí')),
    DropdownMenuItem(value: "2", child: Text('No')),
    DropdownMenuItem(value: "3", child: Text('NS/NR'))
  ];

  //---------------DECLARACIÓN DE VARIABLES----------------//

  //------------GETTERS---------------//
  TextEditingController get nomEncuestado => _nomEncuestado;
  TextEditingController get telEncuestado => _telEncuestado;
  TextEditingController get identidad => _identidad;
  TextEditingController get edad => _edad;
  TextEditingController get nino => _nino;
  TextEditingController get idPatrocinio => _idPatrocinio;
  TextEditingController get facilitador => _facilitador;
  TextEditingController get telFacilitador => _telFacilitador;
  TextEditingController get fecha => _fecha;
  TextEditingController get observaciones => _observaciones;
  TextEditingController get lat => _lat;
  TextEditingController get lon => _lon;
  TextEditingController get alt => _alt;
  TextEditingController get acc => _acc;
  TextEditingController get start => _start;
  TextEditingController get end => _end;
  TextEditingController get today => _today;
  TextEditingController get sign => _sign;
  TextEditingController get anoCursado => _anoCursado;

  int get acepta => _acepta;

  int get idPais => _idPais;
  int get idDepartamento => _idDepartamento;
  int? get idMunicipio => _idMunicipio;
  int? get comunidad => _comunidad;
  int get sexo => _sexo;
  int get educacion => _educacion;
  int get estado => _estado;
  int get ambosPadres => _ambosPadres;
  int get nnPatrocinado => _nnPatrocinado;
  int get b1 => _b1;
  int get b2 => _b2;
  int get c1 => _c1;
  int get c2 => _c2;
  int get c3 => _c3;
  int get d1 => _d1;
  int get d2 => _d2;
  int get d3 => _d3;
  int get d4 => _d4;
  int get d9 => _d9;
  int get d5 => _d5;
  int get d6 => _d6;
  int get d7 => _d7;
  int get d8 => _d8;
  int get e1 => _e1;
  int get e2 => _e2;

  //------------GETTERS---------------//

  //------------SETTERS---------------//

  //TEXTEDITINGCONTROLLERS
  set valorNomEncuestado(String valor) {
    _nomEncuestado.text = valor;
    notifyListeners();
  }

  set valorTelEncuestado(String valor) {
    _telEncuestado.text = valor;
    notifyListeners();
  }

  set valorIdentidad(String valor) {
    _identidad.text = valor;
    notifyListeners();
  }

  set valorEdad(String valor) {
    _edad.text = valor;
    notifyListeners();
  }

  set valorNino(String valor) {
    _nino.text = valor;
    notifyListeners();
  }

  set valorIdPatrocinio(String valor) {
    _idPatrocinio.text = valor;
    notifyListeners();
  }

  set valorFacilitador(String valor) {
    _facilitador.text = valor;
    notifyListeners();
  }

  set valorTelFacilitador(String valor) {
    _telFacilitador.text = valor;
    notifyListeners();
  }

  set valorFecha(String valor) {
    _fecha.text = valor;
    notifyListeners();
  }

  set valorObservaciones(String valor) {
    _observaciones.text = valor;
    notifyListeners();
  }

  set valorLat(String valor) {
    _lat.text = valor;
    notifyListeners();
  }

  set valorLon(String valor) {
    _lon.text = valor;
    notifyListeners();
  }

  set valorAlt(String valor) {
    _alt.text = valor;
    notifyListeners();
  }

  set valorAcc(String valor) {
    _acc.text = valor;
    notifyListeners();
  }

  set valorStart(String valor) {
    _start.text = valor;
    notifyListeners();
  }

  set valorEnd(String valor) {
    _end.text = valor;
    notifyListeners();
  }

  set valorToday(String valor) {
    _today.text = valor;
    notifyListeners();
  }

  set valorSign(String valor) {
    _sign.text = valor;
    notifyListeners();
  }

  set valorAnoCursado(String valor) {
    _anoCursado.text = valor;
    notifyListeners();
  }

  //CHECKBOX
  set valorAcepta(int valor) {
    _acepta = valor;
    notifyListeners();
  }

  //DROPDOWNS
  set valorIdPais(int valor) {
    _idPais = valor;
    notifyListeners();
  }

  set valorIdDepartamento(int valor) {
    _idDepartamento = valor;
    notifyListeners();
  }

  set valorIdMunicipio(int? valor) {
    _idMunicipio = valor;
    notifyListeners();
  }

  set valorComunidad(int? valor) {
    _comunidad = valor;
    notifyListeners();
  }

  set valorSexo(int valor) {
    _sexo = valor;
    notifyListeners();
  }

  set valorEducacion(int valor) {
    _educacion = valor;
    notifyListeners();
  }

  set valorEstado(int valor) {
    _estado = valor;
    notifyListeners();
  }

  set valorAmbosPadres(int valor) {
    _ambosPadres = valor;
    notifyListeners();
  }

  set valorNnPatrocinado(int valor) {
    _nnPatrocinado = valor;
    notifyListeners();
  }

  set valorB1(int valor) {
    _b1 = valor;
    notifyListeners();
  }

  set valorB2(int valor) {
    _b2 = valor;
    notifyListeners();
  }

  set valorC1(int valor) {
    _c1 = valor;
    notifyListeners();
  }

  set valorC2(int valor) {
    _c2 = valor;
    notifyListeners();
  }

  set valorC3(int valor) {
    _c3 = valor;
    notifyListeners();
  }

  set valorD1(int valor) {
    _d1 = valor;
    notifyListeners();
  }

  set valorD2(int valor) {
    _d2 = valor;
    notifyListeners();
  }

  set valorD3(int valor) {
    _d3 = valor;
    notifyListeners();
  }

  set valorD4(int valor) {
    _d4 = valor;
    notifyListeners();
  }

  set valorD9(int valor) {
    _d9 = valor;
    notifyListeners();
  }

  set valorD5(int valor) {
    _d5 = valor;
    notifyListeners();
  }

  set valorD6(int valor) {
    _d6 = valor;
    notifyListeners();
  }

  set valorD7(int valor) {
    _d7 = valor;
    notifyListeners();
  }

  set valorD8(int valor) {
    _d8 = valor;
    notifyListeners();
  }

  set valorE1(int valor) {
    _e1 = valor;
    notifyListeners();
  }

  set valorE2(int valor) {
    _e2 = valor;
    notifyListeners();
  }

  //------------SETTERS---------------//

  //---------------REINICIAR VARIABLES ---------------//

  reiniciarVariablesComunidades() {
    _comunidad = null;
    _nomEncuestado.clear();
    _telEncuestado.clear();
    _identidad.clear();
    _edad.clear();
    _nino.clear();
    _idPatrocinio.clear();
    _facilitador.clear();
    _telFacilitador.clear();
    _fecha.clear();
    _observaciones.clear();
    _lat.clear();
    _lon.clear();
    _alt.clear();
    _acc.clear();
    _start.clear();
    _end.clear();
    _today.clear();
    _sign.clear();
    _anoCursado.clear();

    _acepta = 0;

    _idPais = 0;
    _idDepartamento = 0;
    _idMunicipio = null;
    _sexo = 0;
    _educacion = 0;
    _estado = 0;
    _ambosPadres = 0;
    _nnPatrocinado = 0;
    _b1 = 0;
    _b2 = 0;
    _c1 = 0;
    _c2 = 0;
    _c3 = 0;
    _d1 = 0;
    _d2 = 0;
    _d3 = 0;
    _d4 = 0;
    _d9 = 0;
    _d5 = 0;
    _d6 = 0;
    _d7 = 0;
    _d8 = 0;
    _e1 = 0;
    _e2 = 0;
    notifyListeners();
  }

  //---------------REINICIAR VARIABLES ---------------//
}
