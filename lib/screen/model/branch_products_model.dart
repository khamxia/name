// To parse this JSON data, do
//
//     final branchProductsModel = branchProductsModelFromJson(jsonString);

import 'dart:convert';

BranchProductsModel? branchProductsModelFromJson(String str) =>
    BranchProductsModel.fromJson(json.decode(str));

String branchProductsModelToJson(BranchProductsModel? data) =>
    json.encode(data!.toJson());

class BranchProductsModel {
  BranchProductsModel({
    required this.products,
  });

  List<Product> products;

  factory BranchProductsModel.fromJson(Map<String, dynamic> json) =>
      BranchProductsModel(
        products: json["products"] == null
            ? []
            : List<Product>.from(
                json["products"]!.map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "products": products == null
            ? []
            : List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

class Product {
  Product({
    this.id,
    this.name,
    this.amount,
    this.branchId,
    this.branchName,
    this.details,
    this.sellingPrice,
    this.purchasePrice,
    required this.images,
  });

  int? id;
  String? name;
  int? amount;
  int? branchId;
  String? branchName;
  String? details;
  int? sellingPrice;
  int? purchasePrice;
  List<BImage> images;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        amount: json["amount"],
        branchId: json["branch_id"],
        branchName: json["branch_name"],
        details: json["details"],
        sellingPrice: json["selling_price"],
        purchasePrice: json["purchase_price"],
        images: json["images"] == null
            ? []
            : List<BImage>.from(json["images"]!.map((x) => BImage.fromJson(x))),
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
        "images": images == null
            ? []
            : List<dynamic>.from(images.map((x) => x.toJson())),
      };
}

class BImage {
  BImage({
    this.image,
  });

  String? image;

  factory BImage.fromJson(Map<String, dynamic> json) => BImage(
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
      };
}
