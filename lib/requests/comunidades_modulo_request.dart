import 'package:http/http.dart' as http;
import 'package:sat_m/bd/bd.dart';
import 'dart:convert';

import 'package:sat_m/constantes/colores_constantes.dart';
import 'package:sat_m/modelos/comunidades_modelo.dart';

Future<String> comunidadesModuloRequest(int idUsuario, int idPais) async {
  try {
    final respuesta = await http.post(Uri.parse(kApiUrl), body: {
      'action': "OBTENER_COMUNIDADES",
      'idUsuario': idUsuario.toString(),
      'idPais': idPais.toString(),
    });

    if (respuesta.statusCode == 200) {
      var respuestaDecodificada = jsonDecode(respuesta.body);
      if (respuestaDecodificada == 'usuario_inactivo') {
        return "usuario_inactivo";
      } else if (respuestaDecodificada == 'comunidades_vacias') {
        return "comunidades_vacias";
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
        .agregarComunidadModulo(ComunidadesModuloModelo(
      idPais: int.parse(datos[i]['idPais'].toString()),
      idComunidad: int.parse(datos[i]['idComunidad'].toString()),
      codaleaComunidad: datos[i]['codaleaComunidad'].toString(),
      idDepartamento: int.parse(datos[i]['idDepartamento'].toString()),
      idMunicipio: int.parse(datos[i]['idMunicipio'].toString()),
      nombreComunidad: datos[i]['nombreComunidad'].toString(),
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
