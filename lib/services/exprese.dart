import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:meesooklife_app/constant/api.dart';
import 'package:meesooklife_app/screen/model/exprese_model.dart';
import '../constant/image.dart';
import '../widget/alert_diog/alert_error.dart';

Future<ExpreseModel?> exprese(BuildContext context, String accessToken) async {
  String url = PathAPI.EXPRESE;
  try {
    var response = await http.get(Uri.parse(url), headers: {
      'accept': 'text/plain',
      'Authorization': 'Bearer $accessToken'
    });
    if (response.statusCode == 200) {
      return expreseModelFromJson(response.body);
    } else {
      print('not success ${response.statusCode} ${response.body}}');
    }
  } catch (e) {
    return await expreseExpectOne(context, accessToken);
  }
}

Future<ExpreseModel?> expreseExpectOne(
    BuildContext context, String accessToken) async {
  String url = PathAPI.EXPRESE;
  try {
    var response = await http.get(Uri.parse(url), headers: {
      'accept': 'text/plain',
      'Authorization': 'Bearer $accessToken'
    });
    if (response.statusCode == 200) {
      return expreseModelFromJson(response.body);
    } else {
      print('not success ${response.statusCode} ${response.body}}');
    }
  } catch (e) {
    return await expreseExpectTwo(context, accessToken);
  }
}

Future<ExpreseModel?> expreseExpectTwo(
    BuildContext context, String accessToken) async {
  String url = PathAPI.EXPRESE;
  try {
    var response = await http.get(Uri.parse(url), headers: {
      'accept': 'text/plain',
      'Authorization': 'Bearer $accessToken'
    });
    if (response.statusCode == 200) {
      return expreseModelFromJson(response.body);
    } else {
      print('not success ${response.statusCode} ${response.body}}');
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
