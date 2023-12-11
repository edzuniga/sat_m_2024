import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sat_m/bd/bd.dart';
import 'package:sat_m/constantes/colores_constantes.dart';
import 'package:sat_m/modales/borrar_modal.dart';
import 'package:sat_m/modelos/comunidades_modelo.dart';
import 'package:sat_m/modelos/departamentos_modelo.dart';
import 'package:sat_m/modelos/miembros_migrantes_modelo.dart';
import 'package:sat_m/modelos/municipios_modelo.dart';
import 'package:sat_m/modelos/satm_familias_modelo.dart';
import 'package:sat_m/modelos/usuarios_modelo.dart';
import 'package:sat_m/pantallas/actualizar_familias_pantalla.dart';
import 'package:sat_m/pantallas/formulario_familias_pantalla.dart';
import 'package:sat_m/pantallas/listado_miembros_migrantes_pantalla.dart';
import 'package:sat_m/providers/condiciones_familias_provider.dart';
import 'package:sat_m/providers/satm_familias_provider.dart';

class ListadoFormFamilias extends StatefulWidget {
  const ListadoFormFamilias({Key? key}) : super(key: key);

  @override
  State<ListadoFormFamilias> createState() => _ListadoFormFamiliasState();
}

class _ListadoFormFamiliasState extends State<ListadoFormFamilias> {
  @override
  Widget build(BuildContext context) {
    //Provider necesarios
    var familiasProvider =
        Provider.of<SatmFamiliasProvider>(context, listen: false);
    var condicionesFamiliasProvider =
        Provider.of<CondicionesFamiliasProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kNaranjaPrincipal,
        centerTitle: false,
        leading: InkWell(
          onTap: () => Navigator.pop(context, true),
          child: Padding(
            padding: const EdgeInsets.only(left: 15, top: 15, bottom: 15),
            child: SvgPicture.asset(
              'assets/svg/backspace.svg',
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: Text(
          'Listado SAT-M Familias',
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.lato(
              fontWeight: FontWeight.w500, fontSize: 21, color: Colors.white),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFAFAFB),
              Color(0xFFFFF1E6),
            ],
          ),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 80),
          child: FutureBuilder(
            future: Future.wait([
              DatabaseSatM.instance.obtenerSatmFamilias(),
              DatabaseSatM.instance.obtenerMiembrosMigrantes(),
              DatabaseSatM.instance.obtenerTodasLasComunidadesModulo(),
            ]),
            builder: (context, AsyncSnapshot<List<dynamic>> datos) {
              if (datos.hasError) {
                return const Center(
                  child: Text('Ocurrió un error!!'),
                );
              }

              if (datos.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(),
                      const SizedBox(height: 10),
                      Text("Cargando datos",
                          style: GoogleFonts.lato(
                              fontSize: 16, color: Colors.black)),
                    ],
                  ),
                );
              }

