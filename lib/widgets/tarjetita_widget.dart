import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sat_m/constantes/colores_constantes.dart';

class TarjetitaDashboard extends StatelessWidget {
  const TarjetitaDashboard(
      {super.key,
      required this.screenSize,
      required this.icono,
      required this.titulo});

  final Size screenSize;
  final String icono;
  final String titulo;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenSize.width * 0.4,
      height: screenSize.height * 0.13,
      decoration: BoxDecoration(boxShadow: const [
        BoxShadow(
          color: Colors.grey,
          offset: Offset(0.0, 1.0), //(x,y)
          blurRadius: 1.0,
        ),
      ], color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        SvgPicture.asset(icono),
        Text(
          titulo,
          style: GoogleFonts.lato(fontSize: 20, color: kTextoAzul),
        ),
      ]),
    );
  }
}
