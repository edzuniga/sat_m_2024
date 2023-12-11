import 'dart:convert';

FamiliasMiembrosModelo familiasMiembrosModeloFromJson(String str) =>
    FamiliasMiembrosModelo.fromJson(json.decode(str));

String familiasMiembrosModeloToJson(FamiliasMiembrosModelo data) =>
    json.encode(data.toJson());

class FamiliasMiembrosModelo {
  int? id;
  String codaleaMiembros;
  String codaleaSatfamilias;
  int edadMigrante;
  int sexoMigrante;
  int tiempoMigrante;
  int miembroMigrante;
  int? p26;

  FamiliasMiembrosModelo({
    this.id,
    required this.codaleaMiembros,
    required this.codaleaSatfamilias,
    required this.edadMigrante,
    required this.sexoMigrante,
    required this.tiempoMigrante,
    required this.miembroMigrante,
    this.p26,
  });

  factory FamiliasMiembrosModelo.fromJson(Map<String, dynamic> json) =>
      FamiliasMiembrosModelo(
        id: json["id"],
        codaleaMiembros: json["codalea_miembros"],
        codaleaSatfamilias: json["codalea_satfamilias"],
        edadMigrante: json["edad_migrante"],
        sexoMigrante: json["sexo_migrante"],
        tiempoMigrante: json["tiempo_migrante"],
        miembroMigrante: json["miembro_migrante"],
        p26: json["p26"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "codalea_miembros": codaleaMiembros,
        "codalea_satfamilias": codaleaSatfamilias,
        "edad_migrante": edadMigrante,
        "sexo_migrante": sexoMigrante,
        "tiempo_migrante": tiempoMigrante,
        "miembro_migrante": miembroMigrante,
        "p26": p26,
      };
}