              if (datos.data!.isEmpty || datos.data![0] == []) {
                return Center(
                  child: Text(
                    'No hay encuestas guardadas!!!',
                    style: GoogleFonts.lato(fontSize: 16, color: Colors.black),
                  ),
                );
              } else {
                List<FamiliasModelo> listado = datos.data![0];
                List<MiembrosMigrantesModelo> listadoMiembrosMigrantes =
                    datos.data![1];
                List<ComunidadesModuloModelo> listadoComunidadesModulo =
                    datos.data![2];

                return RefreshIndicator(
                  onRefresh: () async {
                    return Future<void>.delayed(const Duration(seconds: 2))
                        .whenComplete(() {
                      setState(() {});
                    });
                  },
                  child: ListView.builder(
                    itemCount: listado.length,
                    itemBuilder: (context, int i) {
                      //Obtener las cantidad de migrantes por boleta de familias
                      List<MiembrosMigrantesModelo> miembrosEncontrados = [];

                      for (int m = 0;
                          m < listadoMiembrosMigrantes.length;
                          m++) {
                        if (listadoMiembrosMigrantes[m].codaleaSatfamilias ==
                            listado[i].codaleaSatfamilias) {
                          miembrosEncontrados.add(listadoMiembrosMigrantes[m]);
                        }
                      }

                      //Obtener nombre de la comunidad
                      String nombreComunidad = "";
                      nombreComunidad = listadoComunidadesModulo
                          .firstWhere((element) =>
                              element.idComunidad == listado[i].comunidad)
                          .nombreComunidad;

                      return Column(
                        children: [
                          Slidable(
                            // The end action pane is the one at the right or the bottom side.
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    showDialog<String>(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (context) => AlertDialog(
                                          backgroundColor: Colors.white,
                                          content: const BorrarModal(),
                                          actions: <Widget>[
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      side: const BorderSide(
                                                          color:
                                                              kNaranjaPrincipal))),
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: const Text(
                                                'Cancelar',
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                  backgroundColor:
                                                      kNaranjaPrincipal,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  )),
                                              onPressed: () async {
                                                //Borrar miembros migrantes
                                                await DatabaseSatM.instance
                                                    .borrarFamiliasMiembrosPorCodaleaFamilia(
                                                        listado[i]
                                                            .codaleaSatfamilias);
                                                //Borrar la boleta de familias
                                                await DatabaseSatM.instance
                                                    .borrarFamiliasPorCodalea(
                                                        listado[i]
                                                            .codaleaSatfamilias)
                                                    .whenComplete(() {
                                                  Navigator.pop(context);
                                                  setState(() {});
                                                });
                                              },
                                              child: const Text(
                                                'Borrar',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                          actionsAlignment:
                                              MainAxisAlignment.center),
                                    );
                                  },
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete_forever_rounded,
                                  label: 'Borrar',
                                ),
                                SlidableAction(
                                  onPressed: (context) async {
                                    //Resetear las condiciones
                                    condicionesFamiliasProvider
                                        .resetearCondicionesFamilias();

                                    //Obtener los datos de la BD por codalea
                                    await DatabaseSatM.instance
                                        .obtenerSatmFamiliasPorCodalea(
                                            listado[i].codaleaSatfamilias)
                                        .then((value) async {
                                      familiasProvider.valorIdPais =
                                          value.idPais;
                                      familiasProvider.valoridDepartamento =
                                          value.idDepartamento;
                                      familiasProvider.valoridMunicipio =
                                          value.idMunicipio;
                                      familiasProvider.valorcomunidad =
                                          value.comunidad;
                                      familiasProvider.valorpatrocinio =
                                          value.patrocinio;
                                      familiasProvider.valornomEncuestado =
                                          value.nomEncuestado;
                                      familiasProvider.valoridentidad =
                                          value.identidad.toString();
                                      familiasProvider.valoredad =
                                          value.edad.toString();
                                      familiasProvider.valornacimiento =
                                          value.nacimiento;
                                      familiasProvider.valorsexo = value.sexo;
                                      familiasProvider.valorestudia =
                                          value.estudia;
                                      familiasProvider.valoreducacion =
                                          value.educacion;
                                      familiasProvider.valorestado =
                                          value.estado;
                                      familiasProvider.valortelefonoEncuestado =
                                          value.telefonoEncuestado;
                                      familiasProvider.valorfamilias =
                                          value.familias.toString();
                                      familiasProvider.valormiembros =
                                          value.miembros.toString();
                                      familiasProvider.valornina =
                                          value.nina.toString();
                                      familiasProvider.valornino =
                                          value.nino.toString();
                                      familiasProvider.valorambosPadres =
                                          value.ambosPadres;
                                      familiasProvider.valornnPatrocinado =
                                          value.nnPatrocinado;
                                      familiasProvider.valoridPatrocinio =
                                          value.idPatrocinio;
                                      familiasProvider.valorp01 = value.p01;
                                      familiasProvider.valorp02 = value.p02;
                                      familiasProvider.valorp03 = value.p03;
                                      familiasProvider.valorp04 = value.p04;
                                      familiasProvider.valorp05 = value.p05;
                                      familiasProvider.valorp06 = value.p06;
                                      familiasProvider.valorp07 = value.p07;
                                      familiasProvider.valorp08 = value.p08;
                                      familiasProvider.valorp09 = value.p09;
                                      familiasProvider.valorp10 = value.p10;
                                      familiasProvider.valorp11 = value.p11;
                                      familiasProvider.valorp12 = value.p12;
                                      familiasProvider.valorp13 = value.p13;
                                      familiasProvider.valorp14 = value.p14;
                                      familiasProvider.valorp15 =
                                          value.p15.toString();
                                      familiasProvider.valorp16 = value.p16;
                                      familiasProvider.valorp17 = value.p17;
                                      familiasProvider.valorp18 =
                                          value.p18.toString();
                                      familiasProvider.valorp18B =
                                          value.p18B.toString();
                                      familiasProvider.valorp19 = value.p19;
                                      familiasProvider.valorp20 = value.p20;
                                      familiasProvider.valorp21 = value.p21;
                                      familiasProvider.valorp22 = value.p22;
                                      familiasProvider.valorp23 = value.p23;
                                      familiasProvider.valorp24 = value.p24;
                                      familiasProvider.valorp27 = value.p27;
                                      familiasProvider.valorp28 = value.p28;
                                      familiasProvider.valorp29 = value.p29;
                                      familiasProvider.valorp30 = value.p30;
                                      familiasProvider.valorp31 = value.p31;
                                      familiasProvider.valorp32 = value.p32;
                                      familiasProvider.valorotro1 = value.otro1;
                                      familiasProvider.valorp33 = value.p33;
                                      familiasProvider.valorp34 = value.p34;
                                      familiasProvider.valorp35 = value.p35;
                                      familiasProvider.valorp36 = value.p36;
                                      familiasProvider.valorp37 = value.p37;
                                      familiasProvider.valorp38 = value.p38;
                                      familiasProvider.valorp39 = value.p39;
                                      familiasProvider.valorp40 = value.p40;
                                      familiasProvider.valorp41 = value.p41;
                                      familiasProvider.valorp42 = value.p42;
                                      familiasProvider.valorp43 = value.p43;
                                      familiasProvider.valorp44 = value.p44;
                                      familiasProvider.valorp45 = value.p45;
                                      familiasProvider.valorvivienda =
                                          value.vivienda;
                                      familiasProvider.valorp46 = value.p46;
                                      familiasProvider.valorp47 = value.p47;
                                      familiasProvider.valorp48 = value.p48;
                                      familiasProvider.valorp49 = value.p49;
                                      familiasProvider.valorp50 = value.p50;
                                      familiasProvider.valorppi1 = value.ppi1;
                                      familiasProvider.valorppi2 = value.ppi2;
                                      familiasProvider.valorppi3 = value.ppi3;
                                      familiasProvider.valorppi4 = value.ppi4;
                                      familiasProvider.valorppi5 = value.ppi5;
                                      familiasProvider.valorppi6 = value.ppi6;
                                      familiasProvider.valorppi7 = value.ppi7;
                                      familiasProvider.valorppi8 = value.ppi8;
                                      familiasProvider.valorppi9 = value.ppi9;
                                      familiasProvider.valorppi10 = value.ppi10;
                                      familiasProvider.valorfacilitador =
                                          value.facilitador;
                                      familiasProvider.valortelFacilitador =
                                          value.telFacilitador.toString();
                                      familiasProvider.valorfecha = value.fecha;
                                      familiasProvider.valorobservaciones =
                                          value.observaciones;
                                      familiasProvider.valorlat = value.lat;
                                      familiasProvider.valorlon = value.lon;
                                      familiasProvider.valoralt = value.alt;
                                      familiasProvider.valoracc = value.acc;

                                      //-------------------- MULTISELECTS (MOSTRAR VALORES SELECCIONADOS)
                                      //P04
                                      //limpiar donde se guardarán las opciones seleccionadas
                                      familiasProvider.opcionesActP04.clear();
                                      //Crear el array de respuestas
                                      List<String> respuestasArrayP04 =
                                          familiasProvider.p04.split(',');
                                      if (familiasProvider.p04 != "") {
                                        for (String element
                                            in respuestasArrayP04) {
                                          //Seleccionar con el i la opción del listado general
                                          MultiSelectClass elemento =
                                              familiasProvider.opcionesP04
                                                  .elementAt(
                                                      int.parse(element) - 1);
                                          //Agregar ese elemento al listado de seleccionados
                                          familiasProvider.opcionesActP04
                                              .add(elemento);
                                        }
                                      }

                                      //P05
                                      //limpiar donde se guardarán las opciones seleccionadas
                                      familiasProvider.opcionesActP05.clear();
                                      //Crear el array de respuestas
                                      List<String> respuestasArrayP05 =
                                          familiasProvider.p05.split(',');
                                      if (familiasProvider.p05 != "") {
                                        for (String element
                                            in respuestasArrayP05) {
                                          //Seleccionar con el i la opción del listado general
                                          MultiSelectClass elemento =
                                              familiasProvider.opcionesP05
                                                  .elementAt(
                                                      int.parse(element) - 1);
                                          //Agregar ese elemento al listado de seleccionados
                                          familiasProvider.opcionesActP05
                                              .add(elemento);
                                        }
                                      }

                                      //P08
                                      //limpiar donde se guardarán las opciones seleccionadas
                                      familiasProvider.opcionesActP08.clear();
                                      //Crear el array de respuestas
                                      List<String> respuestasArrayP08 =
                                          familiasProvider.p08.split(',');
                                      if (familiasProvider.p08 != "") {
                                        for (String element
                                            in respuestasArrayP08) {
                                          //Seleccionar con el i la opción del listado general
                                          MultiSelectClass elemento =
                                              familiasProvider.opcionesP08
                                                  .elementAt(
                                                      int.parse(element) - 1);
                                          //Agregar ese elemento al listado de seleccionados
                                          familiasProvider.opcionesActP08
                                              .add(elemento);
                                        }
                                      }

                                      //P10
                                      //limpiar donde se guardarán las opciones seleccionadas
                                      familiasProvider.opcionesActP10.clear();
                                      //Crear el array de respuestas
                                      List<String> respuestasArrayP10 =
                                          familiasProvider.p10.split(',');
                                      if (familiasProvider.p10 != "") {
                                        for (String element
                                            in respuestasArrayP10) {
                                          //Seleccionar con el i la opción del listado general
                                          MultiSelectClass elemento =
                                              familiasProvider.opcionesP10
                                                  .elementAt(
                                                      int.parse(element) - 1);
                                          //Agregar ese elemento al listado de seleccionados
                                          familiasProvider.opcionesActP10
                                              .add(elemento);
                                        }
                                      }

                                      //P12
                                      //limpiar donde se guardarán las opciones seleccionadas
                                      familiasProvider.opcionesActP12.clear();
                                      //Crear el array de respuestas
                                      List<String> respuestasArrayP12 =
                                          familiasProvider.p12.split(',');
                                      if (familiasProvider.p12 != "") {
                                        for (String element
                                            in respuestasArrayP12) {
                                          //Seleccionar con el i la opción del listado general
                                          MultiSelectClass elemento =
                                              familiasProvider.opcionesP12
                                                  .elementAt(
                                                      int.parse(element) - 1);
                                          //Agregar ese elemento al listado de seleccionados
                                          familiasProvider.opcionesActP12
                                              .add(elemento);
                                        }
                                      }

                                      //P31
                                      //limpiar donde se guardarán las opciones seleccionadas
                                      familiasProvider.opcionesActP31.clear();
                                      //Crear el array de respuestas
                                      List<String> respuestasArrayP31 =
                                          familiasProvider.p31.split(',');
                                      if (familiasProvider.p31 != "") {
                                        for (String element
                                            in respuestasArrayP31) {
                                          //Seleccionar con el i la opción del listado general
                                          MultiSelectClass elemento =
                                              familiasProvider.opcionesP31
                                                  .elementAt(
                                                      int.parse(element) - 1);
                                          //Agregar ese elemento al listado de seleccionados
                                          familiasProvider.opcionesActP31
                                              .add(elemento);
                                        }
                                      }

                                      //P35
                                      //limpiar donde se guardarán las opciones seleccionadas
                                      familiasProvider.opcionesActP35.clear();
                                      //Crear el array de respuestas
                                      List<String> respuestasArrayP35 =
                                          familiasProvider.p35.split(',');
                                      if (familiasProvider.p35 != "") {
                                        for (String element
                                            in respuestasArrayP35) {
                                          //Seleccionar con el i la opción del listado general
                                          MultiSelectClass elemento =
                                              familiasProvider.opcionesP35
                                                  .elementAt(
                                                      int.parse(element) - 1);
                                          //Agregar ese elemento al listado de seleccionados
                                          familiasProvider.opcionesActP35
                                              .add(elemento);
                                        }
                                      }
                                      //-------------------- MULTISELECTS (MOSTRAR VALORES SELECCIONADOS)

                                      //Manejo de las condiciones
                                      if (familiasProvider.nina.text != "00" &&
                                          familiasProvider.nina.text != "" &&
                                          int.parse(
                                                  familiasProvider.nina.text) >
                                              0) {
                                        condicionesFamiliasProvider
                                            .valorCondicionNinaNino = true;
                                      } else if (familiasProvider.nino.text !=
                                              "00" &&
                                          familiasProvider.nino.text != "" &&
                                          int.parse(
                                                  familiasProvider.nino.text) >
                                              0) {
                                        condicionesFamiliasProvider
                                            .valorCondicionNinaNino = true;
                                      }

                                      if (familiasProvider.nnPatrocinado == 1) {
                                        condicionesFamiliasProvider
                                                .valorCondicionNnPatrocinados =
                                            true;
                                      }

                                      if (familiasProvider.p14 == 1) {
                                        condicionesFamiliasProvider
                                            .valorCondicionP14 = true;
                                      }

                                      if (familiasProvider.p17 == 1) {
                                        condicionesFamiliasProvider
                                            .valorCondicionP17 = true;
                                      }

                                      if (familiasProvider.p24 == 1) {
                                        condicionesFamiliasProvider
                                            .valorCondicionP24 = true;
                                      }

                                      if (familiasProvider.p29 == 1) {
                                        condicionesFamiliasProvider
                                            .valorCondicionP29 = true;
                                      }

                                      if (familiasProvider.p32 == 4) {
                                        condicionesFamiliasProvider
                                            .valorCondicionP32 = true;
                                      }

                                      if (familiasProvider.p37 == 1) {
                                        condicionesFamiliasProvider
                                            .valorCondicionP37 = true;
                                      }

                                      if (familiasProvider.p08.contains("3")) {
                                        condicionesFamiliasProvider
                                            .valorCondicion8 = true;
                                      }

                                      if (familiasProvider.p10.contains("3")) {
                                        condicionesFamiliasProvider
                                            .valorCondicion10 = true;
                                      }

                                      if (familiasProvider.p14 == 1 ||
                                          familiasProvider.p24 == 1) {
                                        condicionesFamiliasProvider
                                            .valorCondicionP14y24 = true;
                                      } else {
                                        condicionesFamiliasProvider
                                            .valorCondicionP14y24 = false;
                                      }

                                      if (familiasProvider.p40 == 1 ||
                                          familiasProvider.p40 == 2) {
                                        condicionesFamiliasProvider
                                            .valorCondicionP40 = true;
                                      } else {
                                        condicionesFamiliasProvider
                                            .valorCondicionP40 = false;
                                      }

                                      //Obtener el id del usuario y el idPaís del usuario
                                      List<UsuariosModelo> datosUsuario =
                                          await DatabaseSatM.instance
                                              .obtenerUsuarios();

                                      int idPais = datosUsuario[0].idPais;

                                      //-------POBLAR dropdown de Países con el único país del usuario
                                      /*List<PaisesModelo> paises =
                                        await DatabaseSatM.instance
                                            .obtenerPaisesPorId(idPais);

                                    List<DropdownMenuItem<String>>
                                        listadoProvisionalPaises = [];
                                    listadoProvisionalPaises
                                        .add(DropdownMenuItem(
                                      value: paises[0].idPais.toString(),
                                      child: Text(paises[0].pais),
                                    ));

                                    familiasProvider
                                        .poblarPaises(listadoProvisionalPaises);*/

                                      //-------POBLAR dropdown de Departamentos
                                      List<DepartamentosModelo> departamentos =
                                          await DatabaseSatM.instance
                                              .obtenerDepartamentosPorPais(
                                                  idPais);

                                      List<DropdownMenuItem<String>>
                                          listadoProvisional = [];
                                      for (int i = 0;
                                          i < departamentos.length;
                                          i++) {
                                        listadoProvisional.add(DropdownMenuItem(
                                          value: departamentos[i]
                                              .idDepartamento
                                              .toString(),
                                          child: Text(
                                              departamentos[i].departamento),
                                        ));
                                      }

                                      familiasProvider.poblarDepartamentos(
                                          listadoProvisional);

                                      //Generar listado para municipios (por id departamento)
                                      List<DropdownMenuItem<String>>
                                          munisProvi = [];
                                      List<MunicipiosModelo> munisPorDepto =
                                          await DatabaseSatM.instance
                                              .obtenerMunicipiosPorDepto(
                                                  familiasProvider
                                                      .idDepartamento);
                                      for (int i = 0;
                                          i < munisPorDepto.length;
                                          i++) {
                                        munisProvi.add(DropdownMenuItem(
                                            value: munisPorDepto[i]
                                                .idMunicipio
                                                .toString(),
                                            child: Text(
                                                munisPorDepto[i].municipio)));
                                      }
                                      familiasProvider
                                          .poblarMunicipios(munisProvi);

                                      //Generar listado para comunidades (por id municipio)
                                      List<DropdownMenuItem<String>>
                                          comunisProvi = [];
                                      List<ComunidadesModuloModelo>
                                          comunisPorMuni = await DatabaseSatM
                                              .instance
                                              .obtenerComunidadesModulo(
                                                  familiasProvider
                                                      .idMunicipio!);
                                      for (int i = 0;
                                          i < comunisPorMuni.length;
                                          i++) {
                                        comunisProvi.add(DropdownMenuItem(
                                            value: comunisPorMuni[i]
                                                .idComunidad
                                                .toString(),
                                            child: Text(comunisPorMuni[i]
                                                .nombreComunidad)));
                                      }
                                      familiasProvider
                                          .poblarComunidades(comunisProvi);

                                      //-------POBLAR dropdown de Persona Encuestador
                                      List<DropdownMenuItem<String>>
                                          listadoProvisionalUsuarios = [];
                                      for (int i = 0;
                                          i < datosUsuario.length;
                                          i++) {
                                        listadoProvisionalUsuarios
                                            .add(DropdownMenuItem(
                                          value: datosUsuario[i].codaleaUsuario,
                                          child: Text(
                                              "${datosUsuario[i].nombres} ${datosUsuario[i].apellidos}"),
                                        ));
                                      }

                                      familiasProvider.poblarFacilitador(
                                          listadoProvisionalUsuarios);

//-------POBLAR dropdown de INGRESOS DEL HOGAR (#44) y P47
                                      List<DropdownMenuItem<String>>
                                          listadoProvisionalRangos = [];
                                      List<DropdownMenuItem<String>>
                                          listadoProvisionalP47 = [];

                                      switch (idPais) {
                                        //HONDURAS
                                        case 1:
                                          listadoProvisionalRangos
                                              .add(const DropdownMenuItem(
                                            value: "1",
                                            child:
                                                Text("1. Menos de 2,000 HNL"),
                                          ));
                                          listadoProvisionalRangos
                                              .add(const DropdownMenuItem(
                                            value: "2",
                                            child: Text("2. 2,001 - 4,000 HNL"),
                                          ));
                                          listadoProvisionalRangos
                                              .add(const DropdownMenuItem(
                                            value: "3",
                                            child: Text("3. 4,001 - 6,000 HNL"),
                                          ));
                                          listadoProvisionalRangos
                                              .add(const DropdownMenuItem(
                                            value: "4",
                                            child: Text("4. 6,001 - 8,000 HNL"),
                                          ));
                                          listadoProvisionalRangos
                                              .add(const DropdownMenuItem(
                                            value: "5",
                                            child:
                                                Text("5. 8,001 - 12,000 HNL"),
                                          ));
                                          listadoProvisionalRangos
                                              .add(const DropdownMenuItem(
                                            value: "6",
                                            child:
                                                Text("6. 12,001 - 20,000 HNL"),
                                          ));
                                          listadoProvisionalRangos
                                              .add(const DropdownMenuItem(
                                            value: "7",
                                            child: Text("7. Más de 20,000 HNL"),
                                          ));

                                          //P47 - Honduras
                                          listadoProvisionalP47.add(
                                              const DropdownMenuItem(
                                                  value: "1",
                                                  child: Text(
                                                      '1. Servicio público por tubería')));
                                          listadoProvisionalP47.add(
                                              const DropdownMenuItem(
                                                  value: "2",
                                                  child: Text(
                                                      '2. Servicio privado por tubería')));
                                          listadoProvisionalP47.add(
                                              const DropdownMenuItem(
                                                  value: "3",
                                                  child: Text(
                                                      '3. Pozo malacate')));
                                          listadoProvisionalP47.add(
                                              const DropdownMenuItem(
                                                  value: "4",
                                                  child: Text(
                                                      '4. Pozo con bomba')));
                                          listadoProvisionalP47.add(
                                              const DropdownMenuItem(
                                                  value: "5",
                                                  child: Text(
                                                      '5. Río, riachuelo, ojo de agua, etc.')));
                                          listadoProvisionalP47.add(
                                              const DropdownMenuItem(
                                                  value: "6",
                                                  child: Text(
                                                      '6. Carro cisterna')));
                                          listadoProvisionalP47.add(
                                              const DropdownMenuItem(
                                                  value: "7",
                                                  child: Text(
                                                      '7. Pick-up con drones o barriles')));
                                          listadoProvisionalP47.add(
                                              const DropdownMenuItem(
                                                  value: "8",
                                                  child: Text(
                                                      '8. Llave pública o comunitaria')));
                                          listadoProvisionalP47.add(
                                              const DropdownMenuItem(
                                                  value: "9",
                                                  child: Text(
                                                      '9. Del vecino / otra vivienda')));
                                          listadoProvisionalP47.add(
                                              const DropdownMenuItem(
                                                  value: "10",
                                                  child: Text('10. Otro')));
                                          break;

                                        //GUATEMALA
                                        case 2:
                                          listadoProvisionalRangos
                                              .add(const DropdownMenuItem(
                                            value: "1",
                                            child:
                                                Text("1. Menos de 5,000 GTQ"),
                                          ));
                                          listadoProvisionalRangos
                                              .add(const DropdownMenuItem(
                                            value: "2",
                                            child:
                                                Text("2. 5,001 - 10,000 GTQ"),
                                          ));
                                          listadoProvisionalRangos
                                              .add(const DropdownMenuItem(
                                            value: "3",
                                            child:
                                                Text("3. 10,001 - 15,000 GTQ"),
                                          ));
                                          listadoProvisionalRangos
                                              .add(const DropdownMenuItem(
                                            value: "4",
                                            child:
                                                Text("4. 15,001 - 20,000 GTQ"),
                                          ));
                                          listadoProvisionalRangos
                                              .add(const DropdownMenuItem(
                                            value: "5",
                                            child:
                                                Text("5. 20,001 - 30,000 GTQ"),
                                          ));
                                          listadoProvisionalRangos
                                              .add(const DropdownMenuItem(
                                            value: "6",
                                            child:
                                                Text("6. 30,001 - 50,000 GTQ"),
                                          ));
                                          listadoProvisionalRangos
                                              .add(const DropdownMenuItem(
                                            value: "7",
                                            child: Text("7. Más de 50,000 GTQ"),
                                          ));

                                          //P47 - GUATEMALA
                                          listadoProvisionalP47.add(
                                              const DropdownMenuItem(
                                                  value: "1",
                                                  child: Text(
                                                      '1. Servicio público por tubería')));
                                          listadoProvisionalP47.add(
                                              const DropdownMenuItem(
                                                  value: "2",
                                                  child: Text(
                                                      '2. Servicio privado por tubería')));
                                          listadoProvisionalP47.add(
                                              const DropdownMenuItem(
                                                  value: "3",
                                                  child: Text(
                                                      '3. Pozo malacate')));
                                          listadoProvisionalP47.add(
                                              const DropdownMenuItem(
                                                  value: "4",
                                                  child: Text(
                                                      '4. Pozo con bomba')));
                                          listadoProvisionalP47.add(
                                              const DropdownMenuItem(
                                                  value: "5",
                                                  child: Text(
                                                      '5. Río, riachuelo, ojo de agua, etc.')));
                                          listadoProvisionalP47.add(
                                              const DropdownMenuItem(
                                                  value: "6",
                                                  child: Text(
                                                      '6. Carro cisterna')));
                                          listadoProvisionalP47.add(
                                              const DropdownMenuItem(
                                                  value: "7",
                                                  child: Text(
                                                      '7. Pick-up con drones o barriles')));
                                          listadoProvisionalP47.add(
                                              const DropdownMenuItem(
                                                  value: "8",
                                                  child: Text(
                                                      '8. Llave pública o comunitaria')));
                                          listadoProvisionalP47.add(
                                              const DropdownMenuItem(
                                                  value: "9",
                                                  child: Text(
                                                      '9. Del vecino / otra vivienda')));
                                          listadoProvisionalP47.add(
                                              const DropdownMenuItem(
                                                  value: "10",
                                                  child: Text('10. Otro')));
                                          break;

                                        //EL SALVADOR
                                        case 3:
                                          listadoProvisionalRangos
                                              .add(const DropdownMenuItem(
                                            value: "1",
                                            child:
                                                Text("1. Menos de \$200 USD"),
                                          ));
                                          listadoProvisionalRangos
                                              .add(const DropdownMenuItem(
                                            value: "2",
                                            child: Text("2. \$201 - \$400 USD"),
                                          ));
                                          listadoProvisionalRangos
                                              .add(const DropdownMenuItem(
                                            value: "3",
                                            child: Text("3. \$401 - \$600 USD"),
                                          ));
                                          listadoProvisionalRangos
                                              .add(const DropdownMenuItem(
                                            value: "4",
                                            child: Text("4. \$601 - \$800 USD"),
                                          ));
                                          listadoProvisionalRangos
                                              .add(const DropdownMenuItem(
                                            value: "5",
                                            child:
                                                Text("5. \$801 - \$1,200 USD"),
                                          ));
                                          listadoProvisionalRangos
                                              .add(const DropdownMenuItem(
                                            value: "6",
                                            child: Text(
                                                "6. \$1,201 - \$2,000 USD"),
                                          ));
                                          listadoProvisionalRangos
                                              .add(const DropdownMenuItem(
                                            value: "7",
                                            child:
                                                Text("7. Más de \$2,000 USD"),
                                          ));

                                          //P47 - EL SALVADOR
                                          listadoProvisionalP47.add(
                                              const DropdownMenuItem(
                                                  value: "1",
                                                  child: Text(
                                                      '1. Servicio público por tubería')));
                                          listadoProvisionalP47.add(
                                              const DropdownMenuItem(
                                                  value: "2",
                                                  child: Text(
                                                      '2. Servicio privado por tubería')));
                                          listadoProvisionalP47.add(
                                              const DropdownMenuItem(
                                                  value: "3",
                                                  child: Text(
                                                      '3. Pozo con cubeta/ cumbo')));
                                          listadoProvisionalP47.add(
                                              const DropdownMenuItem(
                                                  value: "4",
                                                  child: Text(
                                                      '4. Pozo con bomba')));
                                          listadoProvisionalP47.add(
                                              const DropdownMenuItem(
                                                  value: "5",
                                                  child: Text(
                                                      '5. Río, riachuelo, ojo de agua, etc.')));
                                          listadoProvisionalP47.add(
                                              const DropdownMenuItem(
                                                  value: "6",
                                                  child: Text(
                                                      '6. Carro cisterna')));
                                          listadoProvisionalP47.add(
                                              const DropdownMenuItem(
                                                  value: "7",
                                                  child: Text(
                                                      '7. Pick-up con drones o barriles')));
                                          listadoProvisionalP47.add(
                                              const DropdownMenuItem(
                                                  value: "8",
                                                  child: Text(
                                                      '8. Llave pública o comunitaria')));
                                          listadoProvisionalP47.add(
                                              const DropdownMenuItem(
                                                  value: "9",
                                                  child: Text(
                                                      '9. Del vecino / otra vivienda')));
                                          listadoProvisionalP47.add(
                                              const DropdownMenuItem(
                                                  value: "10",
                                                  child: Text('10. Otro')));
                                          break;
                                      }

                                      familiasProvider
                                          .poblarP44(listadoProvisionalRangos);
                                      familiasProvider
                                          .poblarP47(listadoProvisionalP47);

                                      if (!mounted) return;

                                      bool resp = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  ActualizarFamiliaFormulario(
                                                    codaleaRecibido: listado[i]
                                                        .codaleaSatfamilias,
                                                    idPais: idPais,
                                                  )));

                                      if (resp == true) {
                                        setState(() {});
                                      }
                                    });
                                  },
                                  backgroundColor: kAzuL,
                                  foregroundColor: Colors.white,
                                  icon: Icons.edit_note,
                                  label: 'Editar',
                                ),
                              ],
                            ),
                            child: Card(
                              color: Colors.white,
                              elevation: 0.5,
                              child: Container(
                                padding: const EdgeInsetsDirectional.symmetric(
                                    horizontal: 15),
                                height: 160,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Icon(
                                      Icons.check_box,
                                      color: kNaranjaPrincipal,
                                    ),
                                    const SizedBox(width: 15),
                                    Expanded(
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Encuestado: ${listado[i].nomEncuestado}',
                                              style: GoogleFonts.lato(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              'Comunidad: $nombreComunidad\nFecha: ${listado[i].fecha}',
                                              style: GoogleFonts.lato(
                                                fontSize: 11,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Center(
                                              child: InkWell(
                                                onTap: () async {
                                                  bool? refrescar =
                                                      await Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (_) =>
                                                                  ListadoMiembrosMigrantes(
                                                                    codaleaBoleta:
                                                                        listado[0]
                                                                            .codaleaSatfamilias,
                                                                  )));
                                                  if (refrescar == null) {
                                                    setState(() {});
                                                  }
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 8),
                                                  width: 250,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      border: Border.all(
                                                          width: 0.5,
                                                          color:
                                                              kNaranjaPrincipal)),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      CircleAvatar(
                                                        backgroundColor:
                                                            kNaranjaPrincipal,
                                                        child: Text(
                                                          '${miembrosEncontrados.length}',
                                                          style:
                                                              GoogleFonts.lato(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 14),
                                                        ),
                                                      ),
                                                      Text(
                                                        'Miembros migrantes',
                                                        style: GoogleFonts.lato(
                                                            color:
                                                                Colors.black87),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                          ]),
                                    ),
                                    const SizedBox(width: 15),
                                    const Icon(Icons.chevron_left)
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      );
                    },
                  ),
                );
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          //Obtener el id del usuario y el idPaís del usuario
          List<UsuariosModelo> datosUsuario =
              await DatabaseSatM.instance.obtenerUsuarios();

          int idPais = datosUsuario[0].idPais;

