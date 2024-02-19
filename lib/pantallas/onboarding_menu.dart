import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:sat_m/bd/bd.dart';
import 'package:sat_m/constantes/colores_constantes.dart';
import 'package:sat_m/modelos/onboarding_modelo.dart';
import 'package:sat_m/pantallas/login.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingMenuPantalla extends StatefulWidget {
  const OnboardingMenuPantalla({super.key});

  @override
  State<OnboardingMenuPantalla> createState() => _OnboardingMenuPantallaState();
}

class _OnboardingMenuPantallaState extends State<OnboardingMenuPantalla> {
  //listado de textos
  List<String> textosOnboarding = [
    'Puede realizar encuestas\nsin conexión a internet',
    'Puede sincronizar las encuestas guardadas en\nel dispositivo cuando tenga conexión a internet',
    'Todas las encuestas se sincronizan\na un sistema web central',
    'Los accesos se administran\ndesde el sistema web central'
  ];
  //Controlador de las páginas
  final controlador = PageController(initialPage: 0);
  int indexPagina = 0;

  @override
  void dispose() {
    controlador.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: screenSize.height * 0.65,
            child: PageView(
              onPageChanged: (pag) {
                setState(() {
                  indexPagina = pag;
                });
              },
              controller: controlador,
              scrollDirection: Axis.horizontal,
              children: [
                Lottie.asset('assets/lottie/sin_conexion.json',
                    fit: BoxFit.cover),
                Lottie.asset('assets/lottie/sincronizar.json',
                    fit: BoxFit.cover),
                Lottie.asset('assets/lottie/web_central.json',
                    fit: BoxFit.cover),
                Lottie.asset('assets/lottie/gestion_usuarios.json',
                    fit: BoxFit.cover),
              ],
            ),
          ),
          SizedBox(
            height: screenSize.height * 0.35,
            child: Column(
              children: [
                const Spacer(),
                Text(
                  textosOnboarding[indexPagina],
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(),
                ),
                const Spacer(),
                SmoothPageIndicator(
                  controller: controlador,
                  count: 4,
                  effect: const WormEffect(
                    spacing: 16,
                    activeDotColor: kNaranjaPrincipal,
                  ),
                ),
                const Spacer(),
                (indexPagina != 3)
                    ? InkWell(
                        onTap: () {
                          controlador.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut);
                          indexPagina++;
                        },
                        child: Container(
                          height: 40,
                          width: screenSize.width * 0.70,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: kNaranjaPrincipal,
                          ),
                          child: Text(
                            'Deslice para continuar',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.lato(color: Colors.white),
                          ),
                        ),
                      )
                    : InkWell(
                        onTap: () async {
                          //Grabar en tabla interna (para no mostrar este mensaje nuevamente)
                          await DatabaseSatM.instance
                              .agregarOnBoardingActivo(
                                  OnBoardingModelo(activo: 1))
                              .then((value) {
                            (value != 0)
                                ? Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => const LoginPage()))
                                : Fluttertoast.showToast(
                                    msg:
                                        "Hay un error en la aplicación!!\nContacte soporte.",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                          });
                        },
                        child: Container(
                          height: 40,
                          width: screenSize.width * 0.50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: kNaranjaPrincipal,
                          ),
                          child: Text(
                            'Iniciar',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.lato(color: Colors.white),
                          ),
                        ),
                      ),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
