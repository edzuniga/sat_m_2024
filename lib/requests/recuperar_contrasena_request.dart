import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sat_m/constantes/colores_constantes.dart';

Future<String> recuperarContrasenaRequest(String correo) async {
  try {
    final respuesta = await http.post(Uri.parse(kApiUrl), body: {
      'action': "RECUPERAR_CONTRASENA",
      'correoUsuario': correo,
    });

    if (respuesta.statusCode == 200) {
      var respuestaDecodificada = jsonDecode(respuesta.body);
      if (respuestaDecodificada == 'usuario_inactivo') {
        return "usuario_inactivo";
      } else if (respuestaDecodificada == 'correo_inexistente') {
        return "correo_inexistente";
      } else if (respuestaDecodificada == 'correo_no_enviado') {
        return "correo_no_enviado";
      } else if (respuestaDecodificada == 'error') {
        return "error";
      } else {
        return "revise_correo";
      }
    } else {
      return "error";
    }
  } catch (e) {
    return e.toString();
  }
}
