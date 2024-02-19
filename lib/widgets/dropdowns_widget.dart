import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sat_m/bd/bd.dart';
import 'package:sat_m/modelos/comunidades_modelo.dart';
import 'package:sat_m/modelos/municipios_modelo.dart';
import 'package:sat_m/modelos/preguntas_ponderaciones_modelo.dart';
import 'package:sat_m/modelos/satm_preguntas_modelo.dart';
import 'package:sat_m/providers/condiciones_comunidades_provider.dart';
import 'package:sat_m/providers/condiciones_familias_provider.dart';
import 'package:sat_m/providers/condiciones_miembros_migrantes_provider.dart';
import 'package:sat_m/providers/indice_pobreza_provider.dart';
import 'package:sat_m/providers/miembros_migrantes_provider.dart';
import 'package:sat_m/providers/propension_migracion_provider.dart';
import 'package:sat_m/providers/satm_comunidades_provider.dart';
import 'package:sat_m/providers/satm_familias_provider.dart';

// ignore: must_be_immutable
class DropdownSencillo extends StatefulWidget {
  String? valorInicial;
  final List<DropdownMenuItem<String>> listado;
  final String caso;
  final bool? habilitado;
  final String? placeholder;

  DropdownSencillo({
    required this.caso,
    this.valorInicial,
    required this.listado,
    this.habilitado = true,
    this.placeholder,
    super.key,
  });

  @override
  State<DropdownSencillo> createState() => _DropdownSencilloState();
}

