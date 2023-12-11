import 'dart:convert';

RangosModelo rangosModeloFromJson(String str) =>
    RangosModelo.fromJson(json.decode(str));

String rangosModeloToJson(RangosModelo data) => json.encode(data.toJson());

class RangosModelo {
  int idPais;
  String rango44Opt1;
  String rango44Opt2;
  String rango44Opt3;
  String rango44Opt4;
  String rango44Opt5;

  RangosModelo({
    required this.idPais,
    required this.rango44Opt1,
    required this.rango44Opt2,
    required this.rango44Opt3,
    required this.rango44Opt4,
    required this.rango44Opt5,
  });

  factory RangosModelo.fromJson(Map<String, dynamic> json) => RangosModelo(
        idPais: json["idPais"],
        rango44Opt1: json["rango44_opt1"],
        rango44Opt2: json["rango44_opt2"],
        rango44Opt3: json["rango44_opt3"],
        rango44Opt4: json["rango44_opt4"],
        rango44Opt5: json["rango44_opt5"],
      );

  Map<String, dynamic> toJson() => {
        "idPais": idPais,
        "rango44_opt1": rango44Opt1,
        "rango44_opt2": rango44Opt2,
        "rango44_opt3": rango44Opt3,
        "rango44_opt4": rango44Opt4,
        "rango44_opt5": rango44Opt5,
      };
}
