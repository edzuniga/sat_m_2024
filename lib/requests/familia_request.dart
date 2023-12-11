import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sat_m/constantes/colores_constantes.dart';
import 'package:sat_m/modelos/satm_familias_modelo.dart';

Future<String> familiasRequest(
    {required int idUsuario,
    required FamiliasModelo modelo,
    required int idPais}) async {
  try {
    final respuesta = await http.post(Uri.parse(kApiUrl), body: {
      'action': "SATM_FAMILIAS",
      'pais': idPais.toString(),
      'idUsuario': idUsuario.toString(),
      'codalea_satfamilias': modelo.codaleaSatfamilias.toString(),
      'inicio': modelo.start.toString(),
      'fin': modelo.end.toString(),
      'hoy': modelo.today.toString(),
      'idDepartamento': modelo.idDepartamento.toString(),
      'idMunicipio': modelo.idMunicipio.toString(),
      'comunidad': modelo.comunidad.toString(),
      'patrocinio': modelo.patrocinio.toString(),
      'nom_encuestado': modelo.nomEncuestado.toString(),
      'identidad': modelo.identidad.toString(),
      'edad': modelo.edad.toString(),
      'nacimiento': modelo.nacimiento.toString(),
      'sexo': modelo.sexo.toString(),
      'estudia': modelo.estudia.toString(),
      'educacion': modelo.educacion.toString(),
      'estado': modelo.estado.toString(),
      'tel_encuestado': modelo.telefonoEncuestado.toString(),
      'familias': modelo.familias.toString(),
      'miembros': modelo.miembros.toString(),
      'nina': modelo.nina.toString(),
      'nino': modelo.nino.toString(),
      'ambos_padres': modelo.ambosPadres.toString(),
      'nn_patrocinado': modelo.nnPatrocinado.toString(),
      'id_patrocinio': modelo.idPatrocinio.toString(),
      'p01': modelo.p01.toString(),
      'p02': modelo.p02.toString(),
      'p03': modelo.p03.toString(),
      'p04': modelo.p04.toString(),
      'p05': modelo.p05.toString(),
      'p06': modelo.p06.toString(),
      'p07': modelo.p07.toString(),
      'p08': modelo.p08.toString(),
      'p09': modelo.p09.toString(),
      'p10': modelo.p10.toString(),
      'p11': modelo.p11.toString(),
      'p12': modelo.p12.toString(),
      'p13': modelo.p13.toString(),
      'p14': modelo.p14.toString(),
      'p15': modelo.p15.toString(),
      'p16': modelo.p16.toString(),
      'p17': modelo.p17.toString(),
      'p18': modelo.p18.toString(),
      'p18b': modelo.p18B.toString(),
      'p19': modelo.p19.toString(),
      'p20': modelo.p20.toString(),
      'p21': modelo.p21.toString(),
      'p22': modelo.p22.toString(),
      'p23': modelo.p23.toString(),
      'p24': modelo.p24.toString(),
      'p27': modelo.p27.toString(),
      'p28': modelo.p28.toString(),
      'p29': modelo.p29.toString(),
      'p30': modelo.p30.toString(),
      'p31': modelo.p31.toString(),
      'p32': modelo.p32.toString(),
      'otro1': modelo.otro1.toString(),
      'p33': modelo.p33.toString(),
      'p34': modelo.p34.toString(),
      'p35': modelo.p35.toString(),
      'p36': modelo.p36.toString(),
      'p37': modelo.p37.toString(),
      'p38': modelo.p38.toString(),
      'p39': modelo.p39.toString(),
      'p40': modelo.p40.toString(),
      'p41': modelo.p41.toString(),
      'p42': modelo.p42.toString(),
      'p43': modelo.p43.toString(),
      'p44': modelo.p44.toString(),
      'p45': modelo.p45.toString(),
      'vivienda': modelo.vivienda.toString(),
      'p46': modelo.p46.toString(),
      'p47': modelo.p47.toString(),
      'p48': modelo.p48.toString(),
      'p49': modelo.p49.toString(),
      'p50': modelo.p50.toString(),
      'p51': modelo.p51.toString(),
      'ppi1': modelo.ppi1.toString(),
      'ppi2': modelo.ppi2.toString(),
      'ppi3': modelo.ppi3.toString(),
      'ppi4': modelo.ppi4.toString(),
      'ppi5': modelo.ppi5.toString(),
      'ppi6': modelo.ppi6.toString(),
      'ppi7': modelo.ppi7.toString(),
      'ppi8': modelo.ppi8.toString(),
      'ppi9': modelo.ppi9.toString(),
      'ppi10': modelo.ppi10.toString(),
      'ppi11': modelo.ppi11.toString(),
      'facilitador': modelo.facilitador.toString(),
      'tel_facilitador': modelo.telFacilitador.toString(),
      'fecha': modelo.fecha.toString(),
      'observaciones': modelo.observaciones.toString(),
      'lat': modelo.lat.toString(),
      'lon': modelo.lon.toString(),
      'alt': modelo.alt.toString(),
      'acc': modelo.acc.toString(),
      'fecha_creado': modelo.today.toString()
    });

    if (respuesta.statusCode == 200) {
      var respuestaDecodificada = jsonDecode(respuesta.body);
      if (respuestaDecodificada == 'usuario_inactivo') {
        return "usuario_inactivo";
      } else if (respuestaDecodificada == 'error') {
        return "error";
      } else {
        return 'agrego_familias';
      }
    } else {
      return "error";
    }
  } catch (e) {
    return e.toString();
  }
}
