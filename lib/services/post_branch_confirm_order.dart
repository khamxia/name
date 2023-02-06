import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meesooklife_app/constant/api.dart';
import 'package:meesooklife_app/screen/model/success_model.dart';

import '../constant/image.dart';
import '../widget/alert_diog/alert_error.dart';

Future<SuccessModel?> branchConfirmOrder(
    BuildContext context, String accesstoken, String payload) async {
  String url = PathAPI.BRANCH_CONFIRM_ORDER;
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
    return await branchConfirmOrderExpectOne(context, accesstoken, payload);
  }
}

Future<SuccessModel?> branchConfirmOrderExpectOne(
    BuildContext context, String accesstoken, String payload) async {
  String url = PathAPI.BRANCH_CONFIRM_ORDER;
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
    return await branchConfirmOrderExpectTwo(context, accesstoken, payload);
  }
}

Future<SuccessModel?> branchConfirmOrderExpectTwo(
    BuildContext context, String accesstoken, String payload) async {
  String url = PathAPI.BRANCH_CONFIRM_ORDER;
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
