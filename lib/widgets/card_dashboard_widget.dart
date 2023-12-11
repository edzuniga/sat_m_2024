import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sat_m/constantes/colores_constantes.dart';

class TarjetaDashboard extends StatelessWidget {
  const TarjetaDashboard({
    super.key,
    required this.screenSize,
    required this.colorTarjeta,
    required this.titulo,
    required this.descripcion,
    required this.cantidad,
    required this.icono,
  });

  final Size screenSize;
  final Color colorTarjeta;
  final String titulo;
  final String descripcion;
  final String cantidad;
  final String icono;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      borderRadius: const BorderRadius.all(Radius.circular(15)),
      child: Container(
        padding:
            const EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 10),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        height: 157,
        width: screenSize.width * 0.80,
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: screenSize.width * 0.18,
                  height: screenSize.width * 0.2,
                  decoration: BoxDecoration(
                      color: colorTarjeta,
                      borderRadius: BorderRadius.circular(15)),
                  alignment: Alignment.center,
                  child: Text(
                    cantidad,
                    style: GoogleFonts.lato(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.only(left: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Text(titulo,
                            style: GoogleFonts.lato(
                                fontSize: 16,
                                color: kTextoAzul,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: 15),
                        Text(descripcion,
                            style: GoogleFonts.lato(
                                fontSize: 14, color: kTextoAzul)),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: BoxDecoration(
                        color: colorTarjeta,
                        borderRadius: BorderRadius.circular(10)),
                    height: 42,
                    width: 42,
                    padding: const EdgeInsets.all(8),
                    child: SvgPicture.asset(icono),
                  ),
                ),
              ],
            ),
            Align(
                alignment: Alignment.topRight,
                child: SvgPicture.asset('assets/svg/chispas_tarjeta.svg')),
          ],
        ),
      ),
    );
  }
}
