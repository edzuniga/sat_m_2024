import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sat_m/bd/bd.dart';
import 'package:sat_m/pantallas/reportes_pantalla.dart';

import 'package:sat_m/constantes/colores_constantes.dart';
import 'package:sat_m/modales/logout_modal.dart';
import 'package:sat_m/modales/sincronizar_modal.dart';
import 'package:sat_m/modelos/miembros_migrantes_modelo.dart';
import 'package:sat_m/modelos/satm_comunidades_modelo.dart';
import 'package:sat_m/modelos/satm_familias_modelo.dart';
import 'package:sat_m/modelos/usuarios_modelo.dart';
import 'package:sat_m/pantallas/listado_form_comunidades.dart';
import 'package:sat_m/pantallas/listado_form_familias.dart';
import 'package:sat_m/pantallas/login.dart';
import 'package:sat_m/providers/sincronizar_provider.dart';
import 'package:sat_m/requests/comunidades_request.dart';
import 'package:sat_m/requests/familia_miembros_request.dart';
import 'package:sat_m/requests/familia_request.dart';
import 'package:sat_m/widgets/card_dashboard_widget.dart';
import 'package:sat_m/widgets/tarjetita_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int valorTotalComunidades = 0;

  @override
  Widget build(BuildContext context) {
    //Inicializar Base de Datos
    DatabaseSatM.instance.database;

    //Tamaño de pantalla
    Size screenSize = MediaQuery.of(context).size;

    //Iniciar provider de Sincronizar
    var sincronizarProvider = Provider.of<SincronizarProvider>(context);

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: FutureBuilder(
          future: Future.wait([
            DatabaseSatM.instance.obtenerUsuarios(),
            DatabaseSatM.instance.obtenerSatmComunidades(),
            DatabaseSatM.instance.obtenerSatmFamilias(),
          ]),
          builder: (context, AsyncSnapshot<List<dynamic>> datos) {
            if (datos.hasError) {
              return const Scaffold(
                body: Center(
                  child: Text(
                      'Ocurrió un error al querer obtener los datos del usuario!!!'),
                ),
              );
            }

            if (datos.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 15),
                      Text("Cargando datos del usuario. Por favor espere!!")
                    ],
                  ),
                ),
              );
            } else {
              //Crear las variables de los future
              List<UsuariosModelo> datosUsuario = datos.data![0];
              List<ComunidadesModelo> datosComunidades = datos.data![1];
              List<FamiliasModelo> datosFamilias = datos.data![2];

              //Variables dependiendo del país del usuario
              String bandera = (datosUsuario[0].idPais == 1)
                  ? 'assets/svg/hn_flag.svg'
                  : (datosUsuario[0].idPais == 2)
                      ? 'assets/svg/gt_flag.svg'
                      : 'assets/svg/sv_flag.svg';

              return (sincronizarProvider.sincronizando)
                  ? const Scaffold(
                      body: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(
                              color: kNaranjaPrincipal,
                            ),
                            SizedBox(height: 20),
                            Text('Por favor espere!!')
                          ],
                        ),
                      ),
                    )
                  : Scaffold(
                      appBar: PreferredSize(
                        preferredSize:
                            Size(screenSize.width, screenSize.height * 0.2),
                        child: AppBar(
                          automaticallyImplyLeading: false,
                          backgroundColor: kNaranjaPrincipal,
                          toolbarHeight: screenSize.height * 0.2,
                          titleSpacing: 0.0,
                          centerTitle: false,
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: screenSize.width * 0.07,
                                child: SvgPicture.asset(
                                    'assets/svg/c_izquierdo.svg'),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            elevation: 0,
                                            fixedSize: const Size(170, 26),
                                            backgroundColor: Colors.transparent,
                                            shape: RoundedRectangleBorder(
                                                side: const BorderSide(
                                                    color: Colors.white),
                                                borderRadius:
                                                    BorderRadius.circular(15))),
                                        onPressed: () {
                                          showDialog<String>(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (context) => AlertDialog(
                                                backgroundColor: Colors.white,
                                                content: const LogoutModal(),
                                                actions: <Widget>[
                                                  TextButton(
                                                    style: TextButton.styleFrom(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
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
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        )),
                                                    onPressed: () async {
                                                      await DatabaseSatM
                                                          .instance
                                                          .borrarComunidades();
                                                      await DatabaseSatM
                                                          .instance
                                                          .borrarFamilias();
                                                      await DatabaseSatM
                                                          .instance
                                                          .borrarMiembrosMigrantes();
                                                      await DatabaseSatM
                                                          .instance
                                                          .borrarComunidadesModulo();

                                                      //Borrar tablas
                                                      await DatabaseSatM
                                                          .instance
                                                          .borrarUsuarios()
                                                          .whenComplete(() {
                                                        //Cerrar modal
                                                        Navigator.pop(context);
                                                        //Ir al login
                                                        Navigator.pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (_) =>
                                                                    const LoginPage()));
                                                      });
                                                    },
                                                    child: const Text(
                                                      'Cerrar sesión',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ],
                                                actionsAlignment:
                                                    MainAxisAlignment.center),
                                          );
                                        },
                                        child: Text(
                                          'Cerrar sesión',
                                          style: GoogleFonts.lato(
                                              fontSize: 19,
                                              color: Colors.white),
                                        )),
                                    SizedBox(
                                      height: screenSize.height * 0.04,
                                    ),
                                    Text(
                                      'Bienvenido(a)',
                                      style: GoogleFonts.lato(
                                          fontSize: 21,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      "${datosUsuario[0].nombres} ${datosUsuario[0].apellidos}",
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.lato(
                                          fontSize: 19, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              // const SizedBox(width: 10),
                              SizedBox(
                                width: screenSize.width * 0.2,
                                child: SvgPicture.asset(
                                    'assets/svg/c_derecho.svg'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      body: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [kDegragado1, kDegragado2],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 35, left: 20, right: 20, bottom: 15),
                          child: RefreshIndicator(
                            onRefresh: () async {
                              return Future<void>.delayed(
                                      const Duration(seconds: 2))
                                  .whenComplete(() {
                                setState(() {});
                              });
                            },
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      bool? recargar = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  const ListadoFormComunidades()));
                                      if (recargar == true) {
                                        setState(() {});
                                      } else {
                                        setState(() {});
                                      }
                                    },
                                    child: (datosUsuario[0].formComu == 1)
                                        ? TarjetaDashboard(
                                            screenSize: screenSize,
                                            colorTarjeta: kNaranjaPrincipal,
                                            titulo: 'SAT-M [Comunidades]',
                                            descripcion:
                                                'Cuestionarios guardados y no sincronizados',
                                            cantidad: datosComunidades.length
                                                .toString(),
                                            icono: 'assets/svg/person_mas.svg',
                                          )
                                        : Container(),
                                  ),
                                  const SizedBox(height: 40),
                                  InkWell(
                                    onTap: () async {
                                      bool? recargarFamilias = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  const ListadoFormFamilias()));
                                      if (recargarFamilias == true) {
                                        setState(() {});
                                      } else {
                                        setState(() {});
                                      }
                                    },
                                    child: (datosUsuario[0].formFam == 1)
                                        ? TarjetaDashboard(
                                            screenSize: screenSize,
                                            colorTarjeta: kNaranjaPrincipal,
                                            titulo: 'SAT-M [Familias]',
                                            descripcion:
                                                'Cuestionarios guardados y no sincronizados',
                                            cantidad:
                                                datosFamilias.length.toString(),
                                            icono: 'assets/svg/grupo.svg',
                                          )
                                        : Container(),
                                  ),
                                  const SizedBox(height: 40),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Theme(
                                        data: ThemeData(
                                            dialogBackgroundColor:
                                                Colors.white),
                                        child: Builder(
                                          builder: (context) => InkWell(
                                            onTap: () {
                                              showDialog<String>(
                                                context: context,
                                                useSafeArea: false,
                                                barrierDismissible: false,
                                                builder: (context) =>
                                                    AlertDialog(
                                                        scrollable: true,
                                                        backgroundColor:
                                                            Colors.white,
                                                        content:
                                                            const SincronizarModal(),
                                                        actions:
                                                            (sincronizarProvider
                                                                    .sincronizando)
                                                                ? []
                                                                : <Widget>[
                                                                    TextButton(
                                                                      style: TextButton.styleFrom(
                                                                          shape: RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(10),
                                                                              side: const BorderSide(color: kNaranjaPrincipal))),
                                                                      onPressed:
                                                                          () =>
                                                                              Navigator.pop(context),
                                                                      child:
                                                                          const Text(
                                                                        'Cancelar',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black),
                                                                      ),
                                                                    ),
                                                                    TextButton(
                                                                      style: TextButton.styleFrom(
                                                                          backgroundColor: kNaranjaPrincipal,
                                                                          shape: RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(10),
                                                                          )),
                                                                      onPressed:
                                                                          () async {
                                                                        //Cambiar el estado de Ya Sincronizó
                                                                        sincronizarProvider.valorSincronizando =
                                                                            true;

                                                                        //Cerrar el modal
                                                                        Navigator.pop(
                                                                            context);

                                                                        //Manejo de errores
                                                                        List<int>
                                                                            errores =
                                                                            [];
                                                                        //0 => error
                                                                        //1 => éxito
                                                                        //2 => usuario inactivo
                                                                        //3 => error al cargar archivo

                                                                        //Manejo de si hay o no datos para sincronizar
                                                                        List<int>
                                                                            hayDatos =
                                                                            [];

                                                                        //----------------Sincronización de Formularios de comunidades
                                                                        List<ComunidadesModelo>
                                                                            totalComunidades =
                                                                            await DatabaseSatM.instance.obtenerSatmComunidades();

                                                                        if (totalComunidades
                                                                            .isNotEmpty) {
                                                                          hayDatos
                                                                              .add(1);
                                                                          for (int i = 0;
                                                                              i < totalComunidades.length;
                                                                              i++) {
                                                                            await comunidadesRequest(idUsuario: datosUsuario[0].id!, modelo: totalComunidades[i], idPais: datosUsuario[0].idPais).then((value) {
                                                                              if (value == "usuario_inactivo") {
                                                                                errores.add(2);
                                                                              } else if (value == "error") {
                                                                                errores.add(0);
                                                                              } else if (value == "no_cargo_archivo") {
                                                                                errores.add(3);
                                                                              } else if (value == "error_conexion") {
                                                                                errores.add(0);
                                                                              } else {
                                                                                errores.add(1);
                                                                              }
                                                                            });
                                                                          }
                                                                        }

//----------------Sincronización de Formularios de comunidades

//----------------Sincronización de Formularios de FAMILIAS
                                                                        List<FamiliasModelo>
                                                                            totalFamilias =
                                                                            await DatabaseSatM.instance.obtenerSatmFamilias();

                                                                        if (totalFamilias
                                                                            .isNotEmpty) {
                                                                          hayDatos
                                                                              .add(1);
                                                                          for (int i = 0;
                                                                              i < totalFamilias.length;
                                                                              i++) {
                                                                            await familiasRequest(idPais: datosUsuario[0].idPais, idUsuario: datosUsuario[0].id!, modelo: totalFamilias[i]).then((value) {
                                                                              if (value == "usuario_inactivo") {
                                                                                errores.add(2);
                                                                              } else if (value == "error") {
                                                                                errores.add(0);
                                                                              } else {
                                                                                errores.add(1);
                                                                              }
                                                                            });
                                                                          }
                                                                        }
//----------------Sincronización de Formularios de FAMILIAS

//----------------Sincronización de Formularios de MIEMBROS MIGRANTES
                                                                        List<MiembrosMigrantesModelo>
                                                                            totalMiembrosMigrantes =
                                                                            await DatabaseSatM.instance.obtenerMiembrosMigrantes();

                                                                        if (totalMiembrosMigrantes
                                                                            .isNotEmpty) {
                                                                          hayDatos
                                                                              .add(1);
                                                                          for (int i = 0;
                                                                              i < totalMiembrosMigrantes.length;
                                                                              i++) {
                                                                            await familiaMiembrosRequest(idUsuario: datosUsuario[0].id!, modelo: totalMiembrosMigrantes[i], idPais: datosUsuario[0].idPais).then((value) {
                                                                              if (value == "usuario_inactivo") {
                                                                                errores.add(2);
                                                                              } else if (value == "error") {
                                                                                errores.add(0);
                                                                              } else {
                                                                                errores.add(1);
                                                                              }
                                                                            });
                                                                          }
                                                                        }
                                                                        //----------------Sincronización de Formularios de MIEMBROS MIGRANTES
                                                                        if (hayDatos
                                                                            .isNotEmpty) {
                                                                          //revisión de posibles errores
                                                                          if (errores.contains(
                                                                              2)) {
                                                                            sincronizarProvider.valorSincronizando =
                                                                                false;

                                                                            Fluttertoast.showToast(
                                                                                msg: "Su usuario está inactivo!!\nContacte a soporte.",
                                                                                toastLength: Toast.LENGTH_LONG,
                                                                                gravity: ToastGravity.CENTER,
                                                                                timeInSecForIosWeb: 1,
                                                                                backgroundColor: Colors.orange,
                                                                                textColor: Colors.white,
                                                                                fontSize: 16.0);
                                                                          } else if (errores
                                                                              .contains(0)) {
                                                                            sincronizarProvider.valorSincronizando =
                                                                                false;
                                                                            Fluttertoast.showToast(
                                                                                msg: "Hubo problemas con la sincronización de algunas encuestas!!\nContacte a soporte.",
                                                                                toastLength: Toast.LENGTH_LONG,
                                                                                gravity: ToastGravity.CENTER,
                                                                                timeInSecForIosWeb: 1,
                                                                                backgroundColor: Colors.red,
                                                                                textColor: Colors.white,
                                                                                fontSize: 16.0);
                                                                          } else {
                                                                            sincronizarProvider.valorSincronizando =
                                                                                false;

                                                                            //Borrar las tablas
                                                                            await DatabaseSatM.instance.borrarComunidades();
                                                                            await DatabaseSatM.instance.borrarFamilias();
                                                                            await DatabaseSatM.instance.borrarMiembrosMigrantes();

                                                                            Fluttertoast.showToast(
                                                                              msg: "Sincronización exitosa!!",
                                                                              toastLength: Toast.LENGTH_LONG,
                                                                              gravity: ToastGravity.CENTER,
                                                                              timeInSecForIosWeb: 1,
                                                                              backgroundColor: Colors.green,
                                                                              textColor: Colors.white,
                                                                              fontSize: 16.0,
                                                                            ).then(
                                                                              (value) {
                                                                                setState(() {});
                                                                              },
                                                                            );
                                                                          }
                                                                        } else {
                                                                          Future.delayed(
                                                                              const Duration(seconds: 2),
                                                                              () {
                                                                            sincronizarProvider.valorSincronizando =
                                                                                false;
                                                                          }).whenComplete(
                                                                            () {
                                                                              Fluttertoast.showToast(
                                                                                msg: "No hay datos para sincronizar!!",
                                                                                toastLength: Toast.LENGTH_LONG,
                                                                                gravity: ToastGravity.CENTER,
                                                                                timeInSecForIosWeb: 1,
                                                                                backgroundColor: Colors.orange,
                                                                                textColor: Colors.white,
                                                                                fontSize: 16.0,
                                                                              );
                                                                            },
                                                                          );
                                                                        }
                                                                      },
                                                                      child:
                                                                          const Text(
                                                                        'Sincronizar',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white),
                                                                      ),
                                                                    ),
                                                                  ],
                                                        actionsAlignment:
                                                            MainAxisAlignment
                                                                .center),
                                              );
                                            },
                                            child: TarjetitaDashboard(
                                              screenSize: screenSize,
                                              titulo: 'Cargar',
                                              icono: 'assets/svg/nube.svg',
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => ReportesPage(
                                                      idPais: datosUsuario[0]
                                                          .idPais,
                                                      rol:
                                                          datosUsuario[0].idRol,
                                                    ))),
                                        child: TarjetitaDashboard(
                                          screenSize: screenSize,
                                          titulo: 'Reportes',
                                          icono: 'assets/svg/graph.svg',
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 40),
                                  SvgPicture.asset(
                                    'assets/logo/wvi_logo.svg',
                                    height: 36,
                                  ),
                                  const SizedBox(height: 62),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      floatingActionButtonLocation:
                          FloatingActionButtonLocation.endTop,
                      floatingActionButton: SizedBox(
                        height: 40,
                        width: 70,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: FloatingActionButton(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            backgroundColor: kBlanco,
                            onPressed: null,
                            child: SvgPicture.asset(
                              bandera,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ));
            }
          }),
    );
  }
}
