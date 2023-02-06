// To parse this JSON data, do
//
//     final historyModel = historyModelFromJson(jsonString);

import 'dart:convert';

HistoryModel historyModelFromJson(String str) =>
    HistoryModel.fromJson(json.decode(str));

String historyModelToJson(HistoryModel data) => json.encode(data.toJson());

class HistoryModel {
  HistoryModel({
    this.data,
  });

  List<Datum>? data;

  factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
        data:json["data"] == null ? []: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.billNo,
    required this.createdAt,
    required this.saleStatus,
    required this.total,
    required this.sippingStatus,
    required this.sippingName,
    required this.sippingPr,
    required this.sippingDr,
    required this.sippingVill,
    required this.user,
    required this.userPhone,
    required this.userImage,
    required this.branchId,
    required this.branchName,
    required this.branchLogo,
    required this.orderDetails,
  });

  int? id;
  int? billNo;
  DateTime createdAt;
  int saleStatus;
  int total;
  int sippingStatus;
  String sippingName;
  String sippingPr;
  String sippingDr;
  String sippingVill;
  String user;
  int userPhone;
  String userImage;
  int branchId;
  String branchName;
  String branchLogo;
  List<OrderDetail> orderDetails;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        billNo: json["bill_no"],
        createdAt: DateTime.parse(json["created_at"]),
        saleStatus: json["sale_status"],
        total: json["total"],
        sippingStatus: json["sipping_status"],
        sippingName: json["sipping_name"],
        sippingPr: json["sipping_pr"],
        sippingDr: json["sipping_dr"],
        sippingVill: json["sipping_vill"],
        user: json["user"],
        userPhone: json["user_phone"],
        userImage: json["user_image"],
        branchId: json["branch_id"],
        branchName: json["branch_name"],
        branchLogo: json["branch_logo"],
        orderDetails: List<OrderDetail>.from(
            json["order_details"].map((x) => OrderDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "bill_no": billNo,
        "created_at": createdAt.toIso8601String(),
        "sale_status": saleStatus,
        "total": total,
        "sipping_status": sippingStatus,
        "sipping_name": sippingName,
        "sipping_pr": sippingPr,
        "sipping_dr": sippingDr,
        "sipping_vill": sippingVill,
        "user": user,
        "user_phone": userPhone,
        "user_image": userImage,
        "branch_id": branchId,
        "branch_name": branchName,
        "branch_logo": branchLogo,
        "order_details":
            List<dynamic>.from(orderDetails.map((x) => x.toJson())),
      };
}

class OrderDetail {
  OrderDetail({
    required this.id,
    required this.name,
    required this.amount,
    required this.purchasePrice,
    required this.sellingPrice,
    required this.images,
  });

  int id;
  String name;
  int amount;
  int purchasePrice;
  int sellingPrice;
  List<HImage> images;

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
        id: json["id"],
        name: json["name"],
        amount: json["amount"],
        purchasePrice: json["purchase_price"],
        sellingPrice: json["selling_price"],
        images:
            List<HImage>.from(json["images"].map((x) => HImage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "amount": amount,
        "purchase_price": purchasePrice,
        "selling_price": sellingPrice,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
      };
}

class HImage {
  HImage({
    required this.image,
  });

  String image;

  factory HImage.fromJson(Map<String, dynamic> json) => HImage(
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
      };
}
