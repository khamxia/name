import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meesooklife_app/constant/api.dart';
import 'package:meesooklife_app/screen/model/products_model.dart';

import '../constant/image.dart';
import '../widget/alert_diog/alert_error.dart';

Future<ProductsModel?> products(
    BuildContext context, String accessToken, String payload) async {
  String url = PathAPI.ALL_PRODUCT;
  try {
    var response = await http.post(Uri.parse(url),
        headers: {
          'accept': 'text/plain',
          'Authorization': 'Bearer $accessToken',
          'Content-Type': ' application/json'
        },
        body: payload);
    if (response.statusCode == 200) {
      print('response success ${response.statusCode}');
      return productsModelFromJson(response.body);
    } else {
      print(
          'response error products All ${response.statusCode} ${jsonDecode(response.body)}');
    }
  } catch (e) {
    return await productsExpectOne(context, accessToken, payload);
  }
}

Future<ProductsModel?> productsExpectOne(
    BuildContext context, String accessToken, String payload) async {
  String url = PathAPI.ALL_PRODUCT;
  try {
    var response = await http.post(Uri.parse(url),
        headers: {
          'accept': 'text/plain',
          'Authorization': 'Bearer $accessToken',
          'Content-Type': ' application/json'
        },
        body: payload);
    if (response.statusCode == 200) {
      return productsModelFromJson(response.body);
    } else {
      print('response error ${response.statusCode} ${response.body}');
    }
  } catch (e) {
    return await productsExpectTwo(context, accessToken, payload);
  }
}

Future<ProductsModel?> productsExpectTwo(
    BuildContext context, String accessToken, String payload) async {
  String url = PathAPI.ALL_PRODUCT;
  try {
    var response = await http.post(Uri.parse(url),
        headers: {
          'accept': 'text/plain',
          'Authorization': 'Bearer $accessToken',
          'Content-Type': ' application/json'
        },
        body: payload);
    if (response.statusCode == 200) {
      return productsModelFromJson(response.body);
    } else {
      print('response error ${response.statusCode} ${response.body}');
    }
  } catch (e) {
    showDialog(
      context: context,
      builder: (context) {
        return const ErrorAlertDialog(
            content: 'ຂໍອະໄພເກີດຂໍ້ຜິດພາດ ກະລຸນາລອງໃໝ່ອີກຄັ້ງ',
            icon: MyImages.erroricon);
      },
    );
  }
}
