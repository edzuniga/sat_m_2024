import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import 'package:sat_m/constantes/colores_constantes.dart';
import 'package:sat_m/providers/sincronizar_provider.dart';

class SincronizarModal extends StatefulWidget {
  const SincronizarModal({super.key});

  @override
  State<SincronizarModal> createState() => _SincronizarModalState();
}

class _SincronizarModalState extends State<SincronizarModal> {
  @override
  Widget build(BuildContext context) {
    //Iniciar provider de Sincronizar
    var sincronizarProvider = Provider.of<SincronizarProvider>(context);

    var screenSize = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      height: screenSize.height * 0.35,
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/lottie/uploading.json',
                  height: screenSize.height * 0.2),
              (sincronizarProvider.sincronizando)
                  ? Text(
                      'Sincronizando Encuestas',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: kTextoAzul,
                      ),
                    )
                  : Text(
                      'Después de sincronizar las encuestas, estas se eliminarán del dispositivo!!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: kTextoAzul,
                      ),
                    ),
              const SizedBox(height: 15),
              (sincronizarProvider.sincronizando)
                  ? Text(
                      'Por favor espere!!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                        fontSize: 14,
                        color: kTextoAzul,
                      ),
                    )
                  : Text(
                      'Tendrá acceso a través del sistema web.\n¿Está seguro?',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                        fontSize: 14,
                        color: kTextoAzul,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
