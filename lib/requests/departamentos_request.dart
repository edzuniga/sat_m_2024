import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sat_m/bd/bd.dart';
import 'package:sat_m/constantes/colores_constantes.dart';
import 'package:sat_m/modelos/departamentos_modelo.dart';

Future<String> departamentosRequest(int idUsuario) async {
  try {
    final respuesta = await http.post(Uri.parse(kApiUrl), body: {
      'action': "OBTENER_DEPARTAMENTOS",
      'idUsuario': idUsuario.toString()
    });

    if (respuesta.statusCode == 200) {
      var respuestaDecodificada = jsonDecode(respuesta.body);
      if (respuestaDecodificada == 'usuario_inactivo') {
        return "usuario_inactivo";
      } else if (respuestaDecodificada == 'departamentos_vacios') {
        return "departamentos_vacios";
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
    int grabarEnBD =
        await DatabaseSatM.instance.agregarDepartamentos(DepartamentosModelo(
      idDepartamento: int.parse(datos[i]['idDepartamento'].toString()),
      idPais: int.parse(datos[i]['idPais'].toString()),
      departamento: datos[i]['departamento'].toString(),
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
