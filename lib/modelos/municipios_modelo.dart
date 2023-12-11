import 'dart:convert';

MunicipiosModelo municipiosModeloFromJson(String str) =>
    MunicipiosModelo.fromJson(json.decode(str));

String municipiosModeloToJson(MunicipiosModelo data) =>
    json.encode(data.toJson());

class MunicipiosModelo {
  int idMunicipio;
  int idPais;
  int idDepartamento;
  String municipio;

  MunicipiosModelo({
    required this.idMunicipio,
    required this.idPais,
    required this.idDepartamento,
    required this.municipio,
  });

  factory MunicipiosModelo.fromJson(Map<String, dynamic> json) =>
      MunicipiosModelo(
        idMunicipio: json["idMunicipio"],
        idPais: json["idPais"],
        idDepartamento: json["idDepartamento"],
        municipio: json["municipio"],
      );

  Map<String, dynamic> toJson() => {
        "idMunicipio": idMunicipio,
        "idPais": idPais,
        "idDepartamento": idDepartamento,
        "municipio": municipio,
      };
}
