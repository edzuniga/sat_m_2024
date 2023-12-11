import 'dart:convert';

PreguntasPonderacionesModelo preguntasPonderacionesModeloFromJson(String str) =>
    PreguntasPonderacionesModelo.fromJson(json.decode(str));

String preguntasPonderacionesModeloToJson(PreguntasPonderacionesModelo data) =>
    json.encode(data.toJson());

class PreguntasPonderacionesModelo {
  int idPonderacion;
  int idPregunta;
  String codigoPregunta;
  String opcionNombre;
  int opcionValor;
  String ponderacion;

  PreguntasPonderacionesModelo({
    required this.idPonderacion,
    required this.idPregunta,
    required this.codigoPregunta,
    required this.opcionNombre,
    required this.opcionValor,
    required this.ponderacion,
  });

  factory PreguntasPonderacionesModelo.fromJson(Map<String, dynamic> json) =>
      PreguntasPonderacionesModelo(
        idPonderacion: json["idPonderacion"],
        idPregunta: json["idPregunta"],
        codigoPregunta: json["codigo_pregunta"],
        opcionNombre: json["opcion_nombre"],
        opcionValor: json["opcion_valor"],
        ponderacion: json["ponderacion"],
      );

  Map<String, dynamic> toJson() => {
        "idPonderacion": idPonderacion,
        "idPregunta": idPregunta,
        "codigo_pregunta": codigoPregunta,
        "opcion_nombre": opcionNombre,
        "opcion_valor": opcionValor,
        "ponderacion": ponderacion,
      };
}