//-------POBLAR dropdown de Países con el único país del usuario
          /* List<PaisesModelo> paises =
              await DatabaseSatM.instance.obtenerPaisesPorId(idPais);

          List<DropdownMenuItem<String>> listadoProvisionalPaises = [];
          listadoProvisionalPaises.add(DropdownMenuItem(
            value: paises[0].idPais.toString(),
            child: Text(paises[0].pais),
          ));

          familiasProvider.poblarPaises(listadoProvisionalPaises); */

//-------POBLAR dropdown de Departamentos
          List<DepartamentosModelo> departamentos =
              await DatabaseSatM.instance.obtenerDepartamentosPorPais(idPais);

          List<DropdownMenuItem<String>> listadoProvisional = [];
          for (int i = 0; i < departamentos.length; i++) {
            listadoProvisional.add(DropdownMenuItem(
              value: departamentos[i].idDepartamento.toString(),
              child: Text(departamentos[i].departamento),
            ));
          }

          familiasProvider.poblarDepartamentos(listadoProvisional);

//-------POBLAR dropdown de Persona Encuestador
          List<DropdownMenuItem<String>> listadoProvisionalUsuarios = [];
          for (int i = 0; i < datosUsuario.length; i++) {
            listadoProvisionalUsuarios.add(DropdownMenuItem(
              value: datosUsuario[i].codaleaUsuario,
              child: Text(
                  "${datosUsuario[i].nombres} ${datosUsuario[i].apellidos}"),
            ));
          }

          familiasProvider.poblarFacilitador(listadoProvisionalUsuarios);

