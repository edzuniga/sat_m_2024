import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sat_m/bd/bd.dart';
//import 'package:sat_m/bd/bd.dart';

import 'package:sat_m/constantes/colores_constantes.dart';
import 'package:sat_m/modelos/usuarios_modelo.dart';
//import 'package:sat_m/modelos/usuarios_modelo.dart';
import 'package:sat_m/pantallas/home_pantalla.dart';
import 'package:sat_m/pantallas/recuperar_pantalla.dart';
import 'package:sat_m/providers/login_provider.dart';
import 'package:sat_m/requests/comunidades_modulo_request.dart';
//import 'package:sat_m/requests/limites_propensiones_request.dart';
//import 'package:sat_m/requests/departamentos_request.dart';
import 'package:sat_m/requests/login_request.dart';
//import 'package:sat_m/requests/municipios_request.dart';
//import 'package:sat_m/requests/opciones_ingresos_request.dart';
//import 'package:sat_m/requests/paises_request.dart';
//import 'package:sat_m/requests/rangos_p44_request.dart';
import 'package:sat_m/widgets/login_input_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //Llave para el formulario
  static final formKey = GlobalKey<FormState>();

  //bool esta descargando tablas
  bool loadingTables = false;

  @override
  Widget build(BuildContext context) {
    //Obtener tamaño de la pantalla completa
    Size screenSize = MediaQuery.of(context).size;

    //iniciar provider de login
    var loginProvider = Provider.of<LoginProvider>(context);

    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFFAFAFB),
            Color(0xFFFFF1E6),
          ],
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          titleSpacing: 0.0,
          centerTitle: false,
          toolbarHeight: screenSize.height * 0.28,
          automaticallyImplyLeading: false,
          title: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SizedBox(
                width: double.infinity,
                height: screenSize.height * 0.28,
                child: Image.asset(
                  'assets/img/portada_3_compressed.png',
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFFFCF7F4),
                        Color(0xFFFCF7F4),
                      ],
                    ),
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(15))),
                width: double.infinity,
                height: 20,
              ),
            ],
          ),
          elevation: 0,
        ),
        body: (!loadingTables)
            ? Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: SizedBox(
                    width: double.infinity,
                    height: screenSize.height * 0.70,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Spacer(),
                        SvgPicture.asset(
                          'assets/logo/wvi_logo.svg',
                          width: screenSize.width * 0.56,
                        ),
                        const SizedBox(
                          height: 55,
                        ),
                        SvgPicture.asset(
                          'assets/logo/logo-satm.svg',
                          width: screenSize.width * 0.46,
                        ),
                        const Spacer(),
                        Text(
                          'Bienvenid@ a SAT-M',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.bold,
                            fontSize: 21,
                          ),
                        ),
                        Text(
                          'Inicio de sesión',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lato(
                            fontSize: 21,
                          ),
                        ),
                        const SizedBox(height: 26),
                        LoginInputWidget(
                            controlador: loginProvider.email,
                            iconoDireccion: 'assets/svg/user_line.svg',
                            placeholder: 'Correo electrónico'),
                        const SizedBox(height: 26),
                        LoginInputWidget(
                            contrasena: true,
                            controlador: loginProvider.password,
                            iconoDireccion: 'assets/svg/lock_line.svg',
                            placeholder: 'Contraseña'),
                        const SizedBox(height: 26),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(185, 41),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            backgroundColor: kNaranjaPrincipal,
                          ),
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              setState(() {
                                loadingTables = true;
                              });

                              await loginRequest(loginProvider.email.text,
                                      loginProvider.password.text)
                                  .then((value) {
                                if (value == "usuario_inactivo") {
                                  Fluttertoast.showToast(
                                      msg: "Usuario inactivo!!",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.yellow,
                                      textColor: Colors.black,
                                      fontSize: 16.0);

                                  setState(() {
                                    loadingTables = false;
                                  });
                                } else if (value ==
                                    "credenciales_incorrectas") {
                                  Fluttertoast.showToast(
                                      msg: "Revise correo o contraseña!!",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.orange,
                                      textColor: Colors.white,
                                      fontSize: 16.0);

                                  setState(() {
                                    loadingTables = false;
                                  });
                                } else if (value == "error") {
                                  Fluttertoast.showToast(
                                      msg: "Error de conexión!!",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);

                                  setState(() {
                                    loadingTables = false;
                                  });
                                } else if (value == "usuario_encontrado") {
                                  Fluttertoast.showToast(
                                          msg: "Usuario encontrado y activo!!",
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.green,
                                          textColor: Colors.white,
                                          fontSize: 16.0)
                                      .whenComplete(() async {
                                    //Obtener el id del usuario
                                    List<UsuariosModelo> usuarioBD =
                                        await DatabaseSatM.instance
                                            .obtenerUsuarios();
                                    int userId = usuarioBD[0].id!;
                                    int idPais = usuarioBD[0].idPais;

                                    //Poblar las tabla de comunidades módulo
                                    await comunidadesModuloRequest(
                                        userId, idPais);

                                    //Poblar tabla de LÍMITES DE PROPENSIONES
                                    //await limitesPropensionesRequest(userId);

                                    //Resetear variables del login
                                    loginProvider.resetearVariables();

                                    if (!mounted) return;

                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => const HomePage()));
                                  });
                                }
                              });
                            }
                          },
                          child: Text(
                            'Ingresar',
                            style: GoogleFonts.lato(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 15),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const RecuperarPantalla()));
                          },
                          child: Text(
                            'Recuperar contraseña',
                            textAlign: TextAlign.right,
                            style: GoogleFonts.lato(
                                fontSize: 15,
                                decoration: TextDecoration.underline,
                                color: const Color(0xFF262626)),
                          ),
                        ),
                        Text(
                          'v. 1.0',
                          style: GoogleFonts.lato(fontSize: 12),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              )
            : const Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 15),
                      Text("Cargando datos...",
                          style: TextStyle(color: Colors.black)),
                    ]),
              ),
      ),
    );
  }
}
