import 'package:flutter/material.dart';

class SatmFamiliasProvider extends ChangeNotifier {
//DECLARACIÓN DE VARIABLES
  final TextEditingController _start = TextEditingController();
  final TextEditingController _end = TextEditingController();
  final TextEditingController _today = TextEditingController();
  final TextEditingController _nomEncuestado = TextEditingController();
  final TextEditingController _identidad = TextEditingController();
  final TextEditingController _edad = TextEditingController();
  final TextEditingController _idPatrocinio = TextEditingController();
  final TextEditingController _telFacilitador = TextEditingController();
  final TextEditingController _fecha = TextEditingController();
  final TextEditingController _observaciones = TextEditingController();
  final TextEditingController _lat = TextEditingController();
  final TextEditingController _lon = TextEditingController();
  final TextEditingController _alt = TextEditingController();
  final TextEditingController _acc = TextEditingController();
  final TextEditingController _nacimiento = TextEditingController();
  final TextEditingController _telefonoEncuestado = TextEditingController();
  final TextEditingController _familias = TextEditingController();
  final TextEditingController _miembros = TextEditingController();
  final TextEditingController _nina = TextEditingController();
  final TextEditingController _nino = TextEditingController();
  final TextEditingController _p15 = TextEditingController();
  final TextEditingController _p18 = TextEditingController();
  final TextEditingController _p18B = TextEditingController();
  final TextEditingController _otro1 = TextEditingController();
  //final TextEditingController _p39 = TextEditingController();

  final TextEditingController _facilitador = TextEditingController();
  List<DropdownMenuItem<String>> listadoFacilitador = [];
  poblarFacilitador(List<DropdownMenuItem<String>> listado) {
    listadoFacilitador.clear();
    listadoFacilitador = listado;
    notifyListeners();
  }

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

  int _estudia = 0;
  List<DropdownMenuItem<String>> listadoEstudia = const [
    DropdownMenuItem(value: "1", child: Text('Sí')),
    DropdownMenuItem(value: "2", child: Text('No'))
  ];

  int _patrocinio = 0;
  List<DropdownMenuItem<String>> listadoPatrocinio = const [
    DropdownMenuItem(value: "1", child: Text('Sí')),
    DropdownMenuItem(value: "2", child: Text('No'))
  ];

  int _sexo = 0;
  List<DropdownMenuItem<String>> listadoSexo = const [
    DropdownMenuItem(value: "1", child: Text('Femenino')),
    DropdownMenuItem(value: "2", child: Text('Masculino'))
  ];

  int _educacion = 0;
  List<DropdownMenuItem<String>> listadoEducacion = const [
    DropdownMenuItem(value: "1", child: Text('Primer Grado')),
    DropdownMenuItem(value: "2", child: Text('Segundo Grado')),
    DropdownMenuItem(value: "3", child: Text('Tercer Grado')),
    DropdownMenuItem(value: "4", child: Text('Cuarto Grado')),
    DropdownMenuItem(value: "5", child: Text('Quinto Grado')),
    DropdownMenuItem(value: "6", child: Text('Sexto Grado')),
    DropdownMenuItem(value: "7", child: Text('Séptimo Grado')),
    DropdownMenuItem(value: "8", child: Text('Octavo Grado')),
    DropdownMenuItem(value: "9", child: Text('Noveno Grado')),
    DropdownMenuItem(value: "10", child: Text('Bachillerato')),
    DropdownMenuItem(value: "11", child: Text('Pregrado Incompleto')),
    DropdownMenuItem(value: "12", child: Text('Pregrado Completo')),
    DropdownMenuItem(value: "13", child: Text('Postgrado Incompleto')),
    DropdownMenuItem(value: "14", child: Text('Postgrado Completo')),
    DropdownMenuItem(value: "15", child: Text('Ninguno')),
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
  ];

  int _nnPatrocinado = 0;
  List<DropdownMenuItem<String>> listadoNnPatrocinado = const [
    DropdownMenuItem(value: "1", child: Text('Sí')),
    DropdownMenuItem(value: "2", child: Text('No')),
  ];

  int _p01 = 0;
  List<DropdownMenuItem<String>> listadoP01 = const [
    DropdownMenuItem(value: "1", child: Text('1. Ha reducido')),
    DropdownMenuItem(value: "2", child: Text('2. Se ha mantenido')),
    DropdownMenuItem(value: "3", child: Text('3. Ha incrementado')),
    DropdownMenuItem(value: "4", child: Text('4. NS/NR')),
  ];

  int _p02 = 0;
  List<DropdownMenuItem<String>> listadoP02 = const [
    DropdownMenuItem(value: "1", child: Text('1. Reducirá')),
    DropdownMenuItem(value: "2", child: Text('2. Se mantendrá igual')),
    DropdownMenuItem(value: "3", child: Text('3. Incrementará')),
    DropdownMenuItem(value: "4", child: Text('4. NS/NR')),
  ];

  int _p03 = 0;
  List<DropdownMenuItem<String>> listadoP03 = const [
    DropdownMenuItem(value: "1", child: Text('1. No tiene trabajo')),
    DropdownMenuItem(
        value: "2",
        child: Text(
            '2. Porque pese a tener trabajo sus ingresos no son suficientes')),
    DropdownMenuItem(
        value: "3",
        child: Text(
            '3. Porque ha sido amenazado de muerte, extorsionado, etc...')),
    DropdownMenuItem(
        value: "4",
        child: Text('4. Por el barrio/colonia donde vive es inseguro')),
    DropdownMenuItem(
        value: "5",
        child: Text(
            '5. Para reunirse con los familiares que viven en Estados Unidos')),
    DropdownMenuItem(
        value: "6",
        child: Text(
            '6. Porque las leyes migratorias facilitan el establecerse en ese país')),
    DropdownMenuItem(
        value: "7",
        child: Text(
            '7. Porque considera que las condiciones en Honduras no mejorarán')),
    DropdownMenuItem(value: "8", child: Text('8. NS/NR')),
  ];

