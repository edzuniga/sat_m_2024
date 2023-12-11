import 'dart:convert';

DepartamentosModelo departamentosModeloFromJson(String str) =>
    DepartamentosModelo.fromJson(json.decode(str));

String departamentosModeloToJson(DepartamentosModelo data) =>
    json.encode(data.toJson());

class DepartamentosModelo {
  int idDepartamento;
  int idPais;
  String departamento;

  DepartamentosModelo({
    required this.idDepartamento,
    required this.idPais,
    required this.departamento,
  });

  factory DepartamentosModelo.fromJson(Map<String, dynamic> json) =>
      DepartamentosModelo(
        idDepartamento: json["idDepartamento"],
        idPais: json["idPais"],
        departamento: json["departamento"],
      );

  Map<String, dynamic> toJson() => {
        "idDepartamento": idDepartamento,
        "idPais": idPais,
        "departamento": departamento,
      };
}
