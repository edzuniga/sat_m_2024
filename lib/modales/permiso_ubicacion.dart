import 'package:flutter/material.dart';

class LocationPermissionDialog extends StatelessWidget {
  const LocationPermissionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Permiso de Ubicación"),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "SAT-M recopila datos de ubicación para: ",
          ),
          Text('* registrar la ubicación donde se realizó la encuesta'),
          Text('* incluir la encuesta en el mapa de reportes'),
          Text('* transparentar la ubicación donde se realizó la encuesta'),
          SizedBox(height: 20),
          Text(
              'Solamente se obtiene la ubicación cuando la aplicación está en uso.'),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text("No acepto"),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(true); // Close the dialog
          },
          child: const Text("Acepto"),
        ),
      ],
    );
  }
}
