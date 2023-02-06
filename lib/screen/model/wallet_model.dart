// To parse this JSON data, do
//
//     final walletsModels = walletsModelsFromJson(jsonString);

import 'dart:convert';

WalletsModels walletsModelsFromJson(String str) =>
    WalletsModels.fromJson(json.decode(str));

String walletsModelsToJson(WalletsModels data) => json.encode(data.toJson());

class WalletsModels {
  WalletsModels({
    this.userWallet,
    this.userWalletHistory,
  });

  UserWallet? userWallet;
  List<UserWalletHistory>? userWalletHistory;

  factory WalletsModels.fromJson(Map<String, dynamic> json) => WalletsModels(
        userWallet: json["user_wallet"] == null
            ? null
            : UserWallet.fromJson(json["user_wallet"]),
        userWalletHistory: json["user_wallet_history"] == null
            ? null
            : List<UserWalletHistory>.from(json["user_wallet_history"]
                .map((x) => UserWalletHistory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "user_wallet": userWallet == null ? null : userWallet!.toJson(),
        "user_wallet_history": userWalletHistory == null
            ? null
            : List<dynamic>.from(userWalletHistory!.map((x) => x.toJson())),
      };
}

class UserWallet {
  UserWallet({
    required this.userId,
    required this.moneyBuy,
    required this.moneySale,
  });

  int userId;
  int moneyBuy;
  int moneySale;

  factory UserWallet.fromJson(Map<String, dynamic> json) => UserWallet(
        userId: json["user_id"],
        moneyBuy: json["money_buy"],
        moneySale: json["money_sale"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "money_buy": moneyBuy,
        "money_sale": moneySale,
      };
}

class UserWalletHistory {
  UserWalletHistory({
    required this.id,
    required this.billNo,
    required this.total,
    required this.createdAt,
  });

  int id;
  int billNo;
  int total;
  DateTime createdAt;

  factory UserWalletHistory.fromJson(Map<String, dynamic> json) =>
      UserWalletHistory(
        id: json["id"],
        billNo: json["bill_no"],
        total: json["total"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "bill_no": billNo,
        "total": total,
        "created_at": createdAt.toIso8601String(),
      };
}
