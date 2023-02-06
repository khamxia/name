
import 'package:flutter/material.dart';
import 'package:meesooklife_app/screen/model/success_model.dart';
import 'package:http/http.dart' as http;
import '../constant/api.dart';
import '../constant/image.dart';
import '../widget/alert_diog/alert_error.dart';

Future<SuccessModel?> orderCanecl(
    BuildContext context, String accesstoken, String payload) async {
  String url = PathAPI.ORDER_CANCEL;
  try {
    var response = await http.post(Uri.parse(url),
        headers: {
          'accept': 'text/plain',
          'Authorization': 'Bearer $accesstoken',
          'Content-Type': ' application/json'
        },
        body: payload);
    if (response.statusCode == 200) {
      print('response branch confirm  ${response.statusCode}');
      return successModelFromJson(response.body);
    } else {
      print('response error ${response.statusCode} ${response.body}');
    }
  } catch (e) {
    return await orderCaneclExpectOne(context, accesstoken, payload);
  }
}

Future<SuccessModel?> orderCaneclExpectOne(
    BuildContext context, String accesstoken, String payload) async {
  String url = PathAPI.ORDER_CANCEL;
  try {
    var response = await http.post(Uri.parse(url),
        headers: {
          'accept': 'text/plain',
          'Authorization': 'Bearer $accesstoken',
          'Content-Type': ' application/json'
        },
        body: payload);
    if (response.statusCode == 200) {
      print('response branch success ${response.statusCode}');
      return successModelFromJson(response.body);
    } else {
      print('response error ${response.statusCode} ${response.body}');
    }
  } catch (e) {
    return await orderCaneclExpectTwo(context, accesstoken, payload);
  }
}

Future<SuccessModel?> orderCaneclExpectTwo(
    BuildContext context, String accesstoken, String payload) async {
  String url = PathAPI.ORDER_CANCEL;
  try {
    var response = await http.post(Uri.parse(url),
        headers: {
          'accept': 'text/plain',
          'Authorization': 'Bearer $accesstoken',
          'Content-Type': ' application/json'
        },
        body: payload);
    if (response.statusCode == 200) {
      print('response branch success ${response.statusCode}');
      return successModelFromJson(response.body);
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
