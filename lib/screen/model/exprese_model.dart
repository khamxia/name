// To parse this JSON data, do
//
//     final expreseModel = expreseModelFromJson(jsonString);

import 'dart:convert';

ExpreseModel expreseModelFromJson(String str) =>
    ExpreseModel.fromJson(json.decode(str));

String expreseModelToJson(ExpreseModel? data) => json.encode(data!.toJson());

class ExpreseModel {
  ExpreseModel({
    required this.exprese,
  });

  List<Exprese> exprese;

  factory ExpreseModel.fromJson(Map<String, dynamic> json) => ExpreseModel(
        exprese: json["exprese"] == null
            ? []
            : List<Exprese>.from(
                json["exprese"]!.map((x) => Exprese.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "exprese": exprese == null
            ? []
            : List<dynamic>.from(exprese.map((x) => x.toJson())),
      };
}

class Exprese {
  Exprese({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory Exprese.fromJson(Map<String, dynamic> json) => Exprese(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