  int _p06 = 0;
  List<DropdownMenuItem<String>> listadoP06 = const [
    DropdownMenuItem(value: "1", child: Text("Sí")),
    DropdownMenuItem(value: "2", child: Text("No")),
    DropdownMenuItem(value: "3", child: Text("NS/NR")),
  ];

  int _p07 = 0;
  List<DropdownMenuItem<String>> listadoP07 = const [
    DropdownMenuItem(value: "1", child: Text("1. Lo económico")),
    DropdownMenuItem(value: "2", child: Text("2. La Inseguridad")),
    DropdownMenuItem(value: "3", child: Text("3. Reunificación Familiar")),
    DropdownMenuItem(value: "4", child: Text("4. NS/NR")),
  ];

  int _p09 = 0;
  List<DropdownMenuItem<String>> listadoP09 = const [
    DropdownMenuItem(value: "1", child: Text("Sí")),
    DropdownMenuItem(value: "2", child: Text("No")),
  ];

  int _p11 = 0;
  List<DropdownMenuItem<String>> listadoP11 = const [
    DropdownMenuItem(value: "1", child: Text("Sí")),
    DropdownMenuItem(value: "2", child: Text("No")),
  ];

  int _p13 = 0;
  List<DropdownMenuItem<String>> listadoP13 = const [
    DropdownMenuItem(value: "1", child: Text("1. Menos de 1 año")),
    DropdownMenuItem(value: "2", child: Text("2. Entre 1 - 3 años")),
    DropdownMenuItem(value: "3", child: Text("3. Entre 3 - 5 años")),
    DropdownMenuItem(value: "4", child: Text("4. Más de 5 años")),
    DropdownMenuItem(value: "5", child: Text("5. NS/NR")),
  ];

  int _p14 = 0;
  List<DropdownMenuItem<String>> listadoP14 = const [
    DropdownMenuItem(value: "1", child: Text("Sí")),
    DropdownMenuItem(value: "2", child: Text("No")),
  ];

  int _p16 = 0;
  List<DropdownMenuItem<String>> listadoP16 = const [
    DropdownMenuItem(value: "1", child: Text("1. Menos de 1 año")),
    DropdownMenuItem(value: "2", child: Text("2. Entre 1 - 3 años")),
    DropdownMenuItem(value: "3", child: Text("3. Entre 3 - 5 años")),
    DropdownMenuItem(value: "4", child: Text("4. Más de 5 años")),
  ];

  int _p17 = 0;
  List<DropdownMenuItem<String>> listadoP17 = const [
    DropdownMenuItem(value: "1", child: Text("Sí")),
    DropdownMenuItem(value: "2", child: Text("No")),
  ];

  int _p19 = 0;
  List<DropdownMenuItem<String>> listadoP19 = const [
    DropdownMenuItem(value: "1", child: Text("1. Menos de 1 año")),
    DropdownMenuItem(value: "2", child: Text("2. Entre 1 - 3 años")),
    DropdownMenuItem(value: "3", child: Text("3. Entre 3 - 5 años")),
    DropdownMenuItem(value: "4", child: Text("4. Más de 5 años")),
  ];

  int _p20 = 0;
  List<DropdownMenuItem<String>> listadoP20 = const [
    DropdownMenuItem(value: "1", child: Text("1. Sí")),
    DropdownMenuItem(value: "2", child: Text("2. Quizás")),
    DropdownMenuItem(value: "3", child: Text("3. No")),
    DropdownMenuItem(value: "4", child: Text("4. NS/NR")),
  ];

  int _p21 = 0;
  List<DropdownMenuItem<String>> listadoP21 = const [
    DropdownMenuItem(value: "1", child: Text("1. Sí")),
    DropdownMenuItem(value: "2", child: Text("2. Quizás")),
    DropdownMenuItem(value: "3", child: Text("3. No")),
    DropdownMenuItem(value: "4", child: Text("4. NS/NR")),
  ];

  int _p22 = 0;
  List<DropdownMenuItem<String>> listadoP22 = const [
    DropdownMenuItem(value: "1", child: Text("1. Por un corto tiempo")),
    DropdownMenuItem(value: "2", child: Text("2. Permanentemente")),
    DropdownMenuItem(value: "4", child: Text("3. NS/NR")),
  ];

  int _p23 = 0;
  List<DropdownMenuItem<String>> listadoP23 = const [
    DropdownMenuItem(value: "1", child: Text('1. No tiene trabajo')),
    DropdownMenuItem(
        value: "2",
        child: Text(
            '2. Porque pese a tener trabajo sus ingresos no son suficientes')),
    DropdownMenuItem(
        value: "3",
        child: Text(
            '3. Porque ha sido amenazado de muerte, extorsionado, etc...')),
    DropdownMenuItem(
        value: "4",
        child: Text('4. Por el barrio/colonia donde vive es inseguro')),
    DropdownMenuItem(
        value: "5",
        child: Text(
            '5. Para reunirse con los familiares que viven en Estados Unidos')),
    DropdownMenuItem(
        value: "6",
        child: Text(
            '6. Porque las leyes migratorias facilitan el establecerse en ese país')),
    DropdownMenuItem(
        value: "7",
        child: Text(
            '7. Porque considera que las condiciones en el país no mejorarán')),
    DropdownMenuItem(value: "8", child: Text('8. Por Deudas')),
    DropdownMenuItem(value: "9", child: Text('9. Por violencia en el hogar')),
    DropdownMenuItem(value: "10", child: Text('10. NS/NR')),
  ];

  int _p24 = 0;
  List<DropdownMenuItem<String>> listadoP24 = const [
    DropdownMenuItem(value: "1", child: Text("Sí")),
    DropdownMenuItem(value: "2", child: Text("No")),
  ];

  int _p27 = 0;
  List<DropdownMenuItem<String>> listadoP27 = const [
    DropdownMenuItem(value: "1", child: Text("Sí")),
    DropdownMenuItem(value: "2", child: Text("No")),
  ];

