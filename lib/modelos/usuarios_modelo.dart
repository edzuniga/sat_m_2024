import 'dart:convert';

UsuariosModelo usuariosModeloFromJson(String str) =>
    UsuariosModelo.fromJson(json.decode(str));

String usuariosModeloToJson(UsuariosModelo data) => json.encode(data.toJson());

class UsuariosModelo {
  int? id;
  String codaleaUsuario;
  String nombres;
  String apellidos;
  String correo;
  String? contra;
  int idPais;
  String? foto;
  String telFacilitador;
  int idRol;
  int? activo;
  String? fechaCreado;
  int? creadoPor;
  String? fechaModi;
  int? modificadoPor;
  int formFam;
  int formComu;

  UsuariosModelo({
    this.id,
    required this.codaleaUsuario,
    required this.nombres,
    required this.apellidos,
    required this.correo,
    this.contra,
    required this.idPais,
    this.foto,
    required this.telFacilitador,
    required this.idRol,
    this.activo,
    this.fechaCreado,
    this.creadoPor,
    this.fechaModi,
    this.modificadoPor,
    required this.formFam,
    required this.formComu,
  });

  factory UsuariosModelo.fromJson(Map<String, dynamic> json) => UsuariosModelo(
        id: json["id"],
        codaleaUsuario: json["codalea_usuario"],
        nombres: json["nombres"],
        apellidos: json["apellidos"],
        correo: json["correo"],
        contra: json["contra"],
        idPais: json["idPais"],
        foto: json["foto"],
        telFacilitador: json["tel_facilitador"],
        idRol: json["idRol"],
        activo: json["activo"],
        fechaCreado: json["fecha_creado"],
        creadoPor: json["creado_por"],
        fechaModi: json["fecha_modi"],
        modificadoPor: json["modificado_por"],
        formFam: json["form_fam"],
        formComu: json["form_comu"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "codalea_usuario": codaleaUsuario,
        "nombres": nombres,
        "apellidos": apellidos,
        "correo": correo,
        "contra": contra,
        "idPais": idPais,
        "foto": foto,
        "tel_facilitador": telFacilitador,
        "idRol": idRol,
        "activo": activo,
        "fecha_creado": fechaCreado,
        "creado_por": creadoPor,
        "fecha_modi": fechaModi,
        "modificado_por": modificadoPor,
        "form_fam": formFam,
        "form_comu": formComu,
      };
}
