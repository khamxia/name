// // To parse this JSON data, do
// //
// //     final topTenProductModel = topTenProductModelFromJson(jsonString);

// import 'dart:convert';

// TopTenProductModel? topTenProductModelFromJson(String str) =>
//     TopTenProductModel.fromJson(json.decode(str));

// String topTenProductModelToJson(TopTenProductModel? data) =>
//     json.encode(data!.toJson());

// class TopTenProductModel {
//   TopTenProductModel({
//     required this.products,
//   });

//   List<TopProduct> products;

//   factory TopTenProductModel.fromJson(Map<String, dynamic> json) =>
//       TopTenProductModel(
//         products: json["products"] == null
//             ? []
//             : List<TopProduct>.from(
//                 json["products"]!.map((x) => TopProduct.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "products": products == null
//             ? []
//             : List<dynamic>.from(products.map((x) => x.toJson())),
//       };
// }

// class TopProduct {
//   TopProduct({
//     this.id,
//     this.name,
//     this.amount,
//     this.branchId,
//     this.branchName,
//     this.details,
//     this.sellingPrice,
//     this.purchasePrice,
//     required this.images,
//   });

//   int? id;
//   String? name;
//   int? amount;
//   int? branchId;
//   String? branchName;
//   String? details;
//   int? sellingPrice;
//   int? purchasePrice;
//   List<PImage> images;

//   factory TopProduct.fromJson(Map<String, dynamic> json) => TopProduct(
//         id: json["id"],
//         name: json["name"],
//         amount: json["amount"],
//         branchId: json["branch_id"],
//         branchName: json["branch_name"],
//         details: json["details"],
//         sellingPrice: json["selling_price"],
//         purchasePrice: json["purchase_price"],
//         images: json["images"] == null
//             ? []
//             : List<PImage>.from(
//                 json["images"]!.map((x) => PImage.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "amount": amount,
//         "branch_id": branchId,
//         "branch_name": branchName,
//         "details": details,
//         "selling_price": sellingPrice,
//         "purchase_price": purchasePrice,
//         "images": images == null
//             ? []
//             : List<dynamic>.from(images.map((x) => x.toJson())),
//       };
// }

// class PImage {
//   PImage({
//     this.image,
//   });

//   String? image;

//   factory PImage.fromJson(Map<String, dynamic> json) => PImage(
//         image: json["image"],
//       );

//   Map<String, dynamic> toJson() => {
//         "image": image,
//       };
// }
