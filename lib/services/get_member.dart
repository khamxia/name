import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meesooklife_app/screen/model/member_model.dart';
import '../constant/api.dart';
import '../constant/image.dart';
import '../widget/alert_diog/alert_error.dart';

Future<MemberModel?> usemember(BuildContext context, String accessToken) async {
  String url = PathAPI.ALL_MEMBER_ID;
  try {
    var response = await http.get(Uri.parse(url), headers: {
      'accept': 'text/plain',
      'Authorization': 'Bearer $accessToken'
    });
    if (response.statusCode == 200) {
      return memberModelFromJson(response.body);
    } else {
      print('response error ${response.statusCode} ${response.body}');
      showDialog(
        context: context,
        builder: (context) {
          return const ErrorAlertDialog(
              content: 'ຂໍອະໄພເກີດຂໍ້ຜິດພາດ ກະລຸນາລອງໃໝ່ອີກຄັ້ງ',
              icon: MyImages.erroricon);
        },
      );
    }
  } catch (e) {
    return await usememberExpectOne(context, accessToken);
  }
}

Future<MemberModel?> usememberExpectOne(
    BuildContext context, String accessToken) async {
  String url = PathAPI.ALL_MEMBER_ID;
  try {
    var response = await http.get(Uri.parse(url), headers: {
      'accept': 'text/plain',
      'Authorization': 'Bearer $accessToken'
    });
    if (response.statusCode == 200) {
      return memberModelFromJson(response.body);
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return const ErrorAlertDialog(
              content: 'ຂໍອະໄພເກີດຂໍ້ຜິດພາດ ກະລຸນາລອງໃໝ່ອີກຄັ້ງ',
              icon: MyImages.erroricon);
        },
      );
    }
  } catch (e) {
    return await usememberExpectTwo(context, accessToken);
  }
}

Future<MemberModel?> usememberExpectTwo(
    BuildContext context, String accessToken) async {
  String url = PathAPI.ALL_MEMBER_ID;
  try {
    var response = await http.get(Uri.parse(url), headers: {
      'accept': 'text/plain',
      'Authorization': 'Bearer $accessToken'
    });
    if (response.statusCode == 200) {
      return memberModelFromJson(response.body);
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return const ErrorAlertDialog(
              content: 'ຂໍອະໄພເກີດຂໍ້ຜິດພາດ ກະລຸນາລອງໃໝ່ອີກຄັ້ງ',
              icon: MyImages.erroricon);
        },
      );
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
