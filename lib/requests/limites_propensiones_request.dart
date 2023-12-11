/*import 'package:http/http.dart' as http;
import 'package:sat_m/bd/bd.dart';
import 'dart:convert';

import 'package:sat_m/constantes/colores_constantes.dart';
import 'package:sat_m/modelos/limites_propensiones_modelo.dart';

Future<String> limitesPropensionesRequest(int idUsuario) async {
  try {
    final respuesta = await http.post(Uri.parse(kApiUrl), body: {
      'action': "OBTENER_PROPENSIONES",
      'idUsuario': idUsuario.toString()
    });

    if (respuesta.statusCode == 200) {
      var respuestaDecodificada = jsonDecode(respuesta.body);
      if (respuestaDecodificada == 'usuario_inactivo') {
        return "usuario_inactivo";
      } else if (respuestaDecodificada == 'propensiones_vacias') {
        return "rangos_p44_vacios";
      } else if (respuestaDecodificada == 'error_conexion') {
        return "error";
      } else {
        String grabarResponse =
            await _grabarInternamente(respuestaDecodificada);
        if (grabarResponse == "exito") {
          return "exito";
        } else {
          return "error";
        }
      }
    } else {
      return "error";
    }
  } catch (e) {
    return e.toString();
  }
}

Future<String> _grabarInternamente(List<dynamic> datos) async {
  List<int> revisionInterna = [];
  for (int i = 0; i < datos.length; i++) {
    int grabarEnBD = await DatabaseSatM.instance
        .agregarLimitesPropensiones(LimitesPropensionesModelo(
      codaleaPropension: datos[i]['codaleaPropension'].toString(),
      limiteInf: double.parse(datos[i]['limite_inf']),
      limiteSup: double.parse(datos[i]['limite_sup']),
    ));
    if (grabarEnBD != 0) {
      revisionInterna.add(1);
    } else {
      revisionInterna.add(0);
    }
  }

  if (revisionInterna.contains(0)) {
    return 'error';
  } else {
    return 'exito';
  }
}
*/