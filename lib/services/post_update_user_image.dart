import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meesooklife_app/constant/api.dart';
import 'package:meesooklife_app/screen/model/success_model.dart';
import '../constant/image.dart';
import '../widget/alert_diog/alert_error.dart';

Future<SuccessModel?> updateUserImage(
    BuildContext context, String accesstoken, File files) async {
  String url = PathAPI.UPDATE_USER_IMAGE;
  try {
    Map<String, String> token = {"Authorization": "Bearer $accesstoken"};
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(token);
    request.files.add(await http.MultipartFile.fromPath('image', files.path,
        filename: files.path.split('/').last));
        
    var response = await request.send();
    if (response.statusCode == 200) {
      print('success  update profile ${response.statusCode}');
    } else {
      print('response error ${response.statusCode}');
    }
  } catch (e) {
    return await updateUserImageExpectOne(context, accesstoken, files);
  }
}

Future<SuccessModel?> updateUserImageExpectOne(
    BuildContext context, String accesstoken, File files) async {
  String url = PathAPI.UPDATE_USER_IMAGE;
  try {
    Map<String, String> token = {"Authorization": "Bearer $accesstoken"};
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(token);
    request.files.add(await http.MultipartFile.fromPath('image', files.path,
        filename: files.path.split('/').last));
    var response = await request.send();
    if (response.statusCode == 200) {
      print('success  update profile ${response.statusCode}');
    } else {
      print('response error ${response.statusCode}');
    }
  } catch (e) {
    return await updateUserImageExpectTWo(context, accesstoken, files);
  }
}

Future<SuccessModel?> updateUserImageExpectTWo(
    BuildContext context, String accesstoken, File files) async {
  String url = PathAPI.UPDATE_USER_IMAGE;
  try {
    Map<String, String> token = {"Authorization": "Bearer $accesstoken"};
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(token);
    request.files.add(await http.MultipartFile.fromPath('image', files.path,
        filename: files.path.split('/').last));
    var response = await request.send();
    if (response.statusCode == 200) {
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
