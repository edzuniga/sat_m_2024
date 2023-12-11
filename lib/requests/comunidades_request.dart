import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sat_m/constantes/colores_constantes.dart';
import 'package:sat_m/modelos/satm_comunidades_modelo.dart';

Future<String> comunidadesRequest(
    {required int idUsuario,
    required ComunidadesModelo modelo,
    required int idPais}) async {
  //----------- CARGA DE ARCHIVO -------------------//
  var requestArchivo =
      http.MultipartRequest('POST', Uri.parse(urlCargarArchivos));

  var archi =
      await http.MultipartFile.fromPath("archivo", modelo.sign.toString());
  requestArchivo.files.add(archi);

  http.Response respuesta =
      await http.Response.fromStream(await requestArchivo.send());

  if (respuesta.statusCode == 200) {
    final replica = jsonDecode(respuesta.body);

    //Si lo cargó hace la sincronización de la info.
    if (replica[0] == 'archivo_cargado') {
      var sincronizar = await sincronizarBoleta(
        idPais: idPais,
        idUsuario: idUsuario,
        modelo: modelo,
        firma: replica[1],
      );
      if (sincronizar == 'usuario_inactivo') {
        return "usuario_inactivo";
      } else if (sincronizar == 'error') {
        return "error";
      } else {
        return 'agrego_comunidades';
      }
    } else {
      return 'no_cargo_archivo';
    }
  } else {
    return 'error_conexion';
  }
}

Future<String> sincronizarBoleta({
  required int idUsuario,
  required ComunidadesModelo modelo,
  required int idPais,
  required String firma,
}) async {
  try {
    final respuestaSincronizar = await http.post(Uri.parse(kApiUrl), body: {
      'action': "SATM_COMUNIDADES",
      'pais': idPais.toString(),
      'idUsuario': idUsuario.toString(),
      'codalea_satcomunidades': modelo.codaleaSatcomunidades.toString(),
      'inicio': modelo.start.toString(),
      'fin': modelo.end.toString(),
      'hoy': modelo.today.toString(),
      'idDepartamento': modelo.idDepartamento.toString(),
      'idMunicipio': modelo.idMunicipio.toString(),
      'comunidad': modelo.comunidad.toString(),
      'acepta': modelo.acepta.toString(),
      'sign': firma.toString(),
      'nom_encuestado': modelo.nomEncuestado.toString(),
      'tel_encuestado': modelo.telEncuestado.toString(),
      'identidad': modelo.identidad.toString(),
      'edad': modelo.edad.toString(),
      'sexo': modelo.sexo.toString(),
      'educacion': modelo.educacion.toString(),
      'ano_cursado': modelo.anoCursado.toString(),
      'estado': modelo.estado.toString(),
      'nino': modelo.nino.toString(),
      'ambos_padres': modelo.ambosPadres.toString(),
      'nn_patrocinado': modelo.nnPatrocinado.toString(),
      'id_patrocinio': modelo.idPatrocinio.toLowerCase(),
      'b1': modelo.b1.toString(),
      'b2': modelo.b2.toString(),
      'c1': modelo.c1.toString(),
      'c2': modelo.c2.toString(),
      'c3': modelo.c3.toString(),
      'd1': modelo.d1.toString(),
      'd2': modelo.d2.toString(),
      'd3': modelo.d3.toString(),
      'd4': modelo.d4.toString(),
      'd9': modelo.d9.toString(),
      'd5': modelo.d5.toString(),
      'd6': modelo.d6.toString(),
      'd7': modelo.d7.toString(),
      'd8': modelo.d8.toString(),
      'e1': modelo.e1.toString(),
      'e2': modelo.e2.toString(),
      'facilitador': modelo.facilitador.toString(),
      'tel_facilitador': modelo.telFacilitador.toString(),
      'fecha': modelo.fecha.toString(),
      'observaciones': modelo.observaciones.toString(),
      'lat': modelo.lat.toString(),
      'lon': modelo.lon.toString(),
      'alt': modelo.alt.toString(),
      'acc': modelo.acc.toString(),
      'fecha_creado': modelo.today.toString(),
    });

    if (respuestaSincronizar.statusCode == 200) {
      var respuestaDecodificada = jsonDecode(respuestaSincronizar.body);
      if (respuestaDecodificada == 'usuario_inactivo') {
        return "usuario_inactivo";
      } else if (respuestaDecodificada == 'error') {
        return "error";
      } else {
        return 'agrego_comunidades';
      }
    } else {
      return "error";
    }
  } catch (e) {
    return e.toString();
  }
}
