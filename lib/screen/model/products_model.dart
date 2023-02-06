// To parse this JSON data, do
//
//     final productsModel = productsModelFromJson(jsonString);

import 'dart:convert';

ProductsModel productsModelFromJson(String str) => ProductsModel.fromJson(json.decode(str));

String productsModelToJson(ProductsModel? data) => json.encode(data!.toJson());

class ProductsModel {
    ProductsModel({
      required  this.products,
    });

    List<Product> products;

    factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
        products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "products": products == null ? [] : List<dynamic>.from(products.map((x) => x.toJson())),
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
      required  this.images,
    });

    int? id;
    String? name;
    int? amount;
    int? branchId;
    String? branchName;
    String? details;
    int? sellingPrice;
    int? purchasePrice;
    List<PImage> images;

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        amount: json["amount"],
        branchId: json["branch_id"],
        branchName: json["branch_name"],
        details: json["details"],
        sellingPrice: json["selling_price"],
        purchasePrice: json["purchase_price"],
        images: json["images"] == null ? [] : List<PImage>.from(json["images"]!.map((x) => PImage.fromJson(x))),
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
        "images": images == null ? [] : List<dynamic>.from(images.map((x) => x.toJson())),
    };
}

class PImage {
    PImage({
        this.image,
    });

    String? image;

    factory PImage.fromJson(Map<String, dynamic> json) => PImage(
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "image": image,
    };
}

