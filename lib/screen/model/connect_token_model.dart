// To parse this JSON data, do
//
//     final connectTokenModel = connectTokenModelFromJson(jsonString);

import 'dart:convert';

ConnectTokenModel? connectTokenModelFromJson(String str) =>
    ConnectTokenModel.fromJson(json.decode(str));

String connectTokenModelToJson(ConnectTokenModel? data) =>
    json.encode(data!.toJson());

class ConnectTokenModel {
  ConnectTokenModel({
    this.token,
  });

  String? token;

  factory ConnectTokenModel.fromJson(Map<String, dynamic> json) =>
      ConnectTokenModel(
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
      };
}
