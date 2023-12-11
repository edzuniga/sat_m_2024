import 'dart:convert';

RolesModelo rolesModeloFromJson(String str) =>
    RolesModelo.fromJson(json.decode(str));

String rolesModeloToJson(RolesModelo data) => json.encode(data.toJson());

class RolesModelo {
  int idRol;
  String rol;

  RolesModelo({
    required this.idRol,
    required this.rol,
  });

  factory RolesModelo.fromJson(Map<String, dynamic> json) => RolesModelo(
        idRol: json["idRol"],
        rol: json["rol"],
      );

  Map<String, dynamic> toJson() => {
        "idRol": idRol,
        "rol": rol,
      };
}
