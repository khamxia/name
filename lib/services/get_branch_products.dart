import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meesooklife_app/constant/api.dart';
import 'package:meesooklife_app/screen/model/branch_products_model.dart';
import '../constant/image.dart';
import '../widget/alert_diog/alert_error.dart';

Future<BranchProductsModel?> branchProducts(
    BuildContext context, String accessToken) async {
  String url = PathAPI.ALL_BRANCH_PRODUCTS;
  try {
    var response = await http.get(Uri.parse(url), headers: {
      'accept': 'text/plain',
      'Authorization': 'Bearer $accessToken'
    });
    if (response.statusCode == 200) {
      print('response success ${response.statusCode}');
      return branchProductsModelFromJson(response.body);
    } else {
      print('response error ${response.statusCode} ${response.body}');
    }
  } catch (e) {
    return await branchProductsOne(context, accessToken);
  }
}

Future<BranchProductsModel?> branchProductsOne(
    BuildContext context, String accessToken) async {
  String url = PathAPI.ALL_BRANCH_PRODUCTS;
  try {
    var response = await http.get(Uri.parse(url), headers: {
      'accept': 'text/plain',
      'Authorization': 'Bearer $accessToken'
    });
    if (response.statusCode == 200) {
      return branchProductsModelFromJson(response.body);
    } else {
      print('response error ${response.statusCode} ${response.body}');
    }
  } catch (e) {
    return await branchProductsTwo(context, accessToken);
  }
}

Future<BranchProductsModel?> branchProductsTwo(
    BuildContext context, String accessToken) async {
  String url = PathAPI.ALL_BRANCH_PRODUCTS;
  try {
    var response = await http.get(Uri.parse(url), headers: {
      'accept': 'text/plain',
      'Authorization': 'Bearer $accessToken'
    });
    if (response.statusCode == 200) {
      return branchProductsModelFromJson(response.body);
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
