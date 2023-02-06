// To parse this JSON data, do
//
//     final memberModel = memberModelFromJson(jsonString);

import 'dart:convert';

AddressModel addressModelFromJson(String str) =>
    AddressModel.fromJson(json.decode(str));

String addressModelToJson(AddressModel data) => json.encode(data.toJson());

class AddressModel {
  AddressModel({
    required this.province,
  });

  List<Province> province;

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        province: List<Province>.from(
            json["province"].map((x) => Province.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "province": List<dynamic>.from(province.map((x) => x.toJson())),
      };
}

class Province {
  Province({
    required this.prId,
    required this.prName,
    required this.districts,
  });

  int prId;
  String prName;
  List<District> districts;

  factory Province.fromJson(Map<String, dynamic> json) => Province(
        prId: json["pr_id"],
        prName: json["pr_name"],
        districts: List<District>.from(
            json["districts"].map((x) => District.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "pr_id": prId,
        "pr_name": prName,
        "districts": List<dynamic>.from(districts.map((x) => x.toJson())),
      };
}

class District {
  District({
    required this.prId,
    required this.drId,
    required this.drName,
    required this.villages,
  });

  int prId;
  int drId;
  String drName;
  List<Village> villages;

  factory District.fromJson(Map<String, dynamic> json) => District(
        prId: json["pr_id"],
        drId: json["dr_id"],
        drName: json["dr_name"],
        villages: List<Village>.from(
            json["villages"].map((x) => Village.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "pr_id": prId,
        "dr_id": drId,
        "dr_name": drName,
        "villages": List<dynamic>.from(villages.map((x) => x.toJson())),
      };
}

class Village {
  Village({
    required this.drId,
    required this.villId,
    required this.villName,
  });

  int drId;
  int villId;
  String villName;

  factory Village.fromJson(Map<String, dynamic> json) => Village(
        drId: json["dr_id"],
        villId: json["vill_id"],
        villName: json["vill_name"],
      );

  Map<String, dynamic> toJson() => {
        "dr_id": drId,
        "vill_id": villId,
        "vill_name": villName,
      };
}
