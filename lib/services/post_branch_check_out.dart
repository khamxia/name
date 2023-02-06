import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meesooklife_app/constant/api.dart';
import 'package:meesooklife_app/screen/model/success_model.dart';

import '../constant/image.dart';
import '../widget/alert_diog/alert_error.dart';

Future<SuccessModel?> branchCheckOut(
    BuildContext context, String accessToken, String payload) async {
  String url = PathAPI.BRANCH_CHECK_OUT;
  try {
    var response = await http.post(Uri.parse(url),
        headers: {
          'accept': 'text/plain',
          'Authorization': 'Bearer $accessToken',
          'Content-Type': ' application/json'
        },
        body: payload);
    if (response.statusCode == 201) {
      return successModelFromJson(response.body);
    } else {
      print('response error ${response.statusCode} ${response.body}');
    }
  } catch (e) {
    return await branchCheckOutExpectOne(context, accessToken, payload);
  }
}

Future<SuccessModel?> branchCheckOutExpectOne(
    BuildContext context, String accessToken, String payload) async {
  String url = PathAPI.BRANCH_CHECK_OUT;
  try {
    var response = await http.post(Uri.parse(url),
        headers: {
          'accept': 'text/plain',
          'Authorization': 'Bearer $accessToken',
          'Content-Type': ' application/json'
        },
        body: payload);
    if (response.statusCode == 201) {
      print('response branch confirm  ${response.statusCode}');
      return successModelFromJson(response.body);
    } else {
      print('response error ${response.statusCode} ${response.body}');
    }
  } catch (e) {
    return await branchCheckOutExpectTwo(context, accessToken, payload);
  }
}

Future<SuccessModel?> branchCheckOutExpectTwo(
    BuildContext context, String accessToken, String payload) async {
  String url = PathAPI.BRANCH_CHECK_OUT;
  try {
    var response = await http.post(Uri.parse(url),
        headers: {
          'accept': 'text/plain',
          'Authorization': 'Bearer $accessToken',
          'Content-Type': ' application/json'
        },
        body: payload);
    if (response.statusCode == 201) {
      print('response branch confirm  ${response.statusCode}');
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
