// To parse this JSON data, do
//
//     final successModel = successModelFromJson(jsonString);

import 'dart:convert';

SuccessModel? successModelFromJson(String str) =>
    SuccessModel.fromJson(json.decode(str));

String successModelToJson(SuccessModel? data) => json.encode(data!.toJson());

class SuccessModel {
  SuccessModel({
    this.message,
  });

  String? message;

  factory SuccessModel.fromJson(Map<String, dynamic> json) => SuccessModel(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
