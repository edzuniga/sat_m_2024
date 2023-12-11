import 'dart:convert';

OnBoardingModelo onBoardingModeloFromJson(String str) =>
    OnBoardingModelo.fromJson(json.decode(str));

String onBoardingModeloToJson(OnBoardingModelo data) =>
    json.encode(data.toJson());

class OnBoardingModelo {
  int? id;
  int activo;

  OnBoardingModelo({
    this.id,
    required this.activo,
  });

  factory OnBoardingModelo.fromJson(Map<String, dynamic> json) =>
      OnBoardingModelo(
        id: json["id"],
        activo: json["activo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "activo": activo,
      };
}
