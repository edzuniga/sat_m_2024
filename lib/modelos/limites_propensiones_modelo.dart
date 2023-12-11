import 'dart:convert';

LimitesPropensionesModelo limitesPropensionesModeloFromJson(String str) =>
    LimitesPropensionesModelo.fromJson(json.decode(str));

String limitesPropensionesModeloToJson(LimitesPropensionesModelo data) =>
    json.encode(data.toJson());

class LimitesPropensionesModelo {
  int? idPropension;
  String codaleaPropension;
  double limiteInf;
  double limiteSup;

  LimitesPropensionesModelo({
    this.idPropension,
    required this.codaleaPropension,
    required this.limiteInf,
    required this.limiteSup,
  });

  factory LimitesPropensionesModelo.fromJson(Map<String, dynamic> json) =>
      LimitesPropensionesModelo(
        idPropension: json["idPropension"],
        codaleaPropension: json["codaleaPropension"],
        limiteInf: json["limite_inf"]?.toDouble(),
        limiteSup: json["limite_sup"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "idPropension": idPropension,
        "codaleaPropension": codaleaPropension,
        "limite_inf": limiteInf,
        "limite_sup": limiteSup,
      };
}
