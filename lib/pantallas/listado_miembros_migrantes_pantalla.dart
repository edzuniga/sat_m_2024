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
import 'package:sat_m/modelos/usuarios_modelo.dart';
import 'package:sat_m/pantallas/actualizar_miembros_migrantes_pantalla.dart';
import 'package:sat_m/pantallas/formulario_miembros_migrantes_pantalla.dart';
import 'package:sat_m/providers/condiciones_miembros_migrantes_provider.dart';
import 'package:sat_m/providers/miembros_migrantes_provider.dart';

class ListadoMiembrosMigrantes extends StatefulWidget {
  const ListadoMiembrosMigrantes({required this.codaleaBoleta, Key? key})
      : super(key: key);

  final String codaleaBoleta;

  @override
  State<ListadoMiembrosMigrantes> createState() =>
      _ListadoMiembrosMigrantesState();
}

class _ListadoMiembrosMigrantesState extends State<ListadoMiembrosMigrantes> {
  @override
  Widget build(BuildContext context) {
    //Provider necesarios
    var migrantesProvider =
        Provider.of<MiembrosMigrantesProvider>(context, listen: false);
    var condicionesMigrantesProvider =
        Provider.of<MiembrosMigrantesCondicionesProvider>(context,
            listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kNaranjaPrincipal,
        centerTitle: false,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.only(left: 15, top: 15, bottom: 15),
            child: SvgPicture.asset(
              'assets/svg/backspace.svg',
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: Text(
          'Listado Miembros Migrantes',
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
            future: DatabaseSatM.instance
                .obtenerMiembrosMograntesPorCodaleaSatmFamilia(
                    widget.codaleaBoleta),
            builder:
                (context, AsyncSnapshot<List<MiembrosMigrantesModelo>> datos) {
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

              if (datos.data!.isEmpty || datos.data == []) {
                return Center(
                  child: Text(
                    'No hay miembros migrantes guardados asociados a la encuesta de familias!!!',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(fontSize: 16, color: Colors.black),
                  ),
                );
              } else {
                List<MiembrosMigrantesModelo> listado = datos.data!;
                return RefreshIndicator(
                  onRefresh: () async {
                    return Future<void>.delayed(const Duration(seconds: 2))
                        .whenComplete(() {
                      setState(() {});
                    });
                  },
                  child: ListView.builder(
                    itemCount: listado.length,
                    itemBuilder: (context, int i) => Column(
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
                                                      BorderRadius.circular(10),
                                                )),
                                            onPressed: () async {
                                              await DatabaseSatM.instance
                                                  .borrarMiembrosMigrantesPorCodalea(
                                                      listado[i]
                                                          .codaleaMiembros)
                                                  .then((value) {
                                                setState(() {
                                                  Navigator.pop(context);
                                                });
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
                                  //Obtener los datos de la BD y asignarlos al provider
                                  await DatabaseSatM.instance
                                      .obtenerMiembrosMigrantesPorCodalea(
                                          listado[i].codaleaMiembros)
                                      .then((value) {
                                    migrantesProvider.valorretornado =
                                        value[0].retornado;
                                    migrantesProvider.valortemporalidad =
                                        value[0].temporalidad;
                                    migrantesProvider.valorcomunidad =
                                        value[0].comunidad;
                                    migrantesProvider.valornomEncuestado =
                                        value[0].nomEncuestado;
                                    migrantesProvider.valoredad =
                                        value[0].edad.toString();
                                    migrantesProvider.valorgenero =
                                        value[0].genero;
                                    migrantesProvider.valornumTelefono =
                                        value[0].numTelefono;
                                    migrantesProvider.valoridDepartamento =
                                        value[0].idDepartamento;
                                    migrantesProvider.valoridMunicipio =
                                        value[0].idMunicipio;
                                    migrantesProvider.valornomComunidad =
                                        value[0].nomComunidad;
                                    migrantesProvider.valornivelEducativo =
                                        value[0].nivelEducativo;
                                    migrantesProvider.valorocupacion =
                                        value[0].ocupacion;
                                    migrantesProvider.valorestadoCivil =
                                        value[0].estadoCivil;
                                    migrantesProvider.valorp09 = value[0].p09;
                                    migrantesProvider.valorp09Relacion =
                                        value[0].p09Relacion;
                                    migrantesProvider.valorp10 = value[0].p10;
                                    migrantesProvider.valorp10Otro =
                                        value[0].p10Otro;
                                    migrantesProvider.valorp11 = value[0].p11;
                                    migrantesProvider.valorp11Otro =
                                        value[0].p11Otro;
                                    migrantesProvider.valorp12 = value[0].p12;
                                    migrantesProvider.valorp12Numero =
                                        value[0].p12Numero.toString();
                                    migrantesProvider.valorp12Relacion =
                                        value[0].p12Relacion;
                                    migrantesProvider.valorp13 = value[0].p13;
                                    migrantesProvider.valorp13Anio =
                                        value[0].p13Anio.toString();
                                    migrantesProvider.valorp13Pais =
                                        value[0].p13Pais;
                                    migrantesProvider.valorp14 = value[0].p14;
                                    migrantesProvider.valorp14Descripcion =
                                        value[0].p14Descripcion;
                                    migrantesProvider.valorp15 = value[0].p15;
                                    migrantesProvider.valorp15Servicios =
                                        value[0].p15Servicios;
                                    migrantesProvider.valorp16 = value[0].p16;
                                    migrantesProvider.valorp16Razones =
                                        value[0].p16Razones;
                                  });

                                  //Manejo de condiciones
                                  if (migrantesProvider.retornado == 1) {
                                    condicionesMigrantesProvider
                                        .valorCondicion0 = true;
                                  } else {
                                    condicionesMigrantesProvider
                                        .valorCondicion0 = false;
                                  }

                                  if (migrantesProvider.p09 == 1) {
                                    condicionesMigrantesProvider
                                        .valorCondicionP09 = true;
                                  } else {
                                    condicionesMigrantesProvider
                                        .valorCondicionP09 = false;
                                  }

                                  if (migrantesProvider.p10 == 4) {
                                    condicionesMigrantesProvider
                                        .valorCondicionP10 = true;
                                  } else {
                                    condicionesMigrantesProvider
                                        .valorCondicionP10 = false;
                                  }

                                  if (migrantesProvider.p11 == 3) {
                                    condicionesMigrantesProvider
                                        .valorCondicionP11 = true;
                                  } else {
                                    condicionesMigrantesProvider
                                        .valorCondicionP11 = false;
                                  }

                                  if (migrantesProvider.p12 == 1) {
                                    condicionesMigrantesProvider
                                        .valorCondicionP12 = true;
                                  } else {
                                    condicionesMigrantesProvider
                                        .valorCondicionP12 = false;
                                  }

                                  if (migrantesProvider.p13 == 1) {
                                    condicionesMigrantesProvider
                                        .valorCondicionP13 = true;
                                  } else {
                                    condicionesMigrantesProvider
                                        .valorCondicionP13 = false;
                                  }

                                  if (migrantesProvider.p14 == 1) {
                                    condicionesMigrantesProvider
                                        .valorCondicionP14 = true;
                                  } else {
                                    condicionesMigrantesProvider
                                        .valorCondicionP14 = false;
                                  }

                                  if (migrantesProvider.p15 == 1) {
                                    condicionesMigrantesProvider
                                        .valorCondicionP15 = true;
                                  } else {
                                    condicionesMigrantesProvider
                                        .valorCondicionP15 = false;
                                  }

                                  if (migrantesProvider.p16 == 1) {
                                    condicionesMigrantesProvider
                                        .valorCondicionP16 = true;
                                  } else {
                                    condicionesMigrantesProvider
                                        .valorCondicionP16 = false;
                                  }

                                  //obtener datos del usuario
                                  List<UsuariosModelo> datosUsuario =
                                      await DatabaseSatM.instance
                                          .obtenerUsuarios();

                                  //-------POBLAR dropdown de Departamentos
                                  List<DepartamentosModelo> departamentos =
                                      await DatabaseSatM.instance
                                          .obtenerDepartamentosPorPais(
                                              datosUsuario[0].idPais);

                                  List<DropdownMenuItem<String>>
                                      listadoProvisional = [];
                                  for (int i = 0;
                                      i < departamentos.length;
                                      i++) {
                                    listadoProvisional.add(DropdownMenuItem(
                                      value: departamentos[i]
                                          .idDepartamento
                                          .toString(),
                                      child:
                                          Text(departamentos[i].departamento),
                                    ));
                                  }

                                  migrantesProvider
                                      .poblarDepartamentos(listadoProvisional);

                                  //-------POBLAR dropdown de Municipios
                                  List<MunicipiosModelo> municipios =
                                      await DatabaseSatM.instance
                                          .obtenerMunicipiosPorDepto(
                                              migrantesProvider.idDepartamento);

                                  List<DropdownMenuItem<String>> munisProvi =
                                      [];
                                  for (int i = 0; i < municipios.length; i++) {
                                    munisProvi.add(DropdownMenuItem(
                                      value:
                                          municipios[i].idMunicipio.toString(),
                                      child: Text(municipios[i].municipio),
                                    ));
                                  }

                                  migrantesProvider
                                      .poblarMunicipios(munisProvi);

                                  //-------POBLAR dropdown de Comunidades
                                  List<ComunidadesModuloModelo> comunidades =
                                      await DatabaseSatM.instance
                                          .obtenerComunidadesModulo(
                                              migrantesProvider.idMunicipio!);

                                  List<DropdownMenuItem<String>> comunisProvi =
                                      [];
                                  for (int i = 0; i < comunidades.length; i++) {
                                    comunisProvi.add(DropdownMenuItem(
                                      value:
                                          comunidades[i].idComunidad.toString(),
                                      child:
                                          Text(comunidades[i].nombreComunidad),
                                    ));
                                  }

                                  migrantesProvider
                                      .poblarComunidades(comunisProvi);

                                  if (!mounted) return;

                                  //Navegar a la página de actualizar
                                  bool resp = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              ActualizarMiembrosMigrantes(
                                                  codaleaBoleta: listado[i]
                                                      .codaleaMiembros,
                                                  idPais:
                                                      datosUsuario[0].idPais)));

                                  if (resp == true) {
                                    setState(() {});
                                  }
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
                                'Nombre: ${listado[i].nomEncuestado}',
                                style: GoogleFonts.lato(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                'Edad: ${listado[i].edad}\nTeléfono: ${listado[i].numTelefono}',
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
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          //Obtener el id país del usuario
          List<UsuariosModelo> datosUsuario =
              await DatabaseSatM.instance.obtenerUsuarios();

          int idPais = datosUsuario[0].idPais;

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

          migrantesProvider.poblarDepartamentos(listadoProvisional);

          if (!mounted) return;

          bool resp = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => FormularioMiembrosMigrantes(
                        idPais: idPais,
                        codaleaBoleta: widget.codaleaBoleta,
                      )));

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
