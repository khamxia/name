// To parse this JSON data, do
//
//     final sqliteStoreModel = sqliteStoreModelFromJson(jsonString);

import 'dart:convert';

SqliteStoreModel sqliteStoreModelFromJson(String str) =>
    SqliteStoreModel.fromJson(json.decode(str));

String sqliteStoreModelToJson(SqliteStoreModel data) =>
    json.encode(data.toJson());

class SqliteStoreModel {
  SqliteStoreModel({
    this.id,
    this.productId,
    this.productName,
    this.amount,
    this.category,
    this.price,
    this.total,
    this.branchId,
    this.branchName,
  });

  int? id;
  String? productId;
  String? productName;
  String? amount;
  String? category;
  String? price;
  String? total;
  String? branchId;
  String? branchName;

  factory SqliteStoreModel.fromJson(Map<String, dynamic> json) =>
      SqliteStoreModel(
        id: json["id"],
        productId: json["productID"],
        productName: json["productName"],
        amount: json["amount"],
        category: json["category"],
        price: json["price"],
        total: json["total"],
        branchId: json["branchID"],
        branchName: json["branchName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "productID": productId,
        "productName": productName,
        "amount": amount,
        "category": category,
        "price": price,
        "total": total,
        "branchID": branchId,
        "branchName": branchName,
      };
}
