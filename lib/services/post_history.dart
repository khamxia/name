import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meesooklife_app/constant/api.dart';
import 'package:http/http.dart' as http;
import '../constant/image.dart';
import '../screen/model/history_model.dart';
import '../widget/alert_diog/alert_error.dart';

Future<HistoryModel?> history(
    BuildContext context, String accessToken, String payload) async {
  String url = PathAPI.HISTORIES;
  try {
    var response = await http.post(Uri.parse(url),
        headers: {
          'accept': 'text/plain',
          'Authorization': 'Bearer $accessToken',
          'Content-Type': ' application/json'
        },
        body: payload);
    if (response.statusCode == 200) {
      return historyModelFromJson(response.body);
    } else {
      print('response error ${response.statusCode} ${response.body}');
    }
  } catch (e) {
    return await historyExpectOne(context, accessToken, payload);
  }
}

Future<HistoryModel?> historyExpectOne(
    BuildContext context, String accessToken, String payload) async {
  String url = PathAPI.HISTORIES;
  try {
    var response = await http.post(Uri.parse(url),
        headers: {
          'accept': 'text/plain',
          'Authorization': 'Bearer $accessToken',
          'Content-Type': ' application/json'
        },
        body: payload);
    if (response.statusCode == 200) {
      return historyModelFromJson(response.body);
    } else {
      print('response error ${response.statusCode} ${response.body}');
    }
  } catch (e) {
    return await historyExpectTwo(context, accessToken, payload);
  }
}

Future<HistoryModel?> historyExpectTwo(
    BuildContext context, String accessToken, String payload) async {
  String url = PathAPI.HISTORIES;
  try {
    var response = await http.post(Uri.parse(url),
        headers: {
          'accept': 'text/plain',
          'Authorization': 'Bearer $accessToken',
          'Content-Type': ' application/json'
        },
        body: payload);
    if (response.statusCode == 200) {
      return historyModelFromJson(response.body);
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
