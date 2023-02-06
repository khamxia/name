import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constant/api.dart';
import '../constant/image.dart';
import '../screen/model/branch_products_model.dart';
import '../widget/alert_diog/alert_error.dart';

Future<BranchProductsModel?> topBranchProduct(
    BuildContext context, String accesstoken) async {
  String url = PathAPI.TOP_BRANCH_PRODUCTS;
  try {
    var response = await http.get(Uri.parse(url), headers: {
      'accept': 'text/plain',
      'Authorization': 'Bearer $accesstoken'
    });
    if (response.statusCode == 200) {
      return branchProductsModelFromJson(response.body);
    } else {
      print('response error 11 ${response.statusCode} ${response.body}');
    }
  } catch (e) {
    return await topBranchProductExpectOne(context, accesstoken);
  }
}

Future<BranchProductsModel?> topBranchProductExpectOne(
    BuildContext context, String accesstoken) async {
  String url = PathAPI.TOP_BRANCH_PRODUCTS;
  try {
    var response = await http.get(Uri.parse(url), headers: {
      'accept': 'text/plain',
      'Authorization': 'Bearer $accesstoken'
    });
    if (response.statusCode == 200) {
      return branchProductsModelFromJson(response.body);
    } else {
      print('response error ${response.statusCode}');
    }
  } catch (e) {
    return await topBranchProductExpectTwo(context, accesstoken);
  }
}

Future<BranchProductsModel?> topBranchProductExpectTwo(
    BuildContext context, String accesstoken) async {
  String url = PathAPI.TOP_BRANCH_PRODUCTS;
  try {
    var response = await http.get(Uri.parse(url), headers: {
      'accept': 'text/plain',
      'Authorization': 'Bearer $accesstoken'
    });
    if (response.statusCode == 200) {
      return branchProductsModelFromJson(response.body);
    } else {
      print('response error ${response.statusCode}');
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
