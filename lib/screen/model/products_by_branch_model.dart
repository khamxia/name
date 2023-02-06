// To parse this JSON data, do
//
//     final productByBranchModel = productByBranchModelFromJson(jsonString);

import 'dart:convert';

ProductByBranchModel productByBranchModelFromJson(String str) =>
    ProductByBranchModel.fromJson(json.decode(str));

String productByBranchModelToJson(ProductByBranchModel data) =>
    json.encode(data.toJson());

class ProductByBranchModel {
  ProductByBranchModel({
    required this.branchs,
    this.products,
  });

  Branchs branchs;
  List<BProduct>? products;

  factory ProductByBranchModel.fromJson(Map<String, dynamic> json) =>
      ProductByBranchModel(
        branchs: Branchs.fromJson(json["branchs"]),
        products: json["products"] == null
            ? null
            : List<BProduct>.from(
                json["products"].map((x) => BProduct.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "branchs": branchs.toJson(),
        "products": products == null
            ? null
            : List<dynamic>.from(products!.map((x) => x.toJson())),
      };
}

class Branchs {
  Branchs({
    required this.id,
    required this.branchName,
    required this.branchPhone,
    required this.branchLogo,
    required this.branchQrcode,
    required this.bceloneNumber,
    required this.prId,
    required this.prName,
    required this.drId,
    required this.drName,
    required this.villId,
    required this.villName,
  });

  int id;
  String branchName;
  int branchPhone;
  String branchLogo;
  String branchQrcode;
  int bceloneNumber;
  int prId;
  String prName;
  int drId;
  String drName;
  int villId;
  String villName;

  factory Branchs.fromJson(Map<String, dynamic> json) => Branchs(
        id: json["id"],
        branchName: json["branch_name"],
        branchPhone: json["branch_phone"],
        branchLogo: json["branch_logo"],
        branchQrcode: json["branch_qrcode"],
        bceloneNumber: json["bcelone_number"],
        prId: json["pr_id"],
        prName: json["pr_name"],
        drId: json["dr_id"],
        drName: json["dr_name"],
        villId: json["vill_id"],
        villName: json["vill_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "branch_name": branchName,
        "branch_phone": branchPhone,
        "branch_logo": branchLogo,
        "branch_qrcode": branchQrcode,
        "bcelone_number": bceloneNumber,
        "pr_id": prId,
        "pr_name": prName,
        "dr_id": drId,
        "dr_name": drName,
        "vill_id": villId,
        "vill_name": villName,
      };
}

class BProduct {
  BProduct({
    required this.id,
    required this.name,
    required this.amount,
    required this.branchId,
    required this.branchName,
    required this.details,
    required this.sellingPrice,
    required this.purchasePrice,
    required this.images,
  });

  int id;
  String name;
  int amount;
  int branchId;
  String branchName;
  String details;
  int sellingPrice;
  int purchasePrice;
  List<BYImage> images;

  factory BProduct.fromJson(Map<String, dynamic> json) => BProduct(
        id: json["id"],
        name: json["name"],
        amount: json["amount"],
        branchId: json["branch_id"],
        branchName: json["branch_name"],
        details: json["details"],
        sellingPrice: json["selling_price"],
        purchasePrice: json["purchase_price"],
        images:
            List<BYImage>.from(json["images"].map((x) => BYImage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "amount": amount,
        "branch_id": branchId,
        "branch_name": branchName,
        "details": details,
        "selling_price": sellingPrice,
        "purchase_price": purchasePrice,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
      };
}

class BYImage {
  BYImage({
    required this.image,
  });

  String image;

  factory BYImage.fromJson(Map<String, dynamic> json) => BYImage(
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
      };
}
