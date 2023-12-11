import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sat_m/constantes/colores_constantes.dart';
import 'package:sat_m/modelos/miembros_migrantes_modelo.dart';

Future<String> familiaMiembrosRequest(
    {required int idUsuario,
    required MiembrosMigrantesModelo modelo,
    required int idPais}) async {
  try {
    final respuesta = await http.post(Uri.parse(kApiUrl), body: {
      'action': "SATM_FAMILIAS_MIEMBROS",
      'pais': idPais.toString(),
      'idUsuario': idUsuario.toString(),
      'codalea_miembros': modelo.codaleaMiembros.toString(),
      'codalea_satfamilias': modelo.codaleaSatfamilias.toString(),
      'retornado': modelo.retornado.toString(),
      'temporalidad': modelo.temporalidad.toString(),
      'comunidad': modelo.comunidad.toString(),
      'nom_encuestado': modelo.nomEncuestado.toString(),
      'edad': modelo.edad.toString(),
      'genero': modelo.genero.toString(),
      'num_telefono': modelo.numTelefono.toString(),
      'idDepartamento': modelo.idDepartamento.toString(),
      'idMunicipio': modelo.idMunicipio.toString(),
      'nom_comunidad': modelo.nomComunidad.toString(),
      'nivel_educativo': modelo.nivelEducativo.toString(),
      'ocupacion': modelo.ocupacion.toString(),
      'estado_civil': modelo.estadoCivil.toString(),
      'p09': modelo.p09.toString(),
      'p09relacion': modelo.p09Relacion.toString(),
      'p10': modelo.p10.toString(),
      'p10otro': modelo.p10Otro.toString(),
      'p11': modelo.p11.toString(),
      'p11otro': modelo.p11Otro.toString(),
      'p12': modelo.p12.toString(),
      'p12numero': modelo.p12Numero.toString(),
      'p12relacion': modelo.p12Relacion.toString(),
      'p13': modelo.p13.toString(),
      'p13anio': modelo.p13Anio.toString(),
      'p13pais': modelo.p13Pais.toString(),
      'p14': modelo.p14.toString(),
      'p14descripcion': modelo.p14Descripcion.toString(),
      'p15': modelo.p15.toString(),
      'p15servicios': modelo.p15Servicios.toString(),
      'p16': modelo.p16.toString(),
      'p16razones': modelo.p16Razones.toString(),
      'fecha_creado': modelo.fechaCreado.toString()
    });

    if (respuesta.statusCode == 200) {
      var respuestaDecodificada = jsonDecode(respuesta.body);
      if (respuestaDecodificada == 'usuario_inactivo') {
        return "usuario_inactivo";
      } else if (respuestaDecodificada == 'error') {
        return "error";
      } else {
        return 'agrego_familia_miembro';
      }
    } else {
      return "error";
    }
  } catch (e) {
    return e.toString();
  }
}
