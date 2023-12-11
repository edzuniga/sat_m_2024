import 'dart:convert';

ComunidadesModuloModelo comunidadesModuloModeloFromJson(String str) =>
    ComunidadesModuloModelo.fromJson(json.decode(str));

String comunidadesModuloModeloToJson(ComunidadesModuloModelo data) =>
    json.encode(data.toJson());

class ComunidadesModuloModelo {
  int idPais;
  int idComunidad;
  String codaleaComunidad;
  int idDepartamento;
  int idMunicipio;
  String nombreComunidad;

  ComunidadesModuloModelo({
    required this.idPais,
    required this.idComunidad,
    required this.codaleaComunidad,
    required this.idDepartamento,
    required this.idMunicipio,
    required this.nombreComunidad,
  });

  factory ComunidadesModuloModelo.fromJson(Map<String, dynamic> json) =>
      ComunidadesModuloModelo(
        idPais: json["idPais"],
        idComunidad: json["idComunidad"],
        codaleaComunidad: json["codaleaComunidad"],
        idDepartamento: json["idDepartamento"],
        idMunicipio: json["idMunicipio"],
        nombreComunidad: json["nombreComunidad"],
      );

  Map<String, dynamic> toJson() => {
        "idPais": idPais,
        "idComunidad": idComunidad,
        "codaleaComunidad": codaleaComunidad,
        "idDepartamento": idDepartamento,
        "idMunicipio": idMunicipio,
        "nombreComunidad": nombreComunidad,
      };
}
