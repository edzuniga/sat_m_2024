import 'dart:convert';

PaisesModelo paisesModeloFromJson(String str) =>
    PaisesModelo.fromJson(json.decode(str));

String paisesModeloToJson(PaisesModelo data) => json.encode(data.toJson());

class PaisesModelo {
  int idPais;
  String pais;
  String moneda;
  String simbolo;
  int digitosDni;

  PaisesModelo({
    required this.idPais,
    required this.pais,
    required this.moneda,
    required this.simbolo,
    required this.digitosDni,
  });

  factory PaisesModelo.fromJson(Map<String, dynamic> json) => PaisesModelo(
        idPais: json["idPais"],
        pais: json["pais"],
        moneda: json["moneda"],
        simbolo: json["simbolo"],
        digitosDni: json["digitosDNI"],
      );

  Map<String, dynamic> toJson() => {
        "idPais": idPais,
        "pais": pais,
        "moneda": moneda,
        "simbolo": simbolo,
        "digitosDNI": digitosDni,
      };
}
