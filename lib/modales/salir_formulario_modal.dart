import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SalirFormularioModal extends StatelessWidget {
  const SalirFormularioModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      height: screenSize.height * 0.4,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/lottie/warning.json',
                  height: screenSize.height * 0.2),
              const Text('Por favor tomar en cuenta lo siguiente:',
                  textAlign: TextAlign.center),
              const SizedBox(height: 15),
              const Text(
                '* Si retrocede perderá los datos ingresados!!! - ¿Desea continuar?',
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                    fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
