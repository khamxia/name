import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meesooklife_app/constant/api.dart';

import '../constant/image.dart';
import '../widget/alert_diog/alert_error.dart';

Future<void> branchCloseOpen(
    BuildContext context, String accesstoken, String payload) async {
  String url = PathAPI.BRANCH_CLOSE_OPEN;
  try {
    var response = await http.post(Uri.parse(url),
        headers: {
          'accept': 'text/plain',
          'Authorization': 'Bearer $accesstoken',
          'Content-Type': ' application/json'
        },
        body: payload);
    if (response.statusCode == 200) {
      print('close and open branch ${response.statusCode} ${response.body}}');
    } else {
      print('response error ${response.statusCode} ${response.body}}');
    }
  } catch (e) {
    return await branchCloseOpenExpectOne(context, accesstoken, payload);
  }
}

Future<void> branchCloseOpenExpectOne(
    BuildContext context, String accesstoken, String payload) async {
  String url = PathAPI.BRANCH_CLOSE_OPEN;
  try {
    var response = await http.post(Uri.parse(url),
        headers: {
          'accept': 'text/plain',
          'Authorization': 'Bearer $accesstoken',
          'Content-Type': ' application/json'
        },
        body: payload);
    if (response.statusCode == 200) {
    } else {
      print('response error ${response.statusCode} ${response.body}}');
    }
  } catch (e) {
    return await branchCloseOpenExpectTwo(context, accesstoken, payload);
  }
}

Future<void> branchCloseOpenExpectTwo(
    BuildContext context, String accesstoken, String payload) async {
  String url = PathAPI.BRANCH_CLOSE_OPEN;
  try {
    var response = await http.post(Uri.parse(url),
        headers: {
          'accept': 'text/plain',
          'Authorization': 'Bearer $accesstoken',
          'Content-Type': ' application/json'
        },
        body: payload);
    if (response.statusCode == 200) {
    } else {
      print('response error ${response.statusCode} ${response.body}}');
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
