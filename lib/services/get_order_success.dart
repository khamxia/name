import 'package:flutter/material.dart';
import 'package:meesooklife_app/constant/api.dart';
import 'package:http/http.dart' as http;
import '../constant/image.dart';
import '../screen/model/order_model.dart';
import '../widget/alert_diog/alert_error.dart';

Future<OrderModel?> orderSuccess(
    BuildContext context, String accessToken) async {
  String url = PathAPI.ORDER_SUCCESS;
  try {
    var response = await http.get(Uri.parse(url), headers: {
      'accept': 'text/plain',
      'Authorization': 'Bearer $accessToken'
    });
    if (response.statusCode == 200) {
      return orderModelFromJson(response.body);
    } else {
      print('error ${response.statusCode} ${response.body}');
    }
  } catch (e) {
    return await orderSuccessExpectOne(context, accessToken);
  }
}

Future<OrderModel?> orderSuccessExpectOne(
    BuildContext context, String accessToken) async {
  String url = PathAPI.ORDER_SUCCESS;
  try {
    var response = await http.get(Uri.parse(url), headers: {
      'accept': 'text/plain',
      'Authorization': 'Bearer $accessToken'
    });
    if (response.statusCode == 200) {
      return orderModelFromJson(response.body);
    } else {
      print('error ${response.statusCode} ${response.body}');
    }
  } catch (e) {
    return await orderSuccessExpectTwo(context, accessToken);
  }
}

Future<OrderModel?> orderSuccessExpectTwo(
    BuildContext context, String accessToken) async {
  String url = PathAPI.ORDER_SUCCESS;
  try {
    var response = await http.get(Uri.parse(url), headers: {
      'accept': 'text/plain',
      'Authorization': 'Bearer $accessToken'
    });
    if (response.statusCode == 200) {
      return orderModelFromJson(response.body);
    } else {
      print('error ${response.statusCode} ${response.body}');
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
