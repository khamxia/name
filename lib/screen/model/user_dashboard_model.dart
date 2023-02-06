// To parse this JSON data, do
//
//     final userDashBoardModel = userDashBoardModelFromJson(jsonString);

import 'dart:convert';

UserDashBoardModel? userDashBoardModelFromJson(String str) =>
    UserDashBoardModel.fromJson(json.decode(str));

String userDashBoardModelToJson(UserDashBoardModel? data) =>
    json.encode(data!.toJson());

class UserDashBoardModel {
  UserDashBoardModel({
    required this.userProfile,
    required this.userMoney,
    required this.userBranch,
  });

  List<UserProfile> userProfile;
  List<UserMoney> userMoney;
  List<UserBranch> userBranch;

  factory UserDashBoardModel.fromJson(Map<String, dynamic> json) =>
      UserDashBoardModel(
        userProfile: json["user_profile"] == null
            ? []
            : List<UserProfile>.from(
                json["user_profile"]!.map((x) => UserProfile.fromJson(x))),
        userMoney: json["user_money"] == null
            ? []
            : List<UserMoney>.from(
                json["user_money"]!.map((x) => UserMoney.fromJson(x))),
        userBranch: json["user_branch"] == null
            ? []
            : List<UserBranch>.from(
                json["user_branch"]!.map((x) => UserBranch.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "user_profile": userProfile == null
            ? []
            : List<dynamic>.from(userProfile.map((x) => x.toJson())),
        "user_money": userMoney == null
            ? []
            : List<dynamic>.from(userMoney.map((x) => x.toJson())),
        "user_branch": userBranch == null
            ? []
            : List<dynamic>.from(userBranch.map((x) => x.toJson())),
      };
}

class UserBranch {
  UserBranch({
    this.id,
    this.branchName,
    this.branchLogo,
    this.branchQrcode,
    this.bceloneNumber,
    this.branchStatus,
    this.branchProvince,
    this.branchDistrict,
    this.branchVillage,
    this.branchProduct,
    this.branchProductInstock,
    this.branchOrderPending,
    this.branchOrderSuccess,
  });

  int? id;
  String? branchName;
  String? branchLogo;
  String? branchQrcode;
  int? bceloneNumber;
  int? branchStatus;
  String? branchProvince;
  String? branchDistrict;
  String? branchVillage;
  int? branchProduct;
  String? branchProductInstock;
  int? branchOrderPending;
  int? branchOrderSuccess;

  factory UserBranch.fromJson(Map<String, dynamic> json) => UserBranch(
        id: json["id"],
        branchName: json["branch_name"],
        branchLogo: json["branch_logo"],
        branchQrcode: json["branch_qrcode"],
        bceloneNumber: json["bcelone_number"],
        branchStatus: json["branch_status"],
        branchProvince: json["branch_province"],
        branchDistrict: json["branch_district"],
        branchVillage: json["branch_village"],
        branchProduct: json["branch_product"],
        branchProductInstock: json["branch_product_instock"],
        branchOrderPending: json["branch_order_pending"],
        branchOrderSuccess: json["branch_order_success"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "branch_name": branchName,
        "branch_logo": branchLogo,
        "branch_qrcode": branchQrcode,
        "bcelone_number": bceloneNumber,
        "branch_status": branchStatus,
        "branch_province": branchProvince,
        "branch_district": branchDistrict,
        "branch_village": branchVillage,
        "branch_product": branchProduct,
        "branch_product_instock": branchProductInstock,
        "branch_order_pending": branchOrderPending,
        "branch_order_success": branchOrderSuccess,
      };
}

class UserMoney {
  UserMoney({
    this.moneyBuy,
    this.moneySale,
  });

  int? moneyBuy;
  int? moneySale;

  factory UserMoney.fromJson(Map<String, dynamic> json) => UserMoney(
        moneyBuy: json["money_buy"],
        moneySale: json["money_sale"],
      );

  Map<String, dynamic> toJson() => {
        "money_buy": moneyBuy,
        "money_sale": moneySale,
      };
}

class UserProfile {
  UserProfile({
    this.id,
    this.name,
    this.lastName,
    this.phone,
    this.menberId,
    this.profileImage,
    this.prName,
    this.drName,
    this.villName,
  });

  int? id;
  String? name;
  String? lastName;
  int? phone;
  int? menberId;
  String? profileImage;
  String? prName;
  String? drName;
  String? villName;

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        id: json["id"],
        name: json["name"],
        lastName: json["last_name"],
        phone: json["phone"],
        menberId: json["menber_id"],
        profileImage: json["profile_image"],
        prName: json["pr_name"],
        drName: json["dr_name"],
        villName: json["vill_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "last_name": lastName,
        "phone": phone,
        "menber_id": menberId,
        "profile_image": profileImage,
        "pr_name": prName,
        "dr_name": drName,
        "vill_name": villName,
      };
}
