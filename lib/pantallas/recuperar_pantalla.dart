import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sat_m/constantes/colores_constantes.dart';
import 'package:sat_m/providers/recuperar_provider.dart';
import 'package:sat_m/requests/recuperar_contrasena_request.dart';
import 'package:sat_m/widgets/login_input_widget.dart';

class RecuperarPantalla extends StatefulWidget {
  const RecuperarPantalla({super.key});

  @override
  State<RecuperarPantalla> createState() => _RecuperarPantallaState();
}

class _RecuperarPantallaState extends State<RecuperarPantalla> {
  //Llave para el formulario
  final formLlave = GlobalKey<FormState>();
  //Crear variable para el input de correo
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //Inicializar Provider de Recuperar Constrasena
    var recuperarProvider = Provider.of<RecuperarProvider>(context);

    //Obtener tamaño de la pantalla completa
    Size screenSize = MediaQuery.of(context).size;

    return Container(
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
      child: PopScope(
        canPop: false,
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: (recuperarProvider.esperandoRecuperacion)
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircularProgressIndicator(),
                        const SizedBox(height: 10),
                        Text(
                          'Por favor espere!!',
                          style: GoogleFonts.lato(fontSize: 16),
                        ),
                      ],
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: (screenSize.width * 0.19 / 2)),
                    child: ListView(
                      children: [
                        const SizedBox(height: 39),
                        SvgPicture.asset(
                          'assets/logo/wvi_logo.svg',
                          width: screenSize.width * 0.46,
                        ),
                        const SizedBox(height: 84),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '¿Olvidaste tu contraseña?',
                            style: GoogleFonts.lato(
                              fontSize: 20,
                            ),
                          ),
                        ),
                        const SizedBox(height: 28),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 18),
                          decoration: BoxDecoration(
                            color: kTinteNaranja4,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: !recuperarProvider.recuperacionSolicitada
                              ? Text(
                                  'Por favor introduce tu dirección de correo electrónico. Recibirás un correo con instrucciones para restablecer tu contraseña.',
                                  style: GoogleFonts.lato(
                                    fontSize: 18,
                                  ),
                                )
                              : Text(
                                  'Compruebe la bandeja de entrada de su correo electrónico. (De ser posible, revise su bandeja de correo no deseado!)',
                                  style: GoogleFonts.lato(
                                    fontSize: 18,
                                  ),
                                ),
                        ),
                        const SizedBox(height: 64),
                        !recuperarProvider.recuperacionSolicitada
                            ? Form(
                                key: formLlave,
                                child: LoginInputWidget(
                                    controlador: emailController,
                                    iconoDireccion: 'assets/svg/user_line.svg',
                                    placeholder: 'Correo electrónico'),
                              )
                            : Container(),
                        !recuperarProvider.recuperacionSolicitada
                            ? const SizedBox(height: 48)
                            : Container(),
                        !recuperarProvider.recuperacionSolicitada
                            ? ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(185, 41),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  backgroundColor: kNaranjaPrincipal,
                                ),
                                onPressed: () async {
                                  //Verificación que sea un correo válido o que al menos
                                  //haya algo escrito
                                  if (formLlave.currentState!.validate()) {
                                    //Habilitar el "POR FAVOR ESPERE"
                                    recuperarProvider
                                        .valorEsperandoRecuperacion = true;

                                    //Hacer el REQUEST para mandar a pedir el cambio de contraseña
                                    await recuperarContrasenaRequest(
                                            emailController.text)
                                        .then((value) {
                                      if (value == 'usuario_inactivo') {
                                        recuperarProvider
                                            .valorEsperandoRecuperacion = false;

                                        Fluttertoast.showToast(
                                            msg:
                                                "Este usuario se encuentra inactivo!!",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.yellow,
                                            textColor: Colors.black,
                                            fontSize: 16.0);
                                      } else if (value ==
                                          'correo_inexistente') {
                                        recuperarProvider
                                            .valorEsperandoRecuperacion = false;

                                        Fluttertoast.showToast(
                                            msg:
                                                "Revise el correo!!\nNo hay registro existente.",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.orange,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                      } else if (value == 'correo_no_enviado' ||
                                          value == 'error') {
                                        recuperarProvider
                                            .valorEsperandoRecuperacion = false;

                                        Fluttertoast.showToast(
                                            msg:
                                                "Hubo error de conexión!!\nPruebe más tarde o contacte a soporte!!.",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                      } else {
                                        recuperarProvider
                                            .valorEsperandoRecuperacion = false;

                                        Fluttertoast.showToast(
                                            msg: "Correo enviado!!.",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.green,
                                            textColor: Colors.white,
                                            fontSize: 16.0);

                                        //Cambiar estado del provider

                                        recuperarProvider
                                            .valorRecuperacionSolicitada = true;
                                      }
                                    });
                                  }
                                },
                                child: Text(
                                  'Enviar',
                                  style: GoogleFonts.lato(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            : Container(),
                        TextButton(
                          onPressed: () {
                            //Resetear el valor del provider de recuperación
                            recuperarProvider.resetearVariables();
                            //Navegar hacia atrás
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Volver para iniciar sesión',
                            textAlign: TextAlign.right,
                            style: GoogleFonts.lato(
                                fontSize: 15, color: kTinteGris3),
                          ),
                        ),
                        const SizedBox(height: 39),
                      ],
                    ),
                  )),
      ),
    );
  }
}
