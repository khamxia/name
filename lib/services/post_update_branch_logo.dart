import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constant/api.dart';
import '../constant/image.dart';
import '../screen/model/success_model.dart';
import '../widget/alert_diog/alert_error.dart';

Future<SuccessModel?> updateBranchLogo(
    BuildContext context, String accesstoken, File files) async {
  String url = PathAPI.UPDATE_BRANCH_LOGO;
  try {
    Map<String, String> token = {"Authorization": "Bearer $accesstoken"};
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(token);
    request.files.add(await http.MultipartFile.fromPath('logo', files.path,
        filename: files.path.split('/').last));
    var response = await request.send();
    if (response.statusCode == 201) {
      String success = await response.stream.bytesToString();
      return successModelFromJson(success);
    } else {
      print('response error ${response.statusCode}');
    }
  } catch (e) {
    return await updateBranchLogoExpectOne(context, accesstoken, files);
  }
}

Future<SuccessModel?> updateBranchLogoExpectOne(
    BuildContext context, String accesstoken, File files) async {
  String url = PathAPI.UPDATE_BRANCH_LOGO;
  try {
    Map<String, String> token = {"Authorization": "Bearer $accesstoken"};
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(token);
    request.files.add(await http.MultipartFile.fromPath('image', files.path,
        filename: files.path.split('/').last));
    var response = await request.send();
    if (response.statusCode == 201) {
      print('success  update profile ${response.statusCode}');
    } else {
      print('response error ${response.statusCode}');
    }
  } catch (e) {
    return await updateBranchLogoExpectTWo(context, accesstoken, files);
  }
}

Future<SuccessModel?> updateBranchLogoExpectTWo(
    BuildContext context, String accesstoken, File files) async {
  String url = PathAPI.UPDATE_BRANCH_LOGO;
  try {
    Map<String, String> token = {"Authorization": "Bearer $accesstoken"};
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(token);
    request.files.add(await http.MultipartFile.fromPath('image', files.path,
        filename: files.path.split('/').last));
    var response = await request.send();
    if (response.statusCode == 201) {
      print('success  update profile ${response.statusCode}');
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
