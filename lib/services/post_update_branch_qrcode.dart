import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meesooklife_app/constant/api.dart';
import 'package:meesooklife_app/screen/model/success_model.dart';
import '../constant/image.dart';
import '../widget/alert_diog/alert_error.dart';

Future<SuccessModel?> updateBranchQRCode(BuildContext context,
    String accesstoken, int bankAcount, File files) async {
  String url = PathAPI.UPDATE_QRCODE;
  try {
    Map<String, String> token = {"Authorization": "Bearer $accesstoken"};
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(token);
    request.fields['bcelone_number'] = bankAcount.toString();
    request.files.add(await http.MultipartFile.fromPath('qrcode', files.path,
        filename: files.path.split('/').last));
    print('fields ${request.fields}');
    print('files ${request.files}');
    var response = await request.send();
    if (response.statusCode == 201) {
      String responseString = await response.stream.bytesToString();
      return successModelFromJson(responseString);
    } else {
      print('response error ${response.statusCode}');
    }
  } catch (e) {
    return await updateBranchQRCodeExpectTWo(
        context, accesstoken, bankAcount, files);
  }
}

Future<SuccessModel?> updateBranchQRCodeExpectOne(BuildContext context,
    String accesstoken, int bankAcount, File files) async {
  String url = PathAPI.UPDATE_QRCODE;
  try {
    Map<String, String> token = {"Authorization": "Bearer $accesstoken"};
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(token);
    request.fields['bcelone_number'] = bankAcount.toString();
    request.files.add(await http.MultipartFile.fromPath('qrcode', files.path,
        filename: files.path.split('/').last));
    var response = await request.send();
    if (response.statusCode == 201) {
    } else {
      print('response error ${response.statusCode}');
    }
  } catch (e) {
    return await updateBranchQRCodeExpectTWo(
        context, accesstoken, bankAcount, files);
  }
}

Future<SuccessModel?> updateBranchQRCodeExpectTWo(BuildContext context,
    String accesstoken, int bankAcount, File files) async {
  String url = PathAPI.UPDATE_QRCODE;
  try {
    Map<String, String> token = {"Authorization": "Bearer $accesstoken"};
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(token);
    request.fields['bcelone_number'] = bankAcount.toString();
    request.files.add(await http.MultipartFile.fromPath('qrcode', files.path,
        filename: files.path.split('/').last));
    var response = await request.send();
    if (response.statusCode == 201) {
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
