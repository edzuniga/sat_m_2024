import 'package:http/http.dart' as http;
import 'package:sat_m/bd/bd.dart';
import 'dart:convert';

import 'package:sat_m/constantes/colores_constantes.dart';
import 'package:sat_m/modelos/usuarios_modelo.dart';

Future<String> loginRequest(String correo, String contra) async {
  try {
    final respuesta = await http.post(Uri.parse(kApiUrl), body: {
      'action': "LOGIN",
      'correoUsuario': correo,
      'contrasena': contra
    });

    if (respuesta.statusCode == 200) {
      var respuestaDecodificada = jsonDecode(respuesta.body);
      if (respuestaDecodificada == 'usuario_inactivo') {
        return "usuario_inactivo";
      } else if (respuestaDecodificada == 'credenciales_incorrectas') {
        return "credenciales_incorrectas";
      } else if (respuestaDecodificada == 'error') {
        return "error";
      } else {
        //Grabar row en la base de datos interna (usuarios)
        var grabarResponse =
            await DatabaseSatM.instance.agregarUsuarios(UsuariosModelo(
          id: int.parse(respuestaDecodificada[0]['id'].toString()),
          codaleaUsuario:
              respuestaDecodificada[0]['codalea_usuario'].toString(),
          nombres: respuestaDecodificada[0]['nombres'].toString(),
          apellidos: respuestaDecodificada[0]['apellidos'].toString(),
          correo: respuestaDecodificada[0]['correo'].toString(),
          idPais: int.parse(respuestaDecodificada[0]['idPais'].toString()),
          telFacilitador:
              respuestaDecodificada[0]['tel_facilitador'].toString(),
          idRol: int.parse(respuestaDecodificada[0]['idRol'].toString()),
          formFam: int.parse(respuestaDecodificada[0]['form_fam'].toString()),
          formComu: int.parse(respuestaDecodificada[0]['form_comu'].toString()),
        ));
        if (grabarResponse != 0) {
          return "usuario_encontrado";
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
