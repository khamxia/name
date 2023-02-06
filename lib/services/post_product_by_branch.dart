import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meesooklife_app/constant/api.dart';
import 'package:meesooklife_app/screen/model/products_by_branch_model.dart';
import '../constant/image.dart';
import '../widget/alert_diog/alert_error.dart';

Future<ProductByBranchModel?> productByBranch(
    BuildContext context, String accesstoken, String payload) async {
  String url = PathAPI.PRODUCT_BY_BRANCH;
  print('body $payload');
  try {
    var response = await http.post(Uri.parse(url),
        headers: {
          'accept': 'text/plain',
          'Authorization': 'Bearer $accesstoken',
          'Content-Type': ' application/json'
        },
        body: payload);
    if (response.statusCode == 200) {
      return productByBranchModelFromJson(response.body);
    } else {
      Navigator.pop(context);
      print('response error ${response.statusCode} ${response.body}');
    }
  } catch (e) {
    return await productByBranchExpectOne(context, accesstoken, payload);
  }
}

Future<ProductByBranchModel?> productByBranchExpectOne(
    BuildContext context, String accesstoken, String payload) async {
  String url = PathAPI.PRODUCT_BY_BRANCH;
  try {
    var response = await http.post(Uri.parse(url),
        headers: {
          'accept': 'text/plain',
          'Authorization': 'Bearer $accesstoken',
          'Content-Type': ' application/json'
        },
        body: payload);
    if (response.statusCode == 200) {
      return productByBranchModelFromJson(response.body);
    } else {
      Navigator.pop(context);
      print('response error ${response.statusCode} ${response.body}');
    }
  } catch (e) {
    return await productByBranchExpectTwo(context, accesstoken, payload);
  }
}

Future<ProductByBranchModel?> productByBranchExpectTwo(
    BuildContext context, String accesstoken, String payload) async {
  String url = PathAPI.PRODUCT_BY_BRANCH;
  try {
    var response = await http.post(Uri.parse(url),
        headers: {
          'accept': 'text/plain',
          'Authorization': 'Bearer $accesstoken',
          'Content-Type': ' application/json'
        },
        body: payload);
    if (response.statusCode == 200) {
      return productByBranchModelFromJson(response.body);
    } else {
      print('response error ${response.statusCode} ${response.body}');
    }
  } catch (e) {
    Navigator.pop(context);
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