class _DropdownSencilloState extends State<DropdownSencillo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black45),
        borderRadius: BorderRadius.circular(15),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField<String>(
          value: widget.valorInicial,
          hint: Text(widget.placeholder.toString()),
          borderRadius: BorderRadius.circular(15),
          icon: const Icon(Icons.arrow_drop_down),
          style: GoogleFonts.lato(fontSize: 16, color: Colors.black),
          isExpanded: true,
          onChanged: widget.habilitado!
              ? (String? value) async {
                  //Iniciar providers necesarios
                  var comunidadesProvider =
                      Provider.of<SatmComunidadesProvider>(context,
                          listen: false);

                  var familiasProvider =
                      Provider.of<SatmFamiliasProvider>(context, listen: false);

                  var condicionesComunidadesProvider =
                      Provider.of<CondicionesComunidadesProvider>(context,
                          listen: false);

                  var condicionesFamiliasProvider =
                      Provider.of<CondicionesFamiliasProvider>(context,
                          listen: false);

                  var indicePobrezaProvider =
                      Provider.of<IndicePobrezaProvider>(context,
                          listen: false);

                  var propensionProvider =
                      Provider.of<PropensionMigracionProvider>(context,
                          listen: false);

                  var miembrosMigrantesProvider =
                      Provider.of<MiembrosMigrantesProvider>(context,
                          listen: false);

                  var condicionesMigrantesProvider =
                      Provider.of<MiembrosMigrantesCondicionesProvider>(context,
                          listen: false);

                  //Función para calcular la PROPENSIÓN A LA MIGRACIÓN
                  calcularPropension(
                      {required String codigoPregunta,
                      required int opcion}) async {
                    //Obtener el id de la pregunta (por código de la pregunta)
                    List<PreguntasModelo> pregunta = await DatabaseSatM.instance
                        .obtenerIdPregunta(codigoPregunta);
                    int idPregunta = pregunta[0].idPregunta;
                    //Obtener el puntaje de la BD
                    List<PreguntasPonderacionesModelo> ponderacionDeBD =
                        await DatabaseSatM.instance
                            .obtenerPonderacionPorIdyValor(idPregunta, opcion);
                    double ponderacion = 0;
                    if (ponderacionDeBD.isNotEmpty) {
                      ponderacion =
                          double.parse(ponderacionDeBD[0].ponderacion);
                    }
                    //Asignar el valor al provider
                    switch (codigoPregunta) {
                      case 'p09':
                        propensionProvider.valorP9 = ponderacion;
                        //actualizar Propensión
                        propensionProvider.actualizarPropension();
                        break;

                      case 'p11':
                        propensionProvider.valorP11 = ponderacion;
                        //actualizar Propensión
                        propensionProvider.actualizarPropension();
                        break;

                      case 'p16':
                        propensionProvider.valorP16 = ponderacion;
                        //actualizar Propensión
                        propensionProvider.actualizarPropension();
                        break;

                      case 'p17':
                        propensionProvider.valorP17 = ponderacion;
                        //actualizar Propensión
                        propensionProvider.actualizarPropension();
                        break;

                      case 'p20':
                        propensionProvider.valorP20 = ponderacion;
                        //actualizar Propensión
                        propensionProvider.actualizarPropension();
                        break;

                      case 'p21':
                        propensionProvider.valorP21 = ponderacion;
                        //actualizar Propensión
                        propensionProvider.actualizarPropension();
                        break;

                      case 'p23':
                        propensionProvider.valorP23 = ponderacion;
                        //actualizar Propensión
                        propensionProvider.actualizarPropension();
                        break;

                      case 'p26':
                        propensionProvider.valorP26 = ponderacion;
                        //actualizar Propensión
                        propensionProvider.actualizarPropension();
                        break;

                      case 'p27':
                        propensionProvider.valorP27 = ponderacion;
                        //actualizar Propensión
                        propensionProvider.actualizarPropension();
                        break;

                      case 'p28':
                        propensionProvider.valorP28 = ponderacion;
                        //actualizar Propensión
                        propensionProvider.actualizarPropension();
                        break;

                      case 'p40':
                        propensionProvider.valorP40 = ponderacion;
                        //actualizar Propensión
                        propensionProvider.actualizarPropension();
                        break;

                      case 'p42':
                        propensionProvider.valorP42 = ponderacion;
                        //actualizar Propensión
                        propensionProvider.actualizarPropension();
                        break;

                      case 'p44':
                        propensionProvider.valorP44 = ponderacion;
                        //actualizar Propensión
                        propensionProvider.actualizarPropension();
                        break;

                      case 'p46':
                        propensionProvider.valorP46 = ponderacion;
                        //actualizar Propensión
                        propensionProvider.actualizarPropension();
                        break;

                      case 'p47':
                        propensionProvider.valorP47 = ponderacion;
                        //actualizar Propensión
                        propensionProvider.actualizarPropension();
                        break;

                      case 'p48':
                        propensionProvider.valorP48 = ponderacion;
                        //actualizar Propensión
                        propensionProvider.actualizarPropension();
                        break;

                      case 'p49':
                        propensionProvider.valorP49 = ponderacion;
                        //actualizar Propensión
                        propensionProvider.actualizarPropension();
                        break;
                    }
                  }

                  //Función para calcular el Índice de Calificación de la Pobreza
                  calcularICP(
                      {required String codigoPregunta,
                      required int opcion}) async {
                    //-------------------Cálculo del Índice de Pobreza
                    //Obtener el id de la pregunta (por código de la pregunta)
                    List<PreguntasModelo> pregunta = await DatabaseSatM.instance
                        .obtenerIdPregunta(codigoPregunta);
                    int idPregunta = pregunta[0].idPregunta;
                    //Obtener el puntaje de la BD
                    List<PreguntasPonderacionesModelo> ponderacionDeBD =
                        await DatabaseSatM.instance
                            .obtenerPonderacionPorIdyValor(idPregunta, opcion);
                    double ponderacion =
                        double.parse(ponderacionDeBD[0].ponderacion);
                    //Asignar el valor al provider
                    switch (codigoPregunta) {
                      case 'ppi1':
                        indicePobrezaProvider.valorPpi1 = ponderacion;
                        //actualizar indiceGlobal
                        indicePobrezaProvider.valorIndiceICP();
                        break;

                      case 'ppi2':
                        indicePobrezaProvider.valorPpi2 = ponderacion;
                        //actualizar indiceGlobal
                        indicePobrezaProvider.valorIndiceICP();
                        break;

                      case 'ppi3':
                        indicePobrezaProvider.valorPpi3 = ponderacion;
                        //actualizar indiceGlobal
                        indicePobrezaProvider.valorIndiceICP();
                        break;

                      case 'ppi4':
                        indicePobrezaProvider.valorPpi4 = ponderacion;
                        //actualizar indiceGlobal
                        indicePobrezaProvider.valorIndiceICP();
                        break;

                      case 'ppi5':
                        indicePobrezaProvider.valorPpi5 = ponderacion;
                        //actualizar indiceGlobal
                        indicePobrezaProvider.valorIndiceICP();
                        break;

                      case 'ppi6':
                        indicePobrezaProvider.valorPpi6 = ponderacion;
                        //actualizar indiceGlobal
                        indicePobrezaProvider.valorIndiceICP();
                        break;

                      case 'ppi7':
                        indicePobrezaProvider.valorPpi7 = ponderacion;
                        //actualizar indiceGlobal
                        indicePobrezaProvider.valorIndiceICP();
                        break;

                      case 'ppi8':
                        indicePobrezaProvider.valorPpi8 = ponderacion;
                        //actualizar indiceGlobal
                        indicePobrezaProvider.valorIndiceICP();
                        break;

                      case 'ppi9':
                        indicePobrezaProvider.valorPpi9 = ponderacion;
                        //actualizar indiceGlobal
                        indicePobrezaProvider.valorIndiceICP();
                        break;

                      case 'ppi10':
                        indicePobrezaProvider.valorPpi10 = ponderacion;
                        //actualizar indiceGlobal
                        indicePobrezaProvider.valorIndiceICP();
                        break;
                    }
                  }

                  switch (widget.caso) {
//------------------PARA FORMULARIO COMUNIDADES
                    case "pais":
                      comunidadesProvider.valorIdPais = int.parse(value!);
                      break;

                    case "departamento":
                      comunidadesProvider.valorIdDepartamento =
                          int.parse(value!);

                      //Hacer null el dropdown dependiente (para evitar errores)
                      comunidadesProvider.valorIdMunicipio = null;
                      comunidadesProvider.valorComunidad = null;

                      //Generar listado para municipios (por id departamento)
                      List<DropdownMenuItem<String>> munisProvi = [];
                      List<MunicipiosModelo> munisPorDepto =
                          await DatabaseSatM.instance.obtenerMunicipiosPorDepto(
                              comunidadesProvider.idDepartamento);
                      for (int i = 0; i < munisPorDepto.length; i++) {
                        munisProvi.add(DropdownMenuItem(
                            value: munisPorDepto[i].idMunicipio.toString(),
                            child: Text(munisPorDepto[i].municipio)));
                      }
                      comunidadesProvider.poblarMunicipios(munisProvi);

                      break;

                    case "municipio":
                      comunidadesProvider.valorIdMunicipio = int.parse(value!);

                      //Hacer null el dropdown dependiente (para evitar errores)
                      comunidadesProvider.valorComunidad = null;

                      //Generar listado para comunidades (por id municipio)
                      List<DropdownMenuItem<String>> comunisProvi = [];
                      List<ComunidadesModuloModelo> comunisPorMuni =
                          await DatabaseSatM.instance.obtenerComunidadesModulo(
                              comunidadesProvider.idMunicipio!);
                      for (int i = 0; i < comunisPorMuni.length; i++) {
                        comunisProvi.add(DropdownMenuItem(
                            value: comunisPorMuni[i].idComunidad.toString(),
                            child: Text(comunisPorMuni[i].nombreComunidad)));
                      }
                      comunidadesProvider.poblarComunidades(comunisProvi);
                      break;

                    case "comunidad":
                      comunidadesProvider.valorComunidad = int.parse(value!);
                      break;

                    case "sexo":
                      comunidadesProvider.valorSexo = int.parse(value!);
                      break;

                    case "educacion":
                      comunidadesProvider.valorEducacion = int.parse(value!);
                      if (int.parse(value) != 1) {
                        condicionesComunidadesProvider.valorCondicion9 = true;
                      } else {
                        condicionesComunidadesProvider.valorCondicion9 = false;
                      }
                      break;

                    case "estado_civil":
                      comunidadesProvider.valorEstado = int.parse(value!);
                      break;

                    case "ambos_padres":
                      comunidadesProvider.valorAmbosPadres = int.parse(value!);
                      break;

                    case "nn_patrocinado":
                      comunidadesProvider.valorNnPatrocinado =
                          int.parse(value!);

                      if (value == "1") {
                        condicionesComunidadesProvider.valorCondicion14 = true;
                      } else {
                        condicionesComunidadesProvider.valorCondicion14 = false;
                      }
                      break;

                    case "b1":
                      comunidadesProvider.valorB1 = int.parse(value!);
                      break;

                    case "b2":
                      comunidadesProvider.valorB2 = int.parse(value!);
                      break;

                    case "c1":
                      comunidadesProvider.valorC1 = int.parse(value!);
                      break;

                    case "c2":
                      comunidadesProvider.valorC2 = int.parse(value!);
                      break;

                    case "c3":
                      comunidadesProvider.valorC3 = int.parse(value!);
                      break;

                    case "d1":
                      comunidadesProvider.valorD1 = int.parse(value!);

                      if (value == "1") {
                        condicionesComunidadesProvider.valorCondicion21 = true;
                      } else {
                        condicionesComunidadesProvider.valorCondicion21 = false;
                      }
                      break;

                    case "d2":
                      comunidadesProvider.valorD2 = int.parse(value!);
                      break;

                    case "d3":
                      comunidadesProvider.valorD3 = int.parse(value!);

                      if (value == "1" || comunidadesProvider.d4 == 1) {
                        condicionesComunidadesProvider.valorCondicion23y24 =
                            true;
                      } else {
                        condicionesComunidadesProvider.valorCondicion23y24 =
                            false;
                      }
                      break;

                    case "d4":
                      comunidadesProvider.valorD4 = int.parse(value!);

                      if (value == "1" || comunidadesProvider.d3 == 1) {
                        condicionesComunidadesProvider.valorCondicion23y24 =
                            true;
                      } else {
                        condicionesComunidadesProvider.valorCondicion23y24 =
                            false;
                      }
                      break;

                    case "d9":
                      comunidadesProvider.valorD9 = int.parse(value!);
                      break;

                    case "d5":
                      comunidadesProvider.valorD5 = int.parse(value!);

                      if (value == "1") {
                        condicionesComunidadesProvider.valorCondicion26 = true;
                      } else {
                        condicionesComunidadesProvider.valorCondicion26 = false;
                      }
                      break;

                    case "d6":
                      comunidadesProvider.valorD6 = int.parse(value!);

                      if (int.parse(value) == 1) {
                        condicionesComunidadesProvider.valorCondicion27 = true;
                      } else {
                        condicionesComunidadesProvider.valorCondicion27 = false;
                      }
                      break;

                    case "d7":
                      comunidadesProvider.valorD7 = int.parse(value!);
                      break;

                    case "d8":
                      comunidadesProvider.valorD8 = int.parse(value!);
                      break;

                    case "e1":
                      comunidadesProvider.valorE1 = int.parse(value!);
                      break;

                    case "e2":
                      comunidadesProvider.valorE2 = int.parse(value!);
                      break;

                    case "encuestador":
                      comunidadesProvider.valorFacilitador = value!;
                      break;

//------------------PARA FORMULARIO FAMILIAS
                    case "pais_familias":
                      familiasProvider.valorIdPais = int.parse(value!);
                      break;

                    case "departamento_familias":
                      familiasProvider.valoridDepartamento = int.parse(value!);

                      //Hacer null el dropdown dependiente (para evitar errores)
                      familiasProvider.valoridMunicipio = null;
                      familiasProvider.valorcomunidad = null;

                      //Generar listado para municipios (por id departamento)
                      List<DropdownMenuItem<String>> munisProvi = [];
                      List<MunicipiosModelo> munisPorDepto =
                          await DatabaseSatM.instance.obtenerMunicipiosPorDepto(
                              familiasProvider.idDepartamento);
                      for (int i = 0; i < munisPorDepto.length; i++) {
                        munisProvi.add(DropdownMenuItem(
                            value: munisPorDepto[i].idMunicipio.toString(),
                            child: Text(munisPorDepto[i].municipio)));
                      }
                      familiasProvider.poblarMunicipios(munisProvi);
                      break;

                    case "municipio_familias":
                      familiasProvider.valoridMunicipio = int.parse(value!);

                      //Hacer null el dropdown dependiente (para evitar errores)
                      familiasProvider.valorcomunidad = null;

                      //Generar listado para comunidades (por id municipio)
                      List<DropdownMenuItem<String>> comunisProvi = [];
                      List<ComunidadesModuloModelo> comunisPorMuni =
                          await DatabaseSatM.instance.obtenerComunidadesModulo(
                              familiasProvider.idMunicipio!);
                      for (int i = 0; i < comunisPorMuni.length; i++) {
                        comunisProvi.add(DropdownMenuItem(
                            value: comunisPorMuni[i].idComunidad.toString(),
                            child: Text(comunisPorMuni[i].nombreComunidad)));
                      }
                      familiasProvider.poblarComunidades(comunisProvi);
                      break;

                    case "comunidad_familias":
                      familiasProvider.valorcomunidad = int.parse(value!);
                      break;

                    case "patrocinio_familias":
                      familiasProvider.valorpatrocinio = int.parse(value!);
                      break;

                    case "sexo_familias":
                      familiasProvider.valorsexo = int.parse(value!);
                      break;

                    case "estudia_familias":
                      familiasProvider.valorestudia = int.parse(value!);
                      break;

                    case "educacion_familias":
                      familiasProvider.valoreducacion = int.parse(value!);
                      break;

                    case "estado_civil_familias":
                      familiasProvider.valorestado = int.parse(value!);
                      break;

                    case "ambosPadres_familias":
                      familiasProvider.valorambosPadres = int.parse(value!);
                      break;

                    case "nnPatrocinado_familias":
                      familiasProvider.valornnPatrocinado = int.parse(value!);

                      if (int.parse(value) == 1) {
                        condicionesFamiliasProvider
                            .valorCondicionNnPatrocinados = true;
                      } else {
                        condicionesFamiliasProvider
                            .valorCondicionNnPatrocinados = false;
                      }
                      break;

                    case "p01_familias":
                      familiasProvider.valorp01 = int.parse(value!);
                      break;

                    case "p02_familias":
                      familiasProvider.valorp02 = int.parse(value!);
                      break;

                    case "p03_familias":
                      familiasProvider.valorp03 = int.parse(value!);
                      break;

                    case "p06_familias":
                      familiasProvider.valorp06 = int.parse(value!);
                      break;

                    case "p07_familias":
                      familiasProvider.valorp07 = int.parse(value!);
                      break;

                    case "p09_familias":
                      familiasProvider.valorp09 = int.parse(value!);

                      calcularPropension(
                          codigoPregunta: 'p09', opcion: familiasProvider.p09);
                      break;

                    case "p11_familias":
                      familiasProvider.valorp11 = int.parse(value!);

                      calcularPropension(
                          codigoPregunta: 'p11', opcion: familiasProvider.p11);
                      break;

                    case "p13_familias":
                      familiasProvider.valorp13 = int.parse(value!);
                      break;

                    case "p14_familias":
                      familiasProvider.valorp14 = int.parse(value!);

                      if (value == "1") {
                        condicionesFamiliasProvider.valorCondicionP14 = true;
                        condicionesFamiliasProvider.valorCondicionP14y24 = true;
                      } else {
                        condicionesFamiliasProvider.valorCondicionP14 = false;

                        //Chequear que la p24 no sea false
                        if (familiasProvider.p24 == 2 ||
                            familiasProvider.p24 == 0) {
                          condicionesFamiliasProvider.valorCondicionP14y24 =
                              false;
                        }
                      }
                      break;

                    case "p16_familias":
                      familiasProvider.valorp16 = int.parse(value!);

                      calcularPropension(
                          codigoPregunta: 'p16', opcion: familiasProvider.p16);
                      break;

                    case "p17_familias":
                      familiasProvider.valorp17 = int.parse(value!);
                      if (value == "1") {
                        condicionesFamiliasProvider.valorCondicionP17 = true;
                      } else {
                        condicionesFamiliasProvider.valorCondicionP17 = false;
                        //Resetear los valores 18a y 18b
                        familiasProvider.valorp18 = "0";
                        familiasProvider.valorp18B = "0";
                        familiasProvider.valorp19 = 0;
                      }

                      calcularPropension(
                          codigoPregunta: 'p17', opcion: familiasProvider.p17);
                      break;

                    case "p19_familias":
                      familiasProvider.valorp19 = int.parse(value!);
                      break;

                    case "p20_familias":
                      familiasProvider.valorp20 = int.parse(value!);

                      if (familiasProvider.p20 == 1) {
                        condicionesFamiliasProvider.valorCondicionP20y21 = true;
                      } else {
                        //Chequear que la p21 lo cumpla por igual
                        if (familiasProvider.p21 != 1) {
                          condicionesFamiliasProvider.valorCondicionP20y21 =
                              false;
                        }

                        calcularPropension(
                            codigoPregunta: 'p20',
                            opcion: familiasProvider.p20);
                      }
                      break;

                    //de oscar
                    case "p21_familia":
                      familiasProvider.valorp21 = int.parse(value!);

                      if (familiasProvider.p21 == 1) {
                        condicionesFamiliasProvider.valorCondicionP20y21 = true;
                      } else {
                        //Chequear que la p20 lo cumpla por igual
                        if (familiasProvider.p20 != 1) {
                          condicionesFamiliasProvider.valorCondicionP20y21 =
                              false;
                        }

                        calcularPropension(
                            codigoPregunta: 'p21',
                            opcion: familiasProvider.p21);
                      }
                      break;

                    case "p22_familia":
                      familiasProvider.valorp22 = int.parse(value!);
                      break;

                    case "p23_familia":
                      familiasProvider.valorp23 = int.parse(value!);

                      calcularPropension(
                          codigoPregunta: 'p23', opcion: familiasProvider.p23);
                      break;

                    case "p24_familia":
                      familiasProvider.valorp24 = int.parse(value!);

                      if (int.parse(value) == 1) {
                        condicionesFamiliasProvider.valorCondicionP24 = true;
                        condicionesFamiliasProvider.valorCondicionP14y24 = true;
                      } else {
                        condicionesFamiliasProvider.valorCondicionP24 = false;

                        //Chequear que la p14 no sea false
                        if (familiasProvider.p14 == 2 ||
                            familiasProvider.p14 == 0) {
                          condicionesFamiliasProvider.valorCondicionP14y24 =
                              false;
                        }
                      }
                      break;

                    case "p27_familia":
                      familiasProvider.valorp27 = int.parse(value!);

                      calcularPropension(
                          codigoPregunta: 'p27', opcion: familiasProvider.p27);
                      break;

                    case "p28_familia":
                      familiasProvider.valorp28 = int.parse(value!);

                      calcularPropension(
                          codigoPregunta: 'p28', opcion: familiasProvider.p28);
                      break;

                    case "p29_familia":
                      familiasProvider.valorp29 = int.parse(value!);
                      if (value == "1") {
                        condicionesFamiliasProvider.valorCondicionP29 = true;
                      } else {
                        condicionesFamiliasProvider.valorCondicionP29 = false;
                      }
                      break;

                    case "p30_familia":
                      familiasProvider.valorp30 = int.parse(value!);
                      break;

                    case "p32_familia":
                      familiasProvider.valorp32 = int.parse(value!);
                      if (value == "4") {
                        condicionesFamiliasProvider.valorCondicionP32 = true;
                      } else {
                        condicionesFamiliasProvider.valorCondicionP32 = false;
                      }
                      break;

                    case "p33_familia":
                      familiasProvider.valorp33 = int.parse(value!);
                      break;

                    case "p34_familia":
                      familiasProvider.valorp34 = int.parse(value!);
                      break;

                    case "p36_familia":
                      familiasProvider.valorp36 = int.parse(value!);
                      break;

                    case "p37_familia":
                      familiasProvider.valorp37 = int.parse(value!);
                      if (value == "1") {
                        condicionesFamiliasProvider.valorCondicionP37 = true;
                      } else {
                        condicionesFamiliasProvider.valorCondicionP37 = false;
                      }
                      break;

                    case "p38_familia":
                      familiasProvider.valorp38 = int.parse(value!);
                      break;

                    case "p39_familia":
                      familiasProvider.valorp39 = int.parse(value!);
                      break;

                    case "p40_familia":
                      familiasProvider.valorp40 = int.parse(value!);

                      if (familiasProvider.p40 == 1 ||
                          familiasProvider.p40 == 2) {
                        condicionesFamiliasProvider.valorCondicionP40 = true;
                      } else {
                        condicionesFamiliasProvider.valorCondicionP40 = false;
                      }

                      calcularPropension(
                          codigoPregunta: 'p40', opcion: familiasProvider.p40);
                      break;

                    //de andres
                    case "p41_familias":
                      familiasProvider.valorp41 = int.parse(value!);
                      break;

                    case "p42_familias":
                      familiasProvider.valorp42 = int.parse(value!);

                      calcularPropension(
                          codigoPregunta: 'p42', opcion: familiasProvider.p42);
                      break;

                    case "p43_familias":
                      familiasProvider.valorp43 = int.parse(value!);
                      break;

                    case "p44_familias":
                      familiasProvider.valorp44 = int.parse(value!);

                      calcularPropension(
                          codigoPregunta: 'p44', opcion: familiasProvider.p44);
                      break;

                    case "p45_familias":
                      familiasProvider.valorp45 = int.parse(value!);
                      break;

                    case "vivienda_familias":
                      familiasProvider.valorvivienda = int.parse(value!);
                      break;

                    case "p46_familias":
                      familiasProvider.valorp46 = int.parse(value!);

                      calcularPropension(
                          codigoPregunta: 'p46', opcion: familiasProvider.p46);
                      break;

                    case "p47_familias":
                      familiasProvider.valorp47 = int.parse(value!);

                      calcularPropension(
                          codigoPregunta: 'p47', opcion: familiasProvider.p47);
                      break;

                    case "p48_familias":
                      familiasProvider.valorp48 = int.parse(value!);

                      calcularPropension(
                          codigoPregunta: 'p48', opcion: familiasProvider.p48);
                      break;

                    case "p49_familias":
                      familiasProvider.valorp49 = int.parse(value!);

                      calcularPropension(
                          codigoPregunta: 'p49', opcion: familiasProvider.p49);
                      break;

                    case "p50_familias":
                      familiasProvider.valorp50 = int.parse(value!);
                      break;

                    case "pppi1_familias":
                      familiasProvider.valorppi1 = int.parse(value!);
                      calcularICP(
                          codigoPregunta: 'ppi1',
                          opcion: familiasProvider.ppi1);
                      break;

                    case "pppi2_familias":
                      familiasProvider.valorppi2 = int.parse(value!);
                      calcularICP(
                          codigoPregunta: 'ppi2',
                          opcion: familiasProvider.ppi2);
                      break;

                    case "pppi3_familias":
                      familiasProvider.valorppi3 = int.parse(value!);
                      calcularICP(
                          codigoPregunta: 'ppi3',
                          opcion: familiasProvider.ppi3);
                      break;

                    case "pppi4_familias":
                      familiasProvider.valorppi4 = int.parse(value!);
                      calcularICP(
                          codigoPregunta: 'ppi4',
                          opcion: familiasProvider.ppi4);
                      break;

                    case "pppi5_familias":
                      familiasProvider.valorppi5 = int.parse(value!);
                      calcularICP(
                          codigoPregunta: 'ppi5',
                          opcion: familiasProvider.ppi5);
                      break;

                    case "pppi6_familias":
                      familiasProvider.valorppi6 = int.parse(value!);
                      calcularICP(
                          codigoPregunta: 'ppi6',
                          opcion: familiasProvider.ppi6);
                      break;

                    case "pppi7_familias":
                      familiasProvider.valorppi7 = int.parse(value!);
                      calcularICP(
                          codigoPregunta: 'ppi7',
                          opcion: familiasProvider.ppi7);
                      break;

                    case "pppi8_familias":
                      familiasProvider.valorppi8 = int.parse(value!);
                      calcularICP(
                          codigoPregunta: 'ppi8',
                          opcion: familiasProvider.ppi8);
                      break;

                    case "pppi9_familias":
                      familiasProvider.valorppi9 = int.parse(value!);
                      calcularICP(
                          codigoPregunta: 'ppi9',
                          opcion: familiasProvider.ppi9);
                      break;

                    case "pppi10_familias":
                      familiasProvider.valorppi10 = int.parse(value!);
                      calcularICP(
                          codigoPregunta: 'ppi10',
                          opcion: familiasProvider.ppi10);
                      break;

                    case "encuestador_familia":
                      familiasProvider.valorfacilitador = value!;
                      break;

//----------------PARA MIEMBROS MIGRANTES
                    case "retornado_miembros_migrantes":
                      miembrosMigrantesProvider.valorretornado =
                          int.parse(value!);

                      if (miembrosMigrantesProvider.retornado == 1) {
                        condicionesMigrantesProvider.valorCondicion0 = true;
                      } else {
                        condicionesMigrantesProvider.valorCondicion0 = false;
                      }
                      break;

                    case "temporalidad_miembros_migrantes":
                      miembrosMigrantesProvider.valortemporalidad =
                          int.parse(value!);
                      break;

                    case "comunidad_miembros_migrantes":
                      miembrosMigrantesProvider.valorcomunidad =
                          int.parse(value!);
                      break;

                    case "genero_miembros_migrantes":
                      miembrosMigrantesProvider.valorgenero = int.parse(value!);
                      break;

                    case "departamento_miembros_migrantes":
                      miembrosMigrantesProvider.valoridDepartamento =
                          int.parse(value!);

                      //Hacer null el dropdown dependiente (para evitar errores)
                      miembrosMigrantesProvider.valoridMunicipio = null;
                      miembrosMigrantesProvider.valornomComunidad = null;

                      //Generar listado para municipios (por id departamento)
                      List<DropdownMenuItem<String>> munisProvi = [];
                      List<MunicipiosModelo> munisPorDepto =
                          await DatabaseSatM.instance.obtenerMunicipiosPorDepto(
                              miembrosMigrantesProvider.idDepartamento);
                      for (int i = 0; i < munisPorDepto.length; i++) {
                        munisProvi.add(DropdownMenuItem(
                            value: munisPorDepto[i].idMunicipio.toString(),
                            child: Text(munisPorDepto[i].municipio)));
                      }
                      miembrosMigrantesProvider.poblarMunicipios(munisProvi);
                      break;

                    case "municipio_miembros_migrantes":
                      miembrosMigrantesProvider.valoridMunicipio =
                          int.parse(value!);

                      //Hacer null el dropdown dependiente (para evitar errores)
                      miembrosMigrantesProvider.valornomComunidad = null;

                      //Generar listado para municipios (por id departamento)
                      List<DropdownMenuItem<String>> comunisProvi = [];
                      List<ComunidadesModuloModelo> comunisPorMuni =
                          await DatabaseSatM.instance.obtenerComunidadesModulo(
                              miembrosMigrantesProvider.idMunicipio!);
                      for (int i = 0; i < comunisPorMuni.length; i++) {
                        comunisProvi.add(DropdownMenuItem(
                            value: comunisPorMuni[i].idComunidad.toString(),
                            child: Text(comunisPorMuni[i].nombreComunidad)));
                      }
                      miembrosMigrantesProvider.poblarComunidades(comunisProvi);

                      break;

                    case "nomComunidad_miembros_migrantes":
                      miembrosMigrantesProvider.valornomComunidad =
                          int.parse(value!);
                      break;

                    case "nivel_educativo_miembros_migrantes":
                      miembrosMigrantesProvider.valornivelEducativo =
                          int.parse(value!);
                      break;

                    case "estado_civil_miembros_migrantes":
                      miembrosMigrantesProvider.valorestadoCivil =
                          int.parse(value!);
                      break;

                    case "p09_miembros_migrantes":
                      miembrosMigrantesProvider.valorp09 = int.parse(value!);

                      if (miembrosMigrantesProvider.p09 == 1) {
                        condicionesMigrantesProvider.valorCondicionP09 = true;
                      } else {
                        condicionesMigrantesProvider.valorCondicionP09 = false;
                      }
                      break;

                    case "p10_miembros_migrantes":
                      miembrosMigrantesProvider.valorp10 = int.parse(value!);

                      if (miembrosMigrantesProvider.p10 == 4) {
                        condicionesMigrantesProvider.valorCondicionP10 = true;
                      } else {
                        condicionesMigrantesProvider.valorCondicionP10 = false;
                      }
                      break;

                    case "p11_miembros_migrantes":
                      miembrosMigrantesProvider.valorp11 = int.parse(value!);

                      if (miembrosMigrantesProvider.p11 == 3) {
                        condicionesMigrantesProvider.valorCondicionP11 = true;
                      } else {
                        condicionesMigrantesProvider.valorCondicionP11 = false;
                      }
                      break;

                    case "p12_miembros_migrantes":
                      miembrosMigrantesProvider.valorp12 = int.parse(value!);

                      if (miembrosMigrantesProvider.p12 == 1) {
                        condicionesMigrantesProvider.valorCondicionP12 = true;
                      } else {
                        condicionesMigrantesProvider.valorCondicionP12 = false;
                      }
                      break;

                    case "p13_miembros_migrantes":
                      miembrosMigrantesProvider.valorp13 = int.parse(value!);

                      if (miembrosMigrantesProvider.p13 == 1) {
                        condicionesMigrantesProvider.valorCondicionP13 = true;
                      } else {
                        condicionesMigrantesProvider.valorCondicionP13 = false;
                      }
                      break;

                    case "p14_miembros_migrantes":
                      miembrosMigrantesProvider.valorp14 = int.parse(value!);

                      if (miembrosMigrantesProvider.p14 == 1) {
                        condicionesMigrantesProvider.valorCondicionP14 = true;
                      } else {
                        condicionesMigrantesProvider.valorCondicionP14 = false;
                      }
                      break;

                    case "p15_miembros_migrantes":
                      miembrosMigrantesProvider.valorp15 = int.parse(value!);

                      if (miembrosMigrantesProvider.p15 == 1) {
                        condicionesMigrantesProvider.valorCondicionP15 = true;
                      } else {
                        condicionesMigrantesProvider.valorCondicionP15 = false;
                      }
                      break;

                    case "p16_miembros_migrantes":
                      miembrosMigrantesProvider.valorp16 = int.parse(value!);

                      if (miembrosMigrantesProvider.p16 == 1) {
                        condicionesMigrantesProvider.valorCondicionP16 = true;
                      } else {
                        condicionesMigrantesProvider.valorCondicionP16 = false;
                      }
                      break;
                  }

                  //Actualizar valor en pantalla
                  widget.valorInicial = value.toString();
                }
              : null,
          items: widget.listado,
          validator: (value) {
            if (value == null || value == "") {
              return 'Este campo es obligatorio';
            }
            return null;
          },
        ),
      ),
    );
  }
}
