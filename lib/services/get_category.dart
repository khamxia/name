import 'package:flutter/material.dart';
import 'package:meesooklife_app/screen/model/category_model.dart';
import 'package:http/http.dart' as http;
import '../constant/api.dart';
import '../constant/image.dart';
import '../widget/alert_diog/alert_error.dart';

Future<CategoryModel?> category(
    BuildContext context, String accessToken) async {
  String url = PathAPI.ALL_CATEGORY;
  try {
    var response = await http.get(Uri.parse(url), headers: {
      'accept': 'text/plain',
      'Authorization': 'Bearer $accessToken'
    });
    if (response.statusCode == 200) {
      return categoryModelFromJson(response.body);
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
    return await categoryExpectOne(context, accessToken);
  }
}

Future<CategoryModel?> categoryExpectOne(
    BuildContext context, String accessToken) async {
  String url = PathAPI.ALL_CATEGORY;
  try {
    var response = await http.get(Uri.parse(url), headers: {
      'accept': 'text/plain',
      'Authorization': 'Bearer $accessToken'
    });
    if (response.statusCode == 200) {
      return categoryModelFromJson(response.body);
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
    return await categoryExpectTwo(context, accessToken);
  }
}

Future<CategoryModel?> categoryExpectTwo(
    BuildContext context, String accessToken) async {
  String url = PathAPI.ALL_CATEGORY;
  try {
    var response = await http.get(Uri.parse(url), headers: {
      'accept': 'text/plain',
      'Authorization': 'Bearer $accessToken'
    });
    if (response.statusCode == 200) {
      return categoryModelFromJson(response.body);
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
