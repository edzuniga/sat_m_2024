import 'dart:convert';

PropensionesModelo propensionesModeloFromJson(String str) =>
    PropensionesModelo.fromJson(json.decode(str));

String propensionesModeloToJson(PropensionesModelo data) =>
    json.encode(data.toJson());

class PropensionesModelo {
  int idPropension;
  String propension;
  String valorMinimo;
  String valorMaximo;

  PropensionesModelo({
    required this.idPropension,
    required this.propension,
    required this.valorMinimo,
    required this.valorMaximo,
  });

  factory PropensionesModelo.fromJson(Map<String, dynamic> json) =>
      PropensionesModelo(
        idPropension: json["idPropension"],
        propension: json["propension"],
        valorMinimo: json["valor_minimo"],
        valorMaximo: json["valor_maximo"],
      );

  Map<String, dynamic> toJson() => {
        "idPropension": idPropension,
        "propension": propension,
        "valor_minimo": valorMinimo,
        "valor_maximo": valorMaximo,
      };
}
