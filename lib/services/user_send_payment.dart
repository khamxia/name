import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meesooklife_app/constant/api.dart';
import 'package:meesooklife_app/screen/model/success_model.dart';
import '../constant/image.dart';
import '../widget/alert_diog/alert_error.dart';

Future<SuccessModel?> userPayment(
    BuildContext context, String accesstoken, String payload) async {
  String url = PathAPI.USER_PAYMENT;
  try {
    var response = await http.post(Uri.parse(url),
        headers: {
          'accept': 'text/plain',
          'Authorization': 'Bearer $accesstoken',
          'Content-Type': ' application/json'
        },
        body: payload);
    if (response.statusCode == 201) {
      // print('response payment success ${response.statusCode}');
      return successModelFromJson(response.body);
    } else if (response.statusCode == 402) {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) {
          return const ErrorAlertDialog(
              content: 'ທ່ານໄດ້ສົ່ງເງິນໃຫ້ Meesooklife4289 ແລ້ວ',
              icon: MyImages.erroricon);
        },
      );
    } else {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) {
          return const ErrorAlertDialog(
              content:
                  'ຂໍອະໄພ ການສົ່ງເງິນໃຫ້Meesooklifeບໍ່ສຳເລັດ ກະລຸນາລອງໃໝ່ອີກຄັ້ງ',
              icon: MyImages.erroricon);
        },
      );
    }
  } catch (e) {
    return await userPaymentExpectOne(context, accesstoken, payload);
  }
}

Future<SuccessModel?> userPaymentExpectOne(
    BuildContext context, String accesstoken, String payload) async {
  String url = PathAPI.UPDATE_BRANCH_PROFILE;
  try {
    var response = await http.post(Uri.parse(url),
        headers: {
          'accept': 'text/plain',
          'Authorization': 'Bearer $accesstoken',
          'Content-Type': ' application/json'
        },
        body: payload);
    if (response.statusCode == 201) {
      return successModelFromJson(response.body);
    } else if (response.statusCode == 402) {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) {
          return const ErrorAlertDialog(
              content: 'ທ່ານໄດ້ສົ່ງເງິນໃຫ້ Meesooklife4289 ແລ້ວ',
              icon: MyImages.erroricon);
        },
      );
    } else {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) {
          return const ErrorAlertDialog(
              content:
                  'ຂໍອະໄພ ການສົ່ງເງິນໃຫ້Meesooklifeບໍ່ສຳເລັດ ກະລຸນາລອງໃໝ່ອີກຄັ້ງ',
              icon: MyImages.erroricon);
        },
      );
    }
  } catch (e) {
    return await userPaymentExpectTwo(context, accesstoken, payload);
  }
}

Future<SuccessModel?> userPaymentExpectTwo(
    BuildContext context, String accesstoken, String payload) async {
  String url = PathAPI.UPDATE_BRANCH_PROFILE;
  try {
    var response = await http.post(Uri.parse(url),
        headers: {
          'accept': 'text/plain',
          'Authorization': 'Bearer $accesstoken',
          'Content-Type': ' application/json'
        },
        body: payload);
    if (response.statusCode == 201) {
      return successModelFromJson(response.body);
    } else if (response.statusCode == 402) {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) {
          return const ErrorAlertDialog(
              content: 'ທ່ານໄດ້ສົ່ງເງິນໃຫ້ Meesooklife4289 ແລ້ວ',
              icon: MyImages.erroricon);
        },
      );
    } else {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) {
          return const ErrorAlertDialog(
              content:
                  'ຂໍອະໄພ ການສົ່ງເງິນໃຫ້Meesooklifeບໍ່ສຳເລັດ ກະລຸນາລອງໃໝ່ອີກຄັ້ງ',
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
