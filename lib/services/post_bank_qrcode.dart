import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meesooklife_app/constant/api.dart';
import 'package:meesooklife_app/screen/model/bank_qrcode.dart';

import '../constant/image.dart';
import '../widget/alert_diog/alert_error.dart';

Future<BankRqCodeModel?> bankQRCode(
    BuildContext context, String accesstoken, String payload) async {
  String url = PathAPI.BANK_RQCODE;
  try {
    var response = await http.post(Uri.parse(url),
        headers: {
          'accept': 'text/plain',
          'Authorization': 'Bearer $accesstoken',
          'Content-Type': ' application/json'
        },
        body: payload);
    if (response.statusCode == 200) {
      return bankRqCodeModelFromJson(response.body);
    } else {
      print(
          'response bank QRCode error ${response.statusCode} ${response.body}}');
    }
  } catch (e) {
    return await bankQRCodeExpectOne(context, accesstoken, payload);
  }
}

Future<BankRqCodeModel?> bankQRCodeExpectOne(
    BuildContext context, String accesstoken, String payload) async {
  String url = PathAPI.BANK_RQCODE;
  try {
    var response = await http.post(Uri.parse(url),
        headers: {
          'accept': 'text/plain',
          'Authorization': 'Bearer $accesstoken',
          'Content-Type': ' application/json'
        },
        body: payload);
    if (response.statusCode == 200) {
      return bankRqCodeModelFromJson(response.body);
    } else {
      print('response error ${response.statusCode} ${response.body}}');
    }
  } catch (e) {
    return await bankQRCodeExpectTwo(context, accesstoken, payload);
  }
}

Future<BankRqCodeModel?> bankQRCodeExpectTwo(
    BuildContext context, String accesstoken, String payload) async {
  String url = PathAPI.BANK_RQCODE;
  try {
    var response = await http.post(Uri.parse(url),
        headers: {
          'accept': 'text/plain',
          'Authorization': 'Bearer $accesstoken',
          'Content-Type': ' application/json'
        },
        body: payload);
    if (response.statusCode == 200) {
      return bankRqCodeModelFromJson(response.body);
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