  int _p28 = 0;
  List<DropdownMenuItem<String>> listadoP28 = const [
    DropdownMenuItem(value: "1", child: Text("Sí")),
    DropdownMenuItem(value: "2", child: Text("No")),
  ];

  int _p29 = 0;
  List<DropdownMenuItem<String>> listadoP29 = const [
    DropdownMenuItem(value: "1", child: Text("Sí")),
    DropdownMenuItem(value: "2", child: Text("No")),
    DropdownMenuItem(value: "3", child: Text("NS/NR")),
  ];

  int _p30 = 0;
  List<DropdownMenuItem<String>> listadoP30 = const [
    DropdownMenuItem(value: "1", child: Text("1. Menos de US\$100 al mes")),
    DropdownMenuItem(
        value: "2", child: Text("2. Entre US\$100 y \$300 al mes")),
    DropdownMenuItem(value: "3", child: Text("3. Más de US\$300 al mes")),
    DropdownMenuItem(value: "4", child: Text("4. NS/NR")),
  ];

  int _p32 = 0;
  List<DropdownMenuItem<String>> listadoP32 = const [
    DropdownMenuItem(value: "1", child: Text("1. La persona que las envía")),
    DropdownMenuItem(
        value: "2", child: Text("2. El jefe o jefa de la familia")),
    DropdownMenuItem(value: "3", child: Text("3. Entre ambos")),
    DropdownMenuItem(value: "4", child: Text("4. Otros")),
    DropdownMenuItem(value: "5", child: Text("5. NS/NR")),
  ];

  int _p33 = 0;
  List<DropdownMenuItem<String>> listadoP33 = const [
    DropdownMenuItem(value: "1", child: Text("1. Comida")),
    DropdownMenuItem(value: "2", child: Text("2. Educación")),
    DropdownMenuItem(value: "3", child: Text("3. Vivienda")),
    DropdownMenuItem(value: "4", child: Text("4. Entretenimiento")),
    DropdownMenuItem(value: "5", child: Text("5. Ahorros")),
    DropdownMenuItem(value: "6", child: Text("6. Otro")),
    DropdownMenuItem(value: "7", child: Text("7. NS/NR")),
  ];

  int _p34 = 0;
  List<DropdownMenuItem<String>> listadoP34 = const [
    DropdownMenuItem(value: "1", child: Text("1. No tiene trabajo")),
    DropdownMenuItem(
        value: "2",
        child: Text(
            "2. Porque pese a tener trabajo sus ingresos no son suficientes")),
    DropdownMenuItem(
        value: "3",
        child: Text(
            "3. Porque ha sido amenazado de muerte, extorsionado, etc...")),
    DropdownMenuItem(
        value: "4",
        child: Text("4. Porque el barrio/colonia donde vive es inseguro")),
    DropdownMenuItem(
        value: "5",
        child: Text(
            "5. Para reunirse con los familiares que viven en Estados Unidos")),
    DropdownMenuItem(
        value: "6",
        child: Text(
            "6. Porque las leyes migratorias facilitan el establecerse en ese país")),
    DropdownMenuItem(
        value: "7",
        child: Text(
            "7. Porque considera que las condiciones en el país no mejorarán")),
    DropdownMenuItem(value: "8", child: Text("8. NS/NR")),
  ];

  int _p36 = 0;
  List<DropdownMenuItem<String>> listadoP36 = const [
    DropdownMenuItem(value: "1", child: Text("1. Por el río")),
    DropdownMenuItem(value: "2", child: Text("2. Por el desierto")),
    DropdownMenuItem(value: "3", child: Text("3. En vehículo particular")),
    DropdownMenuItem(value: "4", child: Text("4. En rastra o furgón")),
    DropdownMenuItem(value: "5", child: Text("5. NS/NR")),
  ];

  int _p37 = 0;
  List<DropdownMenuItem<String>> listadoP37 = const [
    DropdownMenuItem(value: "1", child: Text("Sí")),
    DropdownMenuItem(value: "2", child: Text("No")),
  ];

  int _p38 = 0;
  List<DropdownMenuItem<String>> listadoP38 = const [
    DropdownMenuItem(value: "1", child: Text("1. En los Estados Unidos")),
    DropdownMenuItem(value: "2", child: Text("2. En México")),
    DropdownMenuItem(value: "3", child: Text("3. En Guatemala")),
    DropdownMenuItem(value: "4", child: Text("4. En Honduras")),
    DropdownMenuItem(value: "5", child: Text("5. En el Salvador")),
    DropdownMenuItem(value: "6", child: Text("6. NS/NR")),
  ];

  int _p39 = 0;
  List<DropdownMenuItem<String>> listadoP39 = const [
    DropdownMenuItem(value: "1", child: Text("1. Menos de \$1,500 USD")),
    DropdownMenuItem(value: "2", child: Text("2. \$1,501 - \$4,000 USD")),
    DropdownMenuItem(value: "3", child: Text("3. \$4,001 - \$6,000 USD")),
    DropdownMenuItem(value: "4", child: Text("4. \$6,001 - \$8,000 USD")),
    DropdownMenuItem(value: "5", child: Text("5. \$8,001 - \$12,000 USD")),
    DropdownMenuItem(value: "6", child: Text("6. Más de \$12,000 USD")),
  ];

  int _p40 = 0;
  List<DropdownMenuItem<String>> listadoP40 = const [
    DropdownMenuItem(
        value: "1",
        child: Text("1. Viajar nuevamente en los próximos seis meses")),
    DropdownMenuItem(
        value: "2", child: Text("2. Viajar nuevamente en el próximo año")),
    DropdownMenuItem(
        value: "3", child: Text("3. No viajar y establecerse en el país")),
    DropdownMenuItem(value: "4", child: Text("4. No ha decidido aún")),
    DropdownMenuItem(value: "5", child: Text("5. NS/NR")),
  ];

