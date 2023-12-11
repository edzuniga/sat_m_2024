import 'package:http/http.dart' as http;
import 'package:sat_m/bd/bd.dart';
import 'dart:convert';

import 'package:sat_m/constantes/colores_constantes.dart';
import 'package:sat_m/modelos/ingresos_opciones_modelo.dart';

Future<String> opcionesIngresosRequest(int idUsuario) async {
  try {
    final respuesta = await http.post(Uri.parse(kApiUrl), body: {
      'action': "OBTENER_OPCIONES_INGRESOS",
      'idUsuario': idUsuario.toString()
    });

    if (respuesta.statusCode == 200) {
      var respuestaDecodificada = jsonDecode(respuesta.body);
      if (respuestaDecodificada == 'usuario_inactivo') {
        return "usuario_inactivo";
      } else if (respuestaDecodificada == 'opciones_ingresos_vacios') {
        return "opciones_ingresos_vacios";
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
    int grabarEnBD = await DatabaseSatM.instance
        .agregarOpcionesIngresos(IngresosOpcionesModelo(
      idPais: int.parse(datos[i]['idPais'].toString()),
      ingresoOpt1: datos[i]['ingreso_opt1'].toString(),
      ingresoOpt2: datos[i]['ingreso_opt2'].toString(),
      ingresoOpt3: datos[i]['ingreso_opt3'].toString(),
      ingresoOpt4: datos[i]['ingreso_opt4'].toString(),
      ingresoOpt5: datos[i]['ingreso_opt5'].toString(),
      ingresoOpt6: datos[i]['ingreso_opt6'].toString(),
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
