import 'package:flutter/material.dart';
import 'package:meesooklife_app/constant/api.dart';
import 'package:http/http.dart' as http;
import 'package:meesooklife_app/screen/model/products_model.dart';
import '../constant/image.dart';
import '../widget/alert_diog/alert_error.dart';

Future<ProductsModel?> toptenProducts(
    BuildContext context, String accesstoken) async {
  String url = PathAPI.TOP_PRODUCTS;
  try {
    var response = await http.get(Uri.parse(url), headers: {
      'accept': 'text/plain',
      'Authorization': 'Bearer $accesstoken'
    });
    if (response.statusCode == 200) {
      return productsModelFromJson(response.body);
    } else {
      print('response error products ${response.statusCode}');
    }
  } catch (e) {
    return await toptenProductsOne(context, accesstoken);
  }
}

Future<ProductsModel?> toptenProductsOne(
    BuildContext context, String accesstoken) async {
  String url = PathAPI.TOP_PRODUCTS;
  try {
    var response = await http.get(Uri.parse(url), headers: {
      'accept': 'text/plain',
      'Authorization': 'Bearer $accesstoken'
    });
    if (response.statusCode == 200) {
      return productsModelFromJson(response.body);
    } else {
      print('response error ${response.statusCode}');
    }
  } catch (e) {
    return await toptenProductsTwo(context, accesstoken);
  }
}

Future<ProductsModel?> toptenProductsTwo(
    BuildContext context, String accesstoken) async {
  String url = PathAPI.TOP_PRODUCTS;
  try {
    var response = await http.get(Uri.parse(url), headers: {
      'accept': 'text/plain',
      'Authorization': 'Bearer $accesstoken'
    });
    if (response.statusCode == 200) {
      return productsModelFromJson(response.body);
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
