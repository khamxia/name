import 'package:flutter/material.dart';
import 'package:meesooklife_app/constant/api.dart';
import 'package:http/http.dart' as http;
import '../constant/image.dart';
import '../screen/model/wallet_model.dart';
import '../widget/alert_diog/alert_error.dart';

Future<WalletsModels?> userswallets(
    BuildContext context, String accessToken, String payload) async {
  String url = PathAPI.WALLET;
  try {
    print('token $accessToken');
    var response = await http.post(Uri.parse(url),
        headers: {
          'accept': 'text/plain',
          'Authorization': 'Bearer $accessToken',
          'Content-Type': ' application/json'
        },
        body: payload);
    if (response.statusCode == 200) {
      return walletsModelsFromJson(response.body);
    } else {
      print('error ${response.statusCode} ${response.body}');
    }
  } catch (e) {
    return await getwalletExpectOne(context, accessToken, payload);
  }
}

Future<WalletsModels?> getwalletExpectOne(
    BuildContext context, String accessToken, String payload) async {
  String url = PathAPI.WALLET;
  try {
    var response = await http.post(Uri.parse(url),
        headers: {
          'accept': 'text/plain',
          'Authorization': 'Bearer $accessToken',
          'Content-Type': ' application/json'
        },
        body: payload);
    if (response.statusCode == 200) {
      return walletsModelsFromJson(response.body);
    } else {
      print('error ${response.statusCode} ${response.body}');
    }
  } catch (e) {
    return await getwalletExectTwo(context, accessToken, payload);
  }
}

Future<WalletsModels?> getwalletExectTwo(
    BuildContext context, String accessToken, String payload) async {
  String url = PathAPI.WALLET;
  try {
    var response = await http.post(Uri.parse(url),
        headers: {
          'accept': 'text/plain',
          'Authorization': 'Bearer $accessToken',
          'Content-Type': ' application/json'
        },
        body: payload);
    if (response.statusCode == 200) {
      return walletsModelsFromJson(response.body);
    } else {
      print('error ${response.statusCode} ${response.body}');
    }
  } catch (e) {
    print('errrrrrrrrrr $e');
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
