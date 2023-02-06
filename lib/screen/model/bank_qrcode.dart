// To parse this JSON data, do
//
//     final bankRqCodeModel = bankRqCodeModelFromJson(jsonString);

import 'dart:convert';

BankRqCodeModel? bankRqCodeModelFromJson(String str) =>
    BankRqCodeModel.fromJson(json.decode(str));

String bankRqCodeModelToJson(BankRqCodeModel? data) =>
    json.encode(data!.toJson());

class BankRqCodeModel {
  BankRqCodeModel({
    this.branchPayment,
  });

  BranchPayment? branchPayment;

  factory BankRqCodeModel.fromJson(Map<String, dynamic> json) =>
      BankRqCodeModel(
        branchPayment: BranchPayment.fromJson(json["branch_payment"]),
      );

  Map<String, dynamic> toJson() => {
        "branch_payment": branchPayment!.toJson(),
      };
}

class BranchPayment {
  BranchPayment({
    this.id,
    this.bceloneNumber,
    this.branchQrcode,
  });

  int? id;
  int? bceloneNumber;
  String? branchQrcode;

  factory BranchPayment.fromJson(Map<String, dynamic> json) => BranchPayment(
        id: json["id"],
        bceloneNumber: json["bcelone_number"],
        branchQrcode: json["branch_qrcode"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "bcelone_number": bceloneNumber,
        "branch_qrcode": branchQrcode,
      };
}
