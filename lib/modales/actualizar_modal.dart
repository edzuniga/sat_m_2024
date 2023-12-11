import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ActualizarModal extends StatelessWidget {
  const ActualizarModal({Key? key}) : super(key: key);

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
                '* Al actualizar las tablas de Países, Departamentos, Municipios y los rangos de ingresos se BORRARÁN las encuestas que NO haya sincronizado!!!',
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                    fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 15),
              const Text('¿Está seguro que desea continuar?')
            ],
          ),
        ),
      ),
    );
  }
}
