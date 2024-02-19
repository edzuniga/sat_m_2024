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
import 'package:sat_m/modelos/municipios_modelo.dart';
import 'package:sat_m/modelos/satm_comunidades_modelo.dart';
import 'package:sat_m/modelos/usuarios_modelo.dart';
import 'package:sat_m/pantallas/actualizar_comunidades_pantalla.dart';
import 'package:sat_m/pantallas/formulario_comunidades_pantalla.dart';
import 'package:sat_m/providers/condiciones_comunidades_provider.dart';
import 'package:sat_m/providers/satm_comunidades_provider.dart';

class ListadoFormComunidades extends StatefulWidget {
  const ListadoFormComunidades({super.key});

  @override
  State<ListadoFormComunidades> createState() => _ListadoFormComunidadesState();
}

class _ListadoFormComunidadesState extends State<ListadoFormComunidades> {
  @override
  Widget build(BuildContext context) {
    //Providers necesarios
    var comunidadesProvider =
        Provider.of<SatmComunidadesProvider>(context, listen: false);
    var condicionesProvider =
        Provider.of<CondicionesComunidadesProvider>(context, listen: false);

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
          'Listado SAT-M Comunidades',
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
            future: Future.wait(
              [
                DatabaseSatM.instance.obtenerSatmComunidades(),
                DatabaseSatM.instance.obtenerDepartamentos(),
                DatabaseSatM.instance.obtenerMunicipios(),
                DatabaseSatM.instance.obtenerTodasLasComunidadesModulo(),
              ],
            ),
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

              if (datos.data![0].isEmpty || datos.data![0] == []) {
                return Center(
                  child: Text(
                    'No hay encuestas guardadas!!!',
                    style: GoogleFonts.lato(fontSize: 16, color: Colors.black),
                  ),
                );
              } else {
                List<ComunidadesModelo> listado = datos.data![0];
                List<DepartamentosModelo> depasListado = datos.data![1];
                List<MunicipiosModelo> munisListado = datos.data![2];
                List<ComunidadesModuloModelo> comunidadesListado =
                    datos.data![3];

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
                      //Obtener nombre del departamento y municipio
                      String nombreDepto = "";
                      nombreDepto = depasListado
                          .firstWhere((element) =>
                              element.idDepartamento ==
                              listado[i].idDepartamento)
                          .departamento;

                      String nombreMuni = "";
                      nombreMuni = munisListado
                          .firstWhere((element) =>
                              element.idMunicipio == listado[i].idMunicipio)
                          .municipio;

                      //Obtener nombre de la comunidad
                      String nombreComunidad = "";
                      nombreComunidad = comunidadesListado
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
                                                await DatabaseSatM.instance
                                                    .borrarComunidadesPorCodalea(
                                                        listado[i]
                                                            .codaleaSatcomunidades);
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
                                    condicionesProvider.resetearCondiciones();

                                    //Obtener los datos de la BD por codalea
                                    await DatabaseSatM.instance
                                        .obtenerSatmComunidadesPorCodalea(
                                            listado[i].codaleaSatcomunidades)
                                        .then((value) async {
                                      comunidadesProvider.valorIdPais =
                                          int.parse(value.idPais.toString());
                                      comunidadesProvider.valorIdDepartamento =
                                          int.parse(
                                              value.idDepartamento.toString());
                                      comunidadesProvider.valorIdMunicipio =
                                          int.parse(
                                              value.idMunicipio.toString());
                                      comunidadesProvider.valorComunidad =
                                          int.parse(value.comunidad.toString());
                                      comunidadesProvider.valorAcepta =
                                          int.parse(value.acepta.toString());
                                      comunidadesProvider.valorSign =
                                          value.sign;
                                      comunidadesProvider.valorNomEncuestado =
                                          value.nomEncuestado;
                                      comunidadesProvider.valorTelEncuestado =
                                          value.telEncuestado;
                                      comunidadesProvider.valorIdentidad =
                                          value.identidad;
                                      comunidadesProvider.valorEdad =
                                          value.edad.toString();
                                      comunidadesProvider.valorSexo =
                                          value.sexo;
                                      comunidadesProvider.valorEducacion =
                                          value.educacion;
                                      comunidadesProvider.valorAnoCursado =
                                          value.anoCursado.toString();
                                      comunidadesProvider.valorEstado =
                                          value.estado;
                                      comunidadesProvider.valorNino =
                                          value.nino.toString();
                                      comunidadesProvider.valorAmbosPadres =
                                          value.ambosPadres;
                                      comunidadesProvider.valorNnPatrocinado =
                                          value.nnPatrocinado;
                                      comunidadesProvider.valorIdPatrocinio =
                                          value.idPatrocinio;
                                      comunidadesProvider.valorB1 = value.b1;
                                      comunidadesProvider.valorB2 = value.b2;
                                      comunidadesProvider.valorC1 = value.c1;
                                      comunidadesProvider.valorC2 = value.c2;
                                      comunidadesProvider.valorC3 = value.c3;
                                      comunidadesProvider.valorD1 = value.d1;
                                      comunidadesProvider.valorD2 = value.d2;
                                      comunidadesProvider.valorD3 = value.d3;
                                      comunidadesProvider.valorD4 = value.d4;
                                      comunidadesProvider.valorD9 = value.d9;
                                      comunidadesProvider.valorD5 = value.d5;
                                      comunidadesProvider.valorD6 = value.d6;
                                      comunidadesProvider.valorD7 = value.d7;
                                      comunidadesProvider.valorD8 = value.d8;
                                      comunidadesProvider.valorE1 = value.e1;
                                      comunidadesProvider.valorE2 = value.e2;
                                      comunidadesProvider.valorFacilitador =
                                          value.facilitador;
                                      comunidadesProvider.valorTelFacilitador =
                                          value.telFacilitador.toString();
                                      comunidadesProvider.valorFecha =
                                          value.fecha;
                                      comunidadesProvider.valorObservaciones =
                                          value.observaciones;
                                      comunidadesProvider.valorLat = value.lat;
                                      comunidadesProvider.valorLon = value.lon;
                                      comunidadesProvider.valorAlt = value.alt;
                                      comunidadesProvider.valorAcc = value.acc;

                                      //Manejo de las condiciones
                                      condicionesProvider.valorCondicionAcepta =
                                          true;
                                      if (comunidadesProvider.educacion != 1) {
                                        condicionesProvider.valorCondicion9 =
                                            true;
                                      }
                                      if (comunidadesProvider.nino.text !=
                                              "00" &&
                                          comunidadesProvider.nino.text != "" &&
                                          int.parse(comunidadesProvider
                                                  .nino.text) >
                                              0) {
                                        condicionesProvider.valorCondicion12 =
                                            true;
                                      }
                                      if (comunidadesProvider.nnPatrocinado ==
                                          1) {
                                        condicionesProvider.valorCondicion14 =
                                            true;
                                      }
                                      if (comunidadesProvider.d1 == 1) {
                                        condicionesProvider.valorCondicion21 =
                                            true;
                                      }
                                      if (comunidadesProvider.d3 == 1 ||
                                          comunidadesProvider.d4 == 1) {
                                        condicionesProvider
                                            .valorCondicion23y24 = true;
                                      }
                                      if (comunidadesProvider.d5 == 1) {
                                        condicionesProvider.valorCondicion26 =
                                            true;
                                      }
                                      if (comunidadesProvider.d6 == 1) {
                                        condicionesProvider.valorCondicion27 =
                                            true;
                                      }

                                      //Obtener el id del usuario y el idPaís del usuario
                                      List<UsuariosModelo> datosUsuario =
                                          await DatabaseSatM.instance
                                              .obtenerUsuarios();

                                      int idPais = datosUsuario[0].idPais;

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

                                      comunidadesProvider.poblarDepartamentos(
                                          listadoProvisional);

                                      //Generar listado para municipios (por id departamento)
                                      List<DropdownMenuItem<String>>
                                          munisProvi = [];
                                      List<MunicipiosModelo> munisPorDepto =
                                          await DatabaseSatM.instance
                                              .obtenerMunicipiosPorDepto(
                                                  comunidadesProvider
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
                                      comunidadesProvider
                                          .poblarMunicipios(munisProvi);

                                      //Generar listado para comunidades (por id municipio)
                                      List<DropdownMenuItem<String>>
                                          comunisProvi = [];
                                      List<ComunidadesModuloModelo>
                                          comunisPorMuni = await DatabaseSatM
                                              .instance
                                              .obtenerComunidadesModulo(
                                                  comunidadesProvider
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
                                      comunidadesProvider
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

                                      comunidadesProvider.poblarFacilitador(
                                          listadoProvisionalUsuarios);

                                      //-------POBLAR dropdown de INGRESOS DEL HOGAR (#17)
                                      List<DropdownMenuItem<String>>
                                          listadoProvisionalRangos = [];
                                      switch (idPais) {
                                        //Honduras
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
                                          break;

                                        //Guatemala
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
                                          break;

                                        //El Salvador
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
                                          break;
                                      }

                                      comunidadesProvider
                                          .poblarB2(listadoProvisionalRangos);

                                      if (!mounted) return;

                                      //Navegar a la página de actualizar
                                      bool resp = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  ActualizarComunidadesPantalla(
                                                    codaleaRecibido: listado[i]
                                                        .codaleaSatcomunidades,
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
                              child: ListTile(
                                leading: const Icon(
                                  Icons.check_box,
                                  color: kNaranjaPrincipal,
                                ),
                                title: Text(
                                  'Encuestado: ${listado[i].nomEncuestado}',
                                  style: GoogleFonts.lato(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  'Fecha: ${listado[i].fecha}\nDepartamento: $nombreDepto\nMunicipio: $nombreMuni\nComunidad: $nombreComunidad',
                                  style: GoogleFonts.lato(
                                    fontSize: 11,
                                  ),
                                ),
                                trailing: const Icon(Icons.chevron_left),
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
          /*List<PaisesModelo> paises =
              await DatabaseSatM.instance.obtenerPaisesPorId(idPais);

          List<DropdownMenuItem<String>> listadoProvisionalPaises = [];
          listadoProvisionalPaises.add(DropdownMenuItem(
            value: paises[0].idPais.toString(),
            child: Text(paises[0].pais),
          ));

          comunidadesProvider.poblarPaises(listadoProvisionalPaises); */

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

          comunidadesProvider.poblarDepartamentos(listadoProvisional);

          //-------POBLAR dropdown de Persona Encuestador
          List<DropdownMenuItem<String>> listadoProvisionalUsuarios = [];
          for (int i = 0; i < datosUsuario.length; i++) {
            listadoProvisionalUsuarios.add(DropdownMenuItem(
              value: datosUsuario[i].codaleaUsuario,
              child: Text(
                  "${datosUsuario[i].nombres} ${datosUsuario[i].apellidos}"),
            ));
          }

          comunidadesProvider.poblarFacilitador(listadoProvisionalUsuarios);

          //-------POBLAR dropdown de INGRESOS DEL HOGAR (#17)
          List<DropdownMenuItem<String>> listadoProvisionalRangos = [];
          switch (idPais) {
            //Honduras
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
              break;

            //Guatemala
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
              break;

            //El Salvador
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
              break;
          }

          comunidadesProvider.poblarB2(listadoProvisionalRangos);

          if (!mounted) return;

          bool resp = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => FormularioComunidades(idPais: idPais)));

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
