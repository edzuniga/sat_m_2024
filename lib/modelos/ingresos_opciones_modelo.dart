import 'dart:convert';

IngresosOpcionesModelo ingresosOpcionesModeloFromJson(String str) =>
    IngresosOpcionesModelo.fromJson(json.decode(str));

String ingresosOpcionesModeloToJson(IngresosOpcionesModelo data) =>
    json.encode(data.toJson());

class IngresosOpcionesModelo {
  int idPais;
  String ingresoOpt1;
  String ingresoOpt2;
  String ingresoOpt3;
  String ingresoOpt4;
  String ingresoOpt5;
  String ingresoOpt6;

  IngresosOpcionesModelo({
    required this.idPais,
    required this.ingresoOpt1,
    required this.ingresoOpt2,
    required this.ingresoOpt3,
    required this.ingresoOpt4,
    required this.ingresoOpt5,
    required this.ingresoOpt6,
  });

  factory IngresosOpcionesModelo.fromJson(Map<String, dynamic> json) =>
      IngresosOpcionesModelo(
        idPais: json["idPais"],
        ingresoOpt1: json["ingreso_opt1"],
        ingresoOpt2: json["ingreso_opt2"],
        ingresoOpt3: json["ingreso_opt3"],
        ingresoOpt4: json["ingreso_opt4"],
        ingresoOpt5: json["ingreso_opt5"],
        ingresoOpt6: json["ingreso_opt6"],
      );

  Map<String, dynamic> toJson() => {
        "idPais": idPais,
        "ingreso_opt1": ingresoOpt1,
        "ingreso_opt2": ingresoOpt2,
        "ingreso_opt3": ingresoOpt3,
        "ingreso_opt4": ingresoOpt4,
        "ingreso_opt5": ingresoOpt5,
        "ingreso_opt6": ingresoOpt6,
      };
}
