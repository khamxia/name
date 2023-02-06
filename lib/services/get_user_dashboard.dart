import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meesooklife_app/constant/api.dart';
import 'package:meesooklife_app/constant/image.dart';
import 'package:meesooklife_app/screen/model/user_dashboard_model.dart';
import 'package:meesooklife_app/widget/alert_diog/alert_error.dart';

Future<UserDashBoardModel?> userDashboard(
    BuildContext context, String accessToken) async {
  String url = PathAPI.USER_DASHBOARD;
  try {
    var response = await http.get(Uri.parse(url), headers: {
      'accept': 'text/plain',
      'Authorization': 'Bearer $accessToken'
    });
    if (response.statusCode == 200) {
      // print('response success ${response.statusCode}}');
      return userDashBoardModelFromJson(response.body);
    } else {
      print('response dasboard  ${response.statusCode} ${response.body}}');
    }
  } catch (e) {
    return await userDashboardExpectOne(context, accessToken);
  }
}

Future<UserDashBoardModel?> userDashboardExpectOne(
    BuildContext context, String accessToken) async {
  String url = PathAPI.USER_DASHBOARD;
  try {
    var response = await http.get(Uri.parse(url), headers: {
      'accept': 'text/plain',
      'Authorization': 'Bearer $accessToken'
    });

    if (response.statusCode == 200) {
      return userDashBoardModelFromJson(response.body);
    } else {
      print('response error ${response.statusCode}');
    }
  } catch (e) {
    return await userDashboardExpectTwo(context, accessToken);
  }
}

Future<UserDashBoardModel?> userDashboardExpectTwo(
    BuildContext context, String accessToken) async {
  String url = PathAPI.USER_DASHBOARD;
  try {
    var response = await http.get(Uri.parse(url), headers: {
      'accept': 'text/plain',
      'Authorization': 'Bearer $accessToken'
    });
    if (response.statusCode == 200) {
      return userDashBoardModelFromJson(response.body);
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
