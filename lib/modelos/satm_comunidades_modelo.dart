import 'dart:convert';

ComunidadesModelo comunidadesModeloFromJson(String str) =>
    ComunidadesModelo.fromJson(json.decode(str));

String comunidadesModeloToJson(ComunidadesModelo data) =>
    json.encode(data.toJson());

class ComunidadesModelo {
  int? id;
  String codaleaSatcomunidades;
  String start;
  String end;
  String today;
  int idPais;
  int idDepartamento;
  int idMunicipio;
  int comunidad;
  int acepta;
  String sign;
  String nomEncuestado;
  String telEncuestado;
  String identidad;
  int edad;
  int sexo;
  int educacion;
  int anoCursado;
  int estado;
  int nino;
  int ambosPadres;
  int nnPatrocinado;
  String idPatrocinio;
  int b1;
  int b2;
  int c1;
  int c2;
  int c3;
  int d1;
  int d2;
  int d3;
  int d4;
  int d9;
  int d5;
  int d6;
  int d7;
  int d8;
  int e1;
  int e2;
  String facilitador;
  int telFacilitador;
  String fecha;
  String observaciones;
  String lat;
  String lon;
  String alt;
  String acc;

  ComunidadesModelo({
    this.id,
    required this.codaleaSatcomunidades,
    required this.start,
    required this.end,
    required this.today,
    required this.idPais,
    required this.idDepartamento,
    required this.idMunicipio,
    required this.comunidad,
    required this.acepta,
    required this.sign,
    required this.nomEncuestado,
    required this.telEncuestado,
    required this.identidad,
    required this.edad,
    required this.sexo,
    required this.educacion,
    required this.anoCursado,
    required this.estado,
    required this.nino,
    required this.ambosPadres,
    required this.nnPatrocinado,
    required this.idPatrocinio,
    required this.b1,
    required this.b2,
    required this.c1,
    required this.c2,
    required this.c3,
    required this.d1,
    required this.d2,
    required this.d3,
    required this.d4,
    required this.d9,
    required this.d5,
    required this.d6,
    required this.d7,
    required this.d8,
    required this.e1,
    required this.e2,
    required this.facilitador,
    required this.telFacilitador,
    required this.fecha,
    required this.observaciones,
    required this.lat,
    required this.lon,
    required this.alt,
    required this.acc,
  });

  factory ComunidadesModelo.fromJson(Map<String, dynamic> json) =>
      ComunidadesModelo(
        id: json["id"],
        codaleaSatcomunidades: json["codalea_satcomunidades"],
        start: json["start"],
        end: json["end"],
        today: json["today"],
        idPais: json["idPais"],
        idDepartamento: json["idDepartamento"],
        idMunicipio: json["idMunicipio"],
        comunidad: json["comunidad"],
        acepta: json["acepta"],
        sign: json["sign"],
        nomEncuestado: json["nom_encuestado"],
        telEncuestado: json["tel_encuestado"],
        identidad: json["identidad"],
        edad: json["edad"],
        sexo: json["sexo"],
        educacion: json["educacion"],
        anoCursado: json["ano_cursado"],
        estado: json["estado"],
        nino: json["nino"],
        ambosPadres: json["ambos_padres"],
        nnPatrocinado: json["nn_patrocinado"],
        idPatrocinio: json["id_patrocinio"],
        b1: json["b1"],
        b2: json["b2"],
        c1: json["c1"],
        c2: json["c2"],
        c3: json["c3"],
        d1: json["d1"],
        d2: json["d2"],
        d3: json["d3"],
        d4: json["d4"],
        d9: json["d9"],
        d5: json["d5"],
        d6: json["d6"],
        d7: json["d7"],
        d8: json["d8"],
        e1: json["e1"],
        e2: json["e2"],
        facilitador: json["facilitador"],
        telFacilitador: json["tel_facilitador"],
        fecha: json["fecha"],
        observaciones: json["observaciones"],
        lat: json["lat"],
        lon: json["lon"],
        alt: json["alt"],
        acc: json["acc"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "codalea_satcomunidades": codaleaSatcomunidades,
        "start": start,
        "end": end,
        "today": today,
        "idPais": idPais,
        "idDepartamento": idDepartamento,
        "idMunicipio": idMunicipio,
        "comunidad": comunidad,
        "acepta": acepta,
        "sign": sign,
        "nom_encuestado": nomEncuestado,
        "tel_encuestado": telEncuestado,
        "identidad": identidad,
        "edad": edad,
        "sexo": sexo,
        "educacion": educacion,
        "ano_cursado": anoCursado,
        "estado": estado,
        "nino": nino,
        "ambos_padres": ambosPadres,
        "nn_patrocinado": nnPatrocinado,
        "id_patrocinio": idPatrocinio,
        "b1": b1,
        "b2": b2,
        "c1": c1,
        "c2": c2,
        "c3": c3,
        "d1": d1,
        "d2": d2,
        "d3": d3,
        "d4": d4,
        "d9": d9,
        "d5": d5,
        "d6": d6,
        "d7": d7,
        "d8": d8,
        "e1": e1,
        "e2": e2,
        "facilitador": facilitador,
        "tel_facilitador": telFacilitador,
        "fecha": fecha,
        "observaciones": observaciones,
        "lat": lat,
        "lon": lon,
        "alt": alt,
        "acc": acc,
      };
}