//-------POBLAR dropdown de INGRESOS DEL HOGAR (#44) y P47
          List<DropdownMenuItem<String>> listadoProvisionalRangos = [];
          List<DropdownMenuItem<String>> listadoProvisionalP47 = [];

          switch (idPais) {
            //HONDURAS
            case 1:
              listadoProvisionalRangos.add(const DropdownMenuItem(
                value: "1",
                child: Text("1. Menos de 2,000 HNL"),
              ));
              listadoProvisionalRangos.add(const DropdownMenuItem(
                value: "2",
                child: Text("2. 2,001 - 4,000 HNL"),
              ));
              listadoProvisionalRangos.add(const DropdownMenuItem(
                value: "3",
                child: Text("3. 4,001 - 6,000 HNL"),
              ));
              listadoProvisionalRangos.add(const DropdownMenuItem(
                value: "4",
                child: Text("4. 6,001 - 8,000 HNL"),
              ));
              listadoProvisionalRangos.add(const DropdownMenuItem(
                value: "5",
                child: Text("5. 8,001 - 12,000 HNL"),
              ));
              listadoProvisionalRangos.add(const DropdownMenuItem(
                value: "6",
                child: Text("6. 12,001 - 20,000 HNL"),
              ));
              listadoProvisionalRangos.add(const DropdownMenuItem(
                value: "7",
                child: Text("7. Más de 20,000 HNL"),
              ));

              //P47 - Honduras
              listadoProvisionalP47.add(const DropdownMenuItem(
                  value: "1", child: Text('1. Servicio público por tubería')));
              listadoProvisionalP47.add(const DropdownMenuItem(
                  value: "2", child: Text('2. Servicio privado por tubería')));
              listadoProvisionalP47.add(const DropdownMenuItem(
                  value: "3", child: Text('3. Pozo malacate')));
              listadoProvisionalP47.add(const DropdownMenuItem(
                  value: "4", child: Text('4. Pozo con bomba')));
              listadoProvisionalP47.add(const DropdownMenuItem(
                  value: "5",
                  child: Text('5. Río, riachuelo, ojo de agua, etc.')));
              listadoProvisionalP47.add(const DropdownMenuItem(
                  value: "6", child: Text('6. Carro cisterna')));
              listadoProvisionalP47.add(const DropdownMenuItem(
                  value: "7", child: Text('7. Pick-up con drones o barriles')));
              listadoProvisionalP47.add(const DropdownMenuItem(
                  value: "8", child: Text('8. Llave pública o comunitaria')));
              listadoProvisionalP47.add(const DropdownMenuItem(
                  value: "9", child: Text('9. Del vecino / otra vivienda')));
              listadoProvisionalP47.add(
                  const DropdownMenuItem(value: "10", child: Text('10. Otro')));
              break;

            //GUATEMALA
            case 2:
              listadoProvisionalRangos.add(const DropdownMenuItem(
                value: "1",
                child: Text("1. Menos de 5,000 GTQ"),
              ));
              listadoProvisionalRangos.add(const DropdownMenuItem(
                value: "2",
                child: Text("2. 5,001 - 10,000 GTQ"),
              ));
              listadoProvisionalRangos.add(const DropdownMenuItem(
                value: "3",
                child: Text("3. 10,001 - 15,000 GTQ"),
              ));
              listadoProvisionalRangos.add(const DropdownMenuItem(
                value: "4",
                child: Text("4. 15,001 - 20,000 GTQ"),
              ));
              listadoProvisionalRangos.add(const DropdownMenuItem(
                value: "5",
                child: Text("5. 20,001 - 30,000 GTQ"),
              ));
              listadoProvisionalRangos.add(const DropdownMenuItem(
                value: "6",
                child: Text("6. 30,001 - 50,000 GTQ"),
              ));
              listadoProvisionalRangos.add(const DropdownMenuItem(
                value: "7",
                child: Text("7. Más de 50,000 GTQ"),
              ));

              //P47 - GUATEMALA
              listadoProvisionalP47.add(const DropdownMenuItem(
                  value: "1", child: Text('1. Servicio público por tubería')));
              listadoProvisionalP47.add(const DropdownMenuItem(
                  value: "2", child: Text('2. Servicio privado por tubería')));
              listadoProvisionalP47.add(const DropdownMenuItem(
                  value: "3", child: Text('3. Pozo malacate')));
              listadoProvisionalP47.add(const DropdownMenuItem(
                  value: "4", child: Text('4. Pozo con bomba')));
              listadoProvisionalP47.add(const DropdownMenuItem(
                  value: "5",
                  child: Text('5. Río, riachuelo, ojo de agua, etc.')));
              listadoProvisionalP47.add(const DropdownMenuItem(
                  value: "6", child: Text('6. Carro cisterna')));
              listadoProvisionalP47.add(const DropdownMenuItem(
                  value: "7", child: Text('7. Pick-up con drones o barriles')));
              listadoProvisionalP47.add(const DropdownMenuItem(
                  value: "8", child: Text('8. Llave pública o comunitaria')));
              listadoProvisionalP47.add(const DropdownMenuItem(
                  value: "9", child: Text('9. Del vecino / otra vivienda')));
              listadoProvisionalP47.add(
                  const DropdownMenuItem(value: "10", child: Text('10. Otro')));
              break;

            //EL SALVADOR
            case 3:
              listadoProvisionalRangos.add(const DropdownMenuItem(
                value: "1",
                child: Text("1. Menos de \$200 USD"),
              ));
              listadoProvisionalRangos.add(const DropdownMenuItem(
                value: "2",
                child: Text("2. \$201 - \$400 USD"),
              ));
              listadoProvisionalRangos.add(const DropdownMenuItem(
                value: "3",
                child: Text("3. \$401 - \$600 USD"),
              ));
              listadoProvisionalRangos.add(const DropdownMenuItem(
                value: "4",
                child: Text("4. \$601 - \$800 USD"),
              ));
              listadoProvisionalRangos.add(const DropdownMenuItem(
                value: "5",
                child: Text("5. \$801 - \$1,200 USD"),
              ));
              listadoProvisionalRangos.add(const DropdownMenuItem(
                value: "6",
                child: Text("6. \$1,201 - \$2,000 USD"),
              ));
              listadoProvisionalRangos.add(const DropdownMenuItem(
                value: "7",
                child: Text("7. Más de \$2,000 USD"),
              ));

              //P47 - EL SALVADOR
              listadoProvisionalP47.add(const DropdownMenuItem(
                  value: "1", child: Text('1. Servicio público por tubería')));
              listadoProvisionalP47.add(const DropdownMenuItem(
                  value: "2", child: Text('2. Servicio privado por tubería')));
              listadoProvisionalP47.add(const DropdownMenuItem(
                  value: "3", child: Text('3. Pozo con cubeta/ cumbo')));
              listadoProvisionalP47.add(const DropdownMenuItem(
                  value: "4", child: Text('4. Pozo con bomba')));
              listadoProvisionalP47.add(const DropdownMenuItem(
                  value: "5",
                  child: Text('5. Río, riachuelo, ojo de agua, etc.')));
              listadoProvisionalP47.add(const DropdownMenuItem(
                  value: "6", child: Text('6. Carro cisterna')));
              listadoProvisionalP47.add(const DropdownMenuItem(
                  value: "7", child: Text('7. Pick-up con drones o barriles')));
              listadoProvisionalP47.add(const DropdownMenuItem(
                  value: "8", child: Text('8. Llave pública o comunitaria')));
              listadoProvisionalP47.add(const DropdownMenuItem(
                  value: "9", child: Text('9. Del vecino / otra vivienda')));
              listadoProvisionalP47.add(
                  const DropdownMenuItem(value: "10", child: Text('10. Otro')));
              break;
          }

          familiasProvider.poblarP44(listadoProvisionalRangos);
          familiasProvider.poblarP47(listadoProvisionalP47);

          if (!mounted) return;

          bool resp = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => FormularioFamilias(idPais: idPais)));

          if (resp == true) {
            setState(() {});
          }
        },
        backgroundColor: kNaranjaPrincipal,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

/*
ListTile(
                              leading: const Icon(
                                Icons.check_box,
                                color: kNaranjaPrincipal,
                              ),
                              title: Text(
                                'Encuestado: ${listado[i].nomEncuestado}',
                                style: GoogleFonts.lato(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                'Fecha: ${listado[i].fecha}',
                                style: GoogleFonts.lato(
                                  fontSize: 11,
                                ),
                              ),
                              trailing: const Icon(Icons.chevron_left),
                            ),
                          
*/