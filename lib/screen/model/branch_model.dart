// To parse this JSON data, do
//
//     final branchModel = branchModelFromJson(jsonString);

import 'dart:convert';

BranchModel? branchModelFromJson(String str) =>
    BranchModel.fromJson(json.decode(str));

String branchModelToJson(BranchModel? data) => json.encode(data!.toJson());

class BranchModel {
  BranchModel({
    required this.topBranch,
  });

  List<TopBranch> topBranch;

  factory BranchModel.fromJson(Map<String, dynamic> json) => BranchModel(
        topBranch: json["top_branch"] == null
            ? []
            : List<TopBranch>.from(
                json["top_branch"]!.map((x) => TopBranch.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "top_branch": topBranch == null
            ? []
            : List<dynamic>.from(topBranch.map((x) => x.toJson())),
      };
}

class TopBranch {
  TopBranch({
    this.id,
    this.branchName,
    this.branchLogo,
    this.branchPhone,
    this.branchStatus,
    this.branchProvince,
    this.branchDistrict,
    this.branchVillage,
    this.branchMoney,
    this.branchQrcode,
    this.bceloneNumber,
  });

  int? id;
  String? branchName;
  String? branchLogo;
  int? branchPhone;
  int? branchStatus;
  String? branchProvince;
  String? branchDistrict;
  String? branchVillage;
  int? branchMoney;
  String? branchQrcode;
  int? bceloneNumber;

  factory TopBranch.fromJson(Map<String, dynamic> json) => TopBranch(
        id: json["id"],
        branchName: json["branch_name"],
        branchLogo: json["branch_logo"],
        branchPhone: json["branch_phone"],
        branchStatus: json["branch_status"],
        branchProvince: json["branch_province"],
        branchDistrict: json["branch_district"],
        branchVillage: json["branch_village"],
        branchMoney: json["branch_money"],
        branchQrcode: json["branch_qrcode"],
        bceloneNumber: json["bcelone_number"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "branch_name": branchName,
        "branch_logo": branchLogo,
        "branch_phone": branchPhone,
        "branch_status": branchStatus,
        "branch_province": branchProvince,
        "branch_district": branchDistrict,
        "branch_village": branchVillage,
        "branch_money": branchMoney,
        "branch_qrcode": branchQrcode,
        "bcelone_number": bceloneNumber,
      };
}
