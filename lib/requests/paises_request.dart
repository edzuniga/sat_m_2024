import 'package:http/http.dart' as http;
import 'package:sat_m/bd/bd.dart';
import 'dart:convert';

import 'package:sat_m/constantes/colores_constantes.dart';
import 'package:sat_m/modelos/paises_modelo.dart';

Future<String> paisesRequest(int idUsuario) async {
  try {
    final respuesta = await http.post(Uri.parse(kApiUrl),
        body: {'action': "OBTENER_PAISES", 'idUsuario': idUsuario.toString()});

    if (respuesta.statusCode == 200) {
      var respuestaDecodificada = jsonDecode(respuesta.body);
      if (respuestaDecodificada == 'usuario_inactivo') {
        return "usuario_inactivo";
      } else if (respuestaDecodificada == 'paises_vacios') {
        return "paises_vacios";
      } else if (respuestaDecodificada == 'error') {
        return "error";
      } else {
        String grabarResponse =
            await _grabarInternamente(respuestaDecodificada);
        //Grabar row en la base de datos interna (países)

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
    int grabarEnBD = await DatabaseSatM.instance.agregarPaises(PaisesModelo(
      idPais: int.parse(datos[i]['idPais'].toString()),
      pais: datos[i]['pais'].toString(),
      moneda: datos[i]['moneda'].toString(),
      simbolo: datos[i]['simbolo'].toString(),
      digitosDni: int.parse(datos[i]['digitosDNI'].toString()),
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