  int _p41 = 0;
  List<DropdownMenuItem<String>> listadoP41 = const [
    DropdownMenuItem(value: "1", child: Text("1. Si tuviera un trabajo")),
    DropdownMenuItem(value: "2", child: Text("2. Si tuviera mayores ingresos")),
    DropdownMenuItem(
        value: "3",
        child: Text("3. Si no estuviera amenazado por la delincuencia")),
    DropdownMenuItem(
        value: "4", child: Text("4. Si no tuviera familiares allá")),
    DropdownMenuItem(
        value: "5",
        child: Text("5. Si endurecen las leyes migratorias de Estados Unidos")),
    DropdownMenuItem(
        value: "6",
        child:
            Text("6. Bajo ninguna condición se quedaría en el país (su país)")),
    DropdownMenuItem(value: "7", child: Text("7. NS/NR")),
  ];

  int _p42 = 0;
  List<DropdownMenuItem<String>> listadoP42 = const [
    DropdownMenuItem(
        value: "1", child: Text("1. Está trabajando para alguien")),
    DropdownMenuItem(
        value: "2",
        child: Text(
            "2. Trabaja por cuenta propia (negocio propio o realizando trabajos particulares)")),
    DropdownMenuItem(value: "3", child: Text("3. Está buscando trabajo")),
    DropdownMenuItem(
        value: "4", child: Text("4. No trabaja y no está buscando trabajo")),
    DropdownMenuItem(value: "5", child: Text("5. Es estudiante")),
    DropdownMenuItem(value: "6", child: Text("6. Es ama de casa")),
    DropdownMenuItem(
        value: "7",
        child: Text("7. Es jubilado/pensionado o incapacitado permanente")),
    DropdownMenuItem(value: "8", child: Text("8. Otro")),
  ];

  int _p43 = 0;
  List<DropdownMenuItem<String>> listadoP43 = const [
    DropdownMenuItem(value: "1", child: Text("Sí")),
    DropdownMenuItem(value: "2", child: Text("No")),
  ];

  int _p44 = 0;
  List<DropdownMenuItem<String>> listadoP44 = [];
  poblarP44(List<DropdownMenuItem<String>> listado) {
    listadoP44.clear();
    listadoP44 = listado;
    notifyListeners();
  }

  int _p45 = 0;
  List<DropdownMenuItem<String>> listadoP45 = const [
    DropdownMenuItem(value: "1", child: Text("Sí")),
    DropdownMenuItem(value: "2", child: Text("No")),
  ];

  int _vivienda = 0;
  List<DropdownMenuItem<String>> listadoVivienda = const [
    DropdownMenuItem(value: "1", child: Text("1. Propia")),
    DropdownMenuItem(value: "2", child: Text("2. Alquilada")),
    DropdownMenuItem(
        value: "3", child: Text("3. Prestada (de familiares o amistades)")),
  ];

  int _p46 = 0;
  List<DropdownMenuItem<String>> listadoP46 = const [
    DropdownMenuItem(value: "1", child: Text("1. Cerámica/granito")),
    DropdownMenuItem(value: "2", child: Text("2. Plancha de cemento")),
    DropdownMenuItem(value: "3", child: Text("3. Madera")),
    DropdownMenuItem(value: "4", child: Text("4. Tierra")),
    DropdownMenuItem(value: "5", child: Text("5. Otro")),
  ];

  int _p47 = 0;
  List<DropdownMenuItem<String>> listadoP47 = [];
  poblarP47(List<DropdownMenuItem<String>> listado) {
    listadoP47.clear();
    listadoP47 = listado;
    notifyListeners();
  }

  int _p48 = 0;
  List<DropdownMenuItem<String>> listadoP48 = const [
    DropdownMenuItem(value: "1", child: Text('1. Servicio público')),
    DropdownMenuItem(value: "2", child: Text('2. Servicio privado colectivo')),
    DropdownMenuItem(value: "3", child: Text('3. Planta propia')),
    DropdownMenuItem(value: "4", child: Text('4. Energía solar')),
    DropdownMenuItem(value: "5", child: Text('5. Vela')),
    DropdownMenuItem(value: "6", child: Text('6. Candil o lámpara de gas')),
    DropdownMenuItem(value: "7", child: Text('7. Ocote')),
    DropdownMenuItem(value: "8", child: Text('8. Otro')),
  ];

  int _p49 = 0;
  List<DropdownMenuItem<String>> listadoP49 = const [
    DropdownMenuItem(
        value: "1", child: Text('1. Inodoro conectado a alcantarilla')),
    DropdownMenuItem(
        value: "2", child: Text('2. Inodoro conectado a pozo séptico')),
    DropdownMenuItem(
        value: "3", child: Text('3. Inodoro con descarga a río, laguna o mar')),
    DropdownMenuItem(
        value: "4", child: Text('4. Letrina con decarga a río, laguna o mar')),
    DropdownMenuItem(
        value: "5", child: Text('5. Letrina con cierre hidráulico')),
    DropdownMenuItem(value: "6", child: Text('6. Letrina con pozo séptico')),
    DropdownMenuItem(value: "7", child: Text('7. Letrina con pozo negro')),
    DropdownMenuItem(value: "8", child: Text('8. Otro')),
    DropdownMenuItem(value: "9", child: Text('9. No tiene')),
    DropdownMenuItem(value: "10", child: Text('10. NS/NR')),
  ];

  int _p50 = 0;
  List<DropdownMenuItem<String>> listadoP50 = const [
    DropdownMenuItem(value: "1", child: Text("Urbana")),
    DropdownMenuItem(value: "2", child: Text("Rural")),
  ];

  int _ppi1 = 0;
  List<DropdownMenuItem<String>> listadoPpi1 = const [
    DropdownMenuItem(value: "1", child: Text("a) Cinco o más")),
    DropdownMenuItem(value: "2", child: Text("b) Cuatro")),
    DropdownMenuItem(value: "3", child: Text("c) Tres")),
    DropdownMenuItem(value: "4", child: Text("d) Dos")),
    DropdownMenuItem(value: "5", child: Text("e) Uno")),
    DropdownMenuItem(value: "6", child: Text("f) Ninguno")),
  ];

