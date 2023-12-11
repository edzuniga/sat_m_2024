import 'package:http/http.dart' as http;
import 'package:sat_m/bd/bd.dart';
import 'dart:convert';

import 'package:sat_m/constantes/colores_constantes.dart';
import 'package:sat_m/modelos/rangos_modelo.dart';

Future<String> rangosP44Request(int idUsuario) async {
  try {
    final respuesta = await http.post(Uri.parse(kApiUrl), body: {
      'action': "OBTENER_RANGOS_P44",
      'idUsuario': idUsuario.toString()
    });

    if (respuesta.statusCode == 200) {
      var respuestaDecodificada = jsonDecode(respuesta.body);
      if (respuestaDecodificada == 'usuario_inactivo') {
        return "usuario_inactivo";
      } else if (respuestaDecodificada == 'rangos_p44_vacios') {
        return "rangos_p44_vacios";
      } else if (respuestaDecodificada == 'error') {
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
    int grabarEnBD = await DatabaseSatM.instance.agregarRangos(RangosModelo(
      idPais: int.parse(datos[i]['idPais'].toString()),
      rango44Opt1: datos[i]['rango44_opt1'].toString(),
      rango44Opt2: datos[i]['rango44_opt2'].toString(),
      rango44Opt3: datos[i]['rango44_opt3'].toString(),
      rango44Opt4: datos[i]['rango44_opt4'].toString(),
      rango44Opt5: datos[i]['rango44_opt5'].toString(),
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
