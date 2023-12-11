import 'dart:convert';

MiembrosMigrantesModelo miembrosMigrantesModeloFromJson(String str) =>
    MiembrosMigrantesModelo.fromJson(json.decode(str));

String miembrosMigrantesModeloToJson(MiembrosMigrantesModelo data) =>
    json.encode(data.toJson());

class MiembrosMigrantesModelo {
  int? id;
  String codaleaMiembros;
  String codaleaSatfamilias;
  int retornado;
  int temporalidad;
  int comunidad;
  String nomEncuestado;
  int edad;
  int genero;
  String numTelefono;
  int idDepartamento;
  int idMunicipio;
  int nomComunidad;
  int nivelEducativo;
  String ocupacion;
  int estadoCivil;
  int p09;
  String p09Relacion;
  int p10;
  String p10Otro;
  int p11;
  String p11Otro;
  int p12;
  int p12Numero;
  String p12Relacion;
  int p13;
  int p13Anio;
  String p13Pais;
  int p14;
  String p14Descripcion;
  int p15;
  String p15Servicios;
  int p16;
  String p16Razones;
  String fechaCreado;
  int creadoPor;

  MiembrosMigrantesModelo({
    this.id,
    required this.codaleaMiembros,
    required this.codaleaSatfamilias,
    required this.retornado,
    required this.temporalidad,
    required this.comunidad,
    required this.nomEncuestado,
    required this.edad,
    required this.genero,
    required this.numTelefono,
    required this.idDepartamento,
    required this.idMunicipio,
    required this.nomComunidad,
    required this.nivelEducativo,
    required this.ocupacion,
    required this.estadoCivil,
    required this.p09,
    required this.p09Relacion,
    required this.p10,
    required this.p10Otro,
    required this.p11,
    required this.p11Otro,
    required this.p12,
    required this.p12Numero,
    required this.p12Relacion,
    required this.p13,
    required this.p13Anio,
    required this.p13Pais,
    required this.p14,
    required this.p14Descripcion,
    required this.p15,
    required this.p15Servicios,
    required this.p16,
    required this.p16Razones,
    required this.fechaCreado,
    required this.creadoPor,
  });

  factory MiembrosMigrantesModelo.fromJson(Map<String, dynamic> json) =>
      MiembrosMigrantesModelo(
        id: json["id"],
        codaleaMiembros: json["codalea_miembros"],
        codaleaSatfamilias: json["codalea_satfamilias"],
        retornado: json["retornado"],
        temporalidad: json["temporalidad"],
        comunidad: json["comunidad"],
        nomEncuestado: json["nom_encuestado"],
        edad: json["edad"],
        genero: json["genero"],
        numTelefono: json["num_telefono"],
        idDepartamento: json["idDepartamento"],
        idMunicipio: json["idMunicipio"],
        nomComunidad: json["nom_comunidad"],
        nivelEducativo: json["nivel_educativo"],
        ocupacion: json["ocupacion"],
        estadoCivil: json["estado_civil"],
        p09: json["p09"],
        p09Relacion: json["p09relacion"],
        p10: json["p10"],
        p10Otro: json["p10otro"],
        p11: json["p11"],
        p11Otro: json["p11otro"],
        p12: json["p12"],
        p12Numero: json["p12numero"],
        p12Relacion: json["p12relacion"],
        p13: json["p13"],
        p13Anio: json["p13anio"],
        p13Pais: json["p13pais"],
        p14: json["p14"],
        p14Descripcion: json["p14descripcion"],
        p15: json["p15"],
        p15Servicios: json["p15servicios"],
        p16: json["p16"],
        p16Razones: json["p16razones"],
        fechaCreado: json["fecha_creado"],
        creadoPor: json["creado_por"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "codalea_miembros": codaleaMiembros,
        "codalea_satfamilias": codaleaSatfamilias,
        "retornado": retornado,
        "temporalidad": temporalidad,
        "comunidad": comunidad,
        "nom_encuestado": nomEncuestado,
        "edad": edad,
        "genero": genero,
        "num_telefono": numTelefono,
        "idDepartamento": idDepartamento,
        "idMunicipio": idMunicipio,
        "nom_comunidad": nomComunidad,
        "nivel_educativo": nivelEducativo,
        "ocupacion": ocupacion,
        "estado_civil": estadoCivil,
        "p09": p09,
        "p09relacion": p09Relacion,
        "p10": p10,
        "p10otro": p10Otro,
        "p11": p11,
        "p11otro": p11Otro,
        "p12": p12,
        "p12numero": p12Numero,
        "p12relacion": p12Relacion,
        "p13": p13,
        "p13anio": p13Anio,
        "p13pais": p13Pais,
        "p14": p14,
        "p14descripcion": p14Descripcion,
        "p15": p15,
        "p15servicios": p15Servicios,
        "p16": p16,
        "p16razones": p16Razones,
        "fecha_creado": fechaCreado,
        "creado_por": creadoPor,
      };
}
