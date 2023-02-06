import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meesooklife_app/constant/api.dart';
import 'package:meesooklife_app/screen/model/success_model.dart';
import '../constant/image.dart';
import '../widget/alert_diog/alert_error.dart';

Future<SuccessModel?> branchsetPayment(
    BuildContext context, String accesstoken, int money, File files) async {
  String url = PathAPI.USER_PAYMENT_BY_BRANCH;
  try {
    Map<String, String> token = {"Authorization": "Bearer $accesstoken"};
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(token);
    request.fields['money'] = money.toString();
    request.files.add(await http.MultipartFile.fromPath('image', files.path,
        filename: files.path.split('/').last));
    var response = await request.send();
    if (response.statusCode == 201) {
      String success = await response.stream.bytesToString();
      return successModelFromJson(success);
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
    return await branchsetPaymentExecptOne(context, accesstoken, money, files);
  }
}

Future<SuccessModel?> branchsetPaymentExecptOne(
    BuildContext context, String accesstoken, int money, File files) async {
  String url = PathAPI.USER_PAYMENT_BY_BRANCH;
  try {
    Map<String, String> token = {"Authorization": "Bearer $accesstoken"};
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(token);
    request.fields['money'] = money.toString();
    request.files.add(await http.MultipartFile.fromPath('qrcode', files.path,
        filename: files.path.split('/').last));
    var response = await request.send();
    if (response.statusCode == 201) {
      String success = await response.stream.bytesToString();
      return successModelFromJson(success);
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
    return await branchsetPaymentExpectTwo(context, accesstoken, money, files);
  }
}

Future<SuccessModel?> branchsetPaymentExpectTwo(
    BuildContext context, String accesstoken, int money, File files) async {
  String url = PathAPI.USER_PAYMENT_BY_BRANCH;
  try {
    Map<String, String> token = {"Authorization": "Bearer $accesstoken"};
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(token);
    request.fields['money'] = money.toString();
    request.files.add(await http.MultipartFile.fromPath('qrcode', files.path,
        filename: files.path.split('/').last));
    var response = await request.send();
    if (response.statusCode == 201) {
      String success = await response.stream.bytesToString();
      return successModelFromJson(success);
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