  int _ppi2 = 0;
  List<DropdownMenuItem<String>> listadoPpi2 = const [
    DropdownMenuItem(
        value: "1",
        child: Text("a) Ninguno, pre-escolar, programa de alfabetización")),
    DropdownMenuItem(value: "2", child: Text("b) Básica/primaria")),
    DropdownMenuItem(
        value: "3",
        child: Text("c) Ciclo común, no hay jefa/esposa, o sin datos")),
    DropdownMenuItem(value: "4", child: Text("d) Diversificado o mayor")),
  ];

  int _ppi3 = 0;
  List<DropdownMenuItem<String>> listadoPpi3 = [
    DropdownMenuItem(
        value: "1",
        child: Container(
            padding: const EdgeInsets.only(
              bottom: 6,
            ),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
            ),
            child: const Text("a) Sin datos"))),
    DropdownMenuItem(
        value: "2",
        child: Container(
          padding: const EdgeInsets.only(
            bottom: 6,
          ),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey,
                width: 1,
              ),
            ),
          ),
          child: const Text(
              "b) Agricultor, ganadero, trabajador agropecuario o no hay jefe/esposo"),
        )),
    DropdownMenuItem(
        value: "3",
        child: Container(
          padding: const EdgeInsets.only(
            bottom: 6,
          ),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey,
                width: 1,
              ),
            ),
          ),
          child: const Text(
              "c) Comerciante, vendedor, ocupación de los servicios, operador de carga y almacenaje, trabajador en la industria textil, albañilería, mecánica, gráfica, química, alimentos, etc..."),
        )),
    const DropdownMenuItem(
        value: "4",
        child: Text(
            "d) Empleado de oficina, conductor transporte, profesional, técnico, director, gerente, administrador u ocupación afín")),
  ];

  int _ppi4 = 0;
  List<DropdownMenuItem<String>> listadoPpi4 = const [
    DropdownMenuItem(value: "1", child: Text("a) Ninguno")),
    DropdownMenuItem(value: "2", child: Text("b) Uno")),
    DropdownMenuItem(value: "3", child: Text("c) Dos o más")),
  ];

  int _ppi5 = 0;
  List<DropdownMenuItem<String>> listadoPpi5 = const [
    DropdownMenuItem(value: "1", child: Text("a) Uno")),
    DropdownMenuItem(value: "2", child: Text("b) Dos")),
    DropdownMenuItem(value: "3", child: Text("c) Tres")),
    DropdownMenuItem(value: "4", child: Text("d) Cuatro o más")),
  ];

  int _ppi6 = 0;
  List<DropdownMenuItem<String>> listadoPpi6 = const [
    DropdownMenuItem(value: "1", child: Text("a) Tierra, otro o sin datos")),
    DropdownMenuItem(
        value: "2",
        child: Text("b) Ladrillo de barro, plancha de cemento o madera")),
    DropdownMenuItem(value: "3", child: Text("c) Ladrillo de cemento")),
    DropdownMenuItem(
        value: "4", child: Text("d) Cerámica o ladrillo de granito")),
  ];

  int _ppi7 = 0;
  List<DropdownMenuItem<String>> listadoPpi7 = const [
    DropdownMenuItem(
        value: "1", child: Text("a) No servicio público por tubería")),
    DropdownMenuItem(
        value: "2", child: Text("b) Servicio público por tubería")),
  ];

  int _ppi8 = 0;
  List<DropdownMenuItem<String>> listadoPpi8 = const [
    DropdownMenuItem(value: "1", child: Text("a) No")),
    DropdownMenuItem(value: "2", child: Text("b) Sí")),
  ];

  int _ppi9 = 0;
  List<DropdownMenuItem<String>> listadoPpi9 = const [
    DropdownMenuItem(value: "1", child: Text("a) No")),
    DropdownMenuItem(value: "2", child: Text("b) Sí")),
  ];

  int _ppi10 = 0;
  List<DropdownMenuItem<String>> listadoPpi10 = const [
    DropdownMenuItem(value: "1", child: Text("a) No")),
    DropdownMenuItem(value: "2", child: Text("b) Sí, sin cable")),
    DropdownMenuItem(value: "3", child: Text("b) Sí, con cable")),
  ];

  //---------------------MULTISELECTS
  String _p04 = "";
  List<MultiSelectClass> seleccionadosP04 = [];
  final List<MultiSelectClass> opcionesP04 = [
    MultiSelectClass(id: 1, dato: '1. Generar más fuentes de trabajo'),
    MultiSelectClass(
        id: 2,
        dato: '2. Crear políticas para mejorar el ingreso de las familias'),
    MultiSelectClass(
        id: 3,
        dato:
            '3. Reducir la inseguridad (delincuencia común, secuestros, extorsión, etc...)'),
    MultiSelectClass(
        id: 4,
        dato:
            '4. Facilitar oportunidades para que los jóvenes puedan estudiar o capacitación para su inserción laboral'),
    MultiSelectClass(
        id: 5,
        dato:
            '5. Asegurar el acceso a servicios públicos con calidad y costos que puedan cubrir'),
    MultiSelectClass(id: 6, dato: '6. NS/NR'),
  ];
  List<MultiSelectClass> opcionesActP04 = [];
  //Prueba del nuevo multiselect

  String _p05 = "";
  List<MultiSelectClass> seleccionadosP05 = [];
  final List<MultiSelectClass> opcionesP05 = [
    MultiSelectClass(id: 1, dato: '1. No tienen oportunidades de estudio'),
    MultiSelectClass(id: 2, dato: '2. No tienen acceso a un centro educativo'),
    MultiSelectClass(
        id: 3, dato: '3. Para apoyar económicamente a sus familias'),
    MultiSelectClass(id: 4, dato: '4. Huyendo de las maras'),
    MultiSelectClass(
        id: 5, dato: '5. Por maltrato físico y psicológico en su hogar'),
    MultiSelectClass(
        id: 6,
        dato:
            '6. Para reunirse con los familiares  que viven en Estados Unidos'),
    MultiSelectClass(
        id: 7, dato: '7. Porque no pueden cubrir sus necesidades básicas'),
    MultiSelectClass(id: 8, dato: '8. Por mejorar sus ingresos'),
    MultiSelectClass(id: 9, dato: '9. NS/NR'),
  ];
  List<MultiSelectClass> opcionesActP05 = [];

  String _p08 = "";
  List<MultiSelectClass> seleccionadosP08 = [];
  final List<MultiSelectClass> opcionesP08 = [
    MultiSelectClass(
        id: 1, dato: '1. Quisieran irse para EEUU pero nunca lo han intentado'),
    MultiSelectClass(
        id: 2,
        dato:
            '2. Se han ido pero no lograron entrar a los EEUU o fueron deportados'),
    MultiSelectClass(id: 3, dato: '3. Están viviendo actualmente en los EEUU'),
    MultiSelectClass(id: 4, dato: '4. No aplica'),
  ];
  List<MultiSelectClass> opcionesActP08 = [];

  String _p10 = "";
  List<MultiSelectClass> seleccionadosP10 = [];
  final List<MultiSelectClass> opcionesP10 = [
    MultiSelectClass(
        id: 1, dato: '1. Quisieran irse para EEUU pero nunca lo han intentado'),
    MultiSelectClass(
        id: 2,
        dato:
            '2. Se han ido pero no lograron entrar a los EEUU o fueron deportados'),
    MultiSelectClass(id: 3, dato: '3. Están viviendo actualmente en los EEUU'),
    MultiSelectClass(id: 4, dato: '4. No aplica'),
  ];
  List<MultiSelectClass> opcionesActP10 = [];

  String _p12 = "";
  List<MultiSelectClass> seleccionadosP12 = [];
  final List<MultiSelectClass> opcionesP12 = [
    MultiSelectClass(
        id: 1,
        dato: '1. De su nucleo familiar (padres, cónyuge, hijos o hermanos)'),
    MultiSelectClass(
        id: 2, dato: '2. Cercanos (tíos, sobrinos, primos, abuelos o nietos)'),
    MultiSelectClass(id: 3, dato: '3. Lejanos (otros parientes)'),
    MultiSelectClass(id: 4, dato: '4. NS/NR'),
  ];
  List<MultiSelectClass> opcionesActP12 = [];

  String _p31 = "";
  List<MultiSelectClass> seleccionadosP31 = [];
  final List<MultiSelectClass> opcionesP31 = [
    MultiSelectClass(id: 1, dato: '1. Un hijo(a) a sus padres'),
    MultiSelectClass(id: 2, dato: '2. Un padre/madre a sus hijos'),
    MultiSelectClass(id: 3, dato: '3. Un hermanos(a) a otro hermano(a)'),
    MultiSelectClass(id: 4, dato: '4. Otro'),
    MultiSelectClass(id: 5, dato: '5. NS/NR'),
  ];
  List<MultiSelectClass> opcionesActP31 = [];

  String _p35 = "";
  List<MultiSelectClass> seleccionadosP35 = [];
  final List<MultiSelectClass> opcionesP35 = [
    MultiSelectClass(id: 1, dato: '1. En bus'),
    MultiSelectClass(id: 2, dato: '2. En tren'),
    MultiSelectClass(id: 3, dato: '3. En vehículo particular'),
    MultiSelectClass(id: 4, dato: '4. En rastra o furgón'),
    MultiSelectClass(id: 5, dato: '5. En Avioneta'),
    MultiSelectClass(id: 6, dato: '6. NS/NR'),
  ];
  List<MultiSelectClass> opcionesActP35 = [];

  //---------------------MULTISELECTS

  //---------------SECCIÓN DE GETTERS---------------//
  TextEditingController get start => _start;
  TextEditingController get end => _end;
  TextEditingController get today => _today;
  TextEditingController get nomEncuestado => _nomEncuestado;
  TextEditingController get identidad => _identidad;
  TextEditingController get edad => _edad;
  TextEditingController get idPatrocinio => _idPatrocinio;
  TextEditingController get telFacilitador => _telFacilitador;
  TextEditingController get fecha => _fecha;
  TextEditingController get observaciones => _observaciones;
  TextEditingController get lat => _lat;
  TextEditingController get lon => _lon;
  TextEditingController get alt => _alt;
  TextEditingController get acc => _acc;
  TextEditingController get nacimiento => _nacimiento;
  TextEditingController get telefonoEncuestado => _telefonoEncuestado;
  TextEditingController get familias => _familias;
  TextEditingController get miembros => _miembros;
  TextEditingController get nina => _nina;
  TextEditingController get nino => _nino;
  TextEditingController get p15 => _p15;
  TextEditingController get p18 => _p18;
  TextEditingController get p18B => _p18B;
  TextEditingController get otro1 => _otro1;
  int get p39 => _p39;
  TextEditingController get facilitador => _facilitador;

  int get idPais => _idPais;
  int get idDepartamento => _idDepartamento;
  int? get idMunicipio => _idMunicipio;
  int? get comunidad => _comunidad;
  int get estudia => _estudia;
  int get patrocinio => _patrocinio;
  int get sexo => _sexo;
  int get educacion => _educacion;
  int get estado => _estado;
  int get ambosPadres => _ambosPadres;
  int get nnPatrocinado => _nnPatrocinado;
  int get p01 => _p01;
  int get p02 => _p02;
  int get p03 => _p03;
  int get p06 => _p06;
  int get p07 => _p07;
  int get p09 => _p09;
  int get p11 => _p11;
  int get p13 => _p13;
  int get p14 => _p14;
  int get p16 => _p16;
  int get p17 => _p17;
  int get p19 => _p19;
  int get p20 => _p20;
  int get p21 => _p21;
  int get p22 => _p22;
  int get p23 => _p23;
  int get p24 => _p24;
  int get p27 => _p27;
  int get p28 => _p28;
  int get p29 => _p29;
  int get p30 => _p30;
  int get p32 => _p32;
  int get p33 => _p33;
  int get p34 => _p34;
  int get p36 => _p36;
  int get p37 => _p37;
  int get p38 => _p38;
  int get p40 => _p40;
  int get p41 => _p41;
  int get p42 => _p42;
  int get p43 => _p43;
  int get p44 => _p44;
  int get p45 => _p45;
  int get vivienda => _vivienda;
  int get p46 => _p46;
  int get p47 => _p47;
  int get p48 => _p48;
  int get p49 => _p49;
  int get p50 => _p50;
  int get ppi1 => _ppi1;
  int get ppi2 => _ppi2;
  int get ppi3 => _ppi3;
  int get ppi4 => _ppi4;
  int get ppi5 => _ppi5;
  int get ppi6 => _ppi6;
  int get ppi7 => _ppi7;
  int get ppi8 => _ppi8;
  int get ppi9 => _ppi9;
  int get ppi10 => _ppi10;

  String get p04 => _p04;
  String get p05 => _p05;
  String get p08 => _p08;
  String get p10 => _p10;
  String get p12 => _p12;
  String get p31 => _p31;
  String get p35 => _p35;

  //-------------------------SETTERS----------------------//
  //TEXTEDITING CONTROLLERS SETTERS
  set valorstart(String valor) {
    _start.text = valor;
    notifyListeners();
  }

  set valorend(String valor) {
    _end.text = valor;
    notifyListeners();
  }

  set valortoday(String valor) {
    _today.text = valor;
    notifyListeners();
  }

  set valorcomunidad(int? valor) {
    _comunidad = valor;
    notifyListeners();
  }

  set valornomEncuestado(String valor) {
    _nomEncuestado.text = valor;
    notifyListeners();
  }

  set valoridentidad(String valor) {
    _identidad.text = valor;
    notifyListeners();
  }

  set valoredad(String valor) {
    _edad.text = valor;
    notifyListeners();
  }

  set valoridPatrocinio(String valor) {
    _idPatrocinio.text = valor;
    notifyListeners();
  }

  set valortelFacilitador(String valor) {
    _telFacilitador.text = valor;
    notifyListeners();
  }

  set valorfecha(String valor) {
    _fecha.text = valor;
    notifyListeners();
  }

  set valorobservaciones(String valor) {
    _observaciones.text = valor;
    notifyListeners();
  }

  set valorlat(String valor) {
    _lat.text = valor;
    notifyListeners();
  }

  set valorlon(String valor) {
    _lon.text = valor;
    notifyListeners();
  }

  set valoralt(String valor) {
    _alt.text = valor;
    notifyListeners();
  }

  set valoracc(String valor) {
    _acc.text = valor;
    notifyListeners();
  }

  set valornacimiento(String valor) {
    _nacimiento.text = valor;
    notifyListeners();
  }

  set valortelefonoEncuestado(String valor) {
    _telefonoEncuestado.text = valor;
    notifyListeners();
  }

  set valorfamilias(String valor) {
    _familias.text = valor;
    notifyListeners();
  }

  set valormiembros(String valor) {
    _miembros.text = valor;
    notifyListeners();
  }

  set valornina(String valor) {
    _nina.text = valor;
    notifyListeners();
  }

  set valornino(String valor) {
    _nino.text = valor;
    notifyListeners();
  }

  set valorp15(String valor) {
    _p15.text = valor;
    notifyListeners();
  }

  set valorp18(String valor) {
    _p18.text = valor;
    notifyListeners();
  }

  set valorp18B(String valor) {
    _p18B.text = valor;
    notifyListeners();
  }

  set valorotro1(String valor) {
    _otro1.text = valor;
    notifyListeners();
  }

  set valorp39(int valor) {
    _p39 = valor;
    notifyListeners();
  }

  set valorfacilitador(String valor) {
    _facilitador.text = valor;
    notifyListeners();
  }

  //DROPDOWNS SETTERS
  set valorIdPais(int valor) {
    _idPais = valor;
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

  set valorestudia(int valor) {
    _estudia = valor;
    notifyListeners();
  }

  set valorpatrocinio(int valor) {
    _patrocinio = valor;
    notifyListeners();
  }

  set valorsexo(int valor) {
    _sexo = valor;
    notifyListeners();
  }

  set valoreducacion(int valor) {
    _educacion = valor;
    notifyListeners();
  }

  set valorestado(int valor) {
    _estado = valor;
    notifyListeners();
  }

  set valorambosPadres(int valor) {
    _ambosPadres = valor;
    notifyListeners();
  }

  set valornnPatrocinado(int valor) {
    _nnPatrocinado = valor;
    notifyListeners();
  }

  set valorp01(int valor) {
    _p01 = valor;
    notifyListeners();
  }

  set valorp02(int valor) {
    _p02 = valor;
    notifyListeners();
  }

  set valorp03(int valor) {
    _p03 = valor;
    notifyListeners();
  }

  set valorp06(int valor) {
    _p06 = valor;
    notifyListeners();
  }

  set valorp07(int valor) {
    _p07 = valor;
    notifyListeners();
  }

  set valorp09(int valor) {
    _p09 = valor;
    notifyListeners();
  }

  set valorp11(int valor) {
    _p11 = valor;
    notifyListeners();
  }

  set valorp13(int valor) {
    _p13 = valor;
    notifyListeners();
  }

  set valorp14(int valor) {
    _p14 = valor;
    notifyListeners();
  }

  set valorp16(int valor) {
    _p16 = valor;
    notifyListeners();
  }

  set valorp17(int valor) {
    _p17 = valor;
    notifyListeners();
  }

  set valorp19(int valor) {
    _p19 = valor;
    notifyListeners();
  }

  set valorp20(int valor) {
    _p20 = valor;
    notifyListeners();
  }

  set valorp21(int valor) {
    _p21 = valor;
    notifyListeners();
  }

  set valorp22(int valor) {
    _p22 = valor;
    notifyListeners();
  }

  set valorp23(int valor) {
    _p23 = valor;
    notifyListeners();
  }

  set valorp24(int valor) {
    _p24 = valor;
    notifyListeners();
  }

  set valorp27(int valor) {
    _p27 = valor;
    notifyListeners();
  }

  set valorp28(int valor) {
    _p28 = valor;
    notifyListeners();
  }

  set valorp29(int valor) {
    _p29 = valor;
    notifyListeners();
  }

  set valorp30(int valor) {
    _p30 = valor;
    notifyListeners();
  }

  set valorp32(int valor) {
    _p32 = valor;
    notifyListeners();
  }

  set valorp33(int valor) {
    _p33 = valor;
    notifyListeners();
  }

  set valorp34(int valor) {
    _p34 = valor;
    notifyListeners();
  }

  set valorp36(int valor) {
    _p36 = valor;
    notifyListeners();
  }

  set valorp37(int valor) {
    _p37 = valor;
    notifyListeners();
  }

  set valorp38(int valor) {
    _p38 = valor;
    notifyListeners();
  }

  set valorp40(int valor) {
    _p40 = valor;
    notifyListeners();
  }

  set valorp41(int valor) {
    _p41 = valor;
    notifyListeners();
  }

  set valorp42(int valor) {
    _p42 = valor;
    notifyListeners();
  }

  set valorp43(int valor) {
    _p43 = valor;
    notifyListeners();
  }

  set valorp44(int valor) {
    _p44 = valor;
    notifyListeners();
  }

  set valorp45(int valor) {
    _p45 = valor;
    notifyListeners();
  }

  set valorvivienda(int valor) {
    _vivienda = valor;
    notifyListeners();
  }

  set valorp46(int valor) {
    _p46 = valor;
    notifyListeners();
  }

  set valorp47(int valor) {
    _p47 = valor;
    notifyListeners();
  }

  set valorp48(int valor) {
    _p48 = valor;
    notifyListeners();
  }

  set valorp49(int valor) {
    _p49 = valor;
    notifyListeners();
  }

  set valorp50(int valor) {
    _p50 = valor;
    notifyListeners();
  }

  set valorppi1(int valor) {
    _ppi1 = valor;
    notifyListeners();
  }

  set valorppi2(int valor) {
    _ppi2 = valor;
    notifyListeners();
  }

  set valorppi3(int valor) {
    _ppi3 = valor;
    notifyListeners();
  }

  set valorppi4(int valor) {
    _ppi4 = valor;
    notifyListeners();
  }

  set valorppi5(int valor) {
    _ppi5 = valor;
    notifyListeners();
  }

  set valorppi6(int valor) {
    _ppi6 = valor;
    notifyListeners();
  }

  set valorppi7(int valor) {
    _ppi7 = valor;
    notifyListeners();
  }

  set valorppi8(int valor) {
    _ppi8 = valor;
    notifyListeners();
  }

  set valorppi9(int valor) {
    _ppi9 = valor;
    notifyListeners();
  }

  set valorppi10(int valor) {
    _ppi10 = valor;
    notifyListeners();
  }

  //MULTISELECTS SETTERS
  set valorp04(String valor) {
    _p04 = valor;
    notifyListeners();
  }

  set valorp05(String valor) {
    _p05 = valor;
    notifyListeners();
  }

  set valorp08(String valor) {
    _p08 = valor;
    notifyListeners();
  }

  set valorp10(String valor) {
    _p10 = valor;
    notifyListeners();
  }

  set valorp12(String valor) {
    _p12 = valor;
    notifyListeners();
  }

  set valorp31(String valor) {
    _p31 = valor;
    notifyListeners();
  }

  set valorp35(String valor) {
    _p35 = valor;
    notifyListeners();
  }

  //-----------------RESETEAR TODAS LAS VARIABLES
  resetearVariables() {
    _start.clear();
    _end.clear();
    _today.clear();
    _comunidad = null;
    _nomEncuestado.clear();
    _identidad.clear();
    _edad.clear();
    _idPatrocinio.clear();
    _telFacilitador.clear();
    _fecha.clear();
    _observaciones.clear();
    _lat.clear();
    _lon.clear();
    _alt.clear();
    _acc.clear();
    _nacimiento.clear();
    _telefonoEncuestado.clear();
    _familias.clear();
    _miembros.clear();
    _nina.clear();
    _nino.clear();
    _p15.clear();
    _p18.clear();
    _p18B.clear();
    _otro1.clear();
    _p39 = 0;
    _facilitador.clear();

    _idPais = 0;
    _idDepartamento = 0;
    _idMunicipio = null;
    _estudia = 0;
    _patrocinio = 0;
    _sexo = 0;
    _educacion = 0;
    _estado = 0;
    _ambosPadres = 0;
    _nnPatrocinado = 0;
    _p01 = 0;
    _p02 = 0;
    _p03 = 0;
    _p06 = 0;
    _p07 = 0;
    _p09 = 0;
    _p11 = 0;
    _p13 = 0;
    _p14 = 0;
    _p16 = 0;
    _p17 = 0;
    _p19 = 0;
    _p20 = 0;
    _p21 = 0;
    _p22 = 0;
    _p23 = 0;
    _p24 = 0;
    _p27 = 0;
    _p28 = 0;
    _p29 = 0;
    _p30 = 0;
    _p32 = 0;
    _p33 = 0;
    _p34 = 0;
    _p36 = 0;
    _p37 = 0;
    _p38 = 0;
    _p40 = 0;
    _p41 = 0;
    _p42 = 0;
    _p43 = 0;
    _p44 = 0;
    _p45 = 0;
    _vivienda = 0;
    _p46 = 0;
    _p47 = 0;
    _p48 = 0;
    _p49 = 0;
    _p50 = 0;
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

    _p04 = "";
    _p05 = "";
    _p08 = "";
    _p10 = "";
    _p12 = "";
    _p31 = "";
    _p35 = "";
    notifyListeners();
  }
}

class MultiSelectClass {
  final int id;
  final String dato;

  MultiSelectClass({
    required this.id,
    required this.dato,
  });
}
