import 'dart:convert';

PreguntasModelo preguntasModeloFromJson(String str) =>
    PreguntasModelo.fromJson(json.decode(str));

String preguntasModeloToJson(PreguntasModelo data) =>
    json.encode(data.toJson());

class PreguntasModelo {
  int idPregunta;
  String codigoPregunta;
  String pregunta;

  PreguntasModelo({
    required this.idPregunta,
    required this.codigoPregunta,
    required this.pregunta,
  });

  factory PreguntasModelo.fromJson(Map<String, dynamic> json) =>
      PreguntasModelo(
        idPregunta: json["idPregunta"],
        codigoPregunta: json["codigo_pregunta"],
        pregunta: json["pregunta"],
      );

  Map<String, dynamic> toJson() => {
        "idPregunta": idPregunta,
        "codigo_pregunta": codigoPregunta,
        "pregunta": pregunta,
      };
}
