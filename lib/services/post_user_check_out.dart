import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:meesooklife_app/constant/api.dart';
import 'package:meesooklife_app/screen/model/success_model.dart';

Future<SuccessModel?> userCheckOut(
    BuildContext context,
    String accessToken,
    int expId,
    int bId,
    double total,
    int pID,
    int disID,
    int villID,
    List<Map<String, dynamic>> items,
    File _files) async {
  String url = PathAPI.USER_CHECK_OUT;
  try {
    FormData formData = FormData.fromMap({
      "exprese_id": expId,
      "branch_id": bId,
      "total": total,
      "pr_id": pID,
      "dr_id": disID,
      "vill_id": villID,
      "items": items,
      "image": await MultipartFile.fromFile(_files.path,
          filename: _files.path.split('/').last),
    });
    print('formData ${formData.fields}');
    print('formData ${formData.files}');
    var response = await Dio().post(url,
        data: formData,
        options: Options(headers: {
          "accept": "text/plain",
          "Authorization": "Bearer $accessToken",
          "Content-Type": "application/json"
        }));
    if (response.statusCode == 201) {
      print(' userCheckOut success ${response.statusCode}');
      return SuccessModel.fromJson(response.data);
    } else {
      print('error userCheckOut ${response.statusCode}');
    }
  } catch (e) {
    return await userCheckOutExectOne(context, accessToken, expId, bId, total,
        pID, disID, villID, items, _files);
  }
}

Future<SuccessModel?> userCheckOutExectOne(
    BuildContext context,
    String accessToken,
    int expId,
    int bId,
    double total,
    int pID,
    int disID,
    int villID,
    List<Map<String, dynamic>> items,
    File _files) async {
  String url = PathAPI.USER_CHECK_OUT;
  try {
    FormData formData = FormData.fromMap({
      "exprese_id": expId,
      "branch_id": bId,
      "total": total,
      "pr_id": pID,
      "dr_id": disID,
      "vill_id": villID,
      "items": items,
      "image": await MultipartFile.fromFile(_files.path,
          filename: _files.path.split('/').last),
    });
    var response = await Dio().post(url,
        data: formData,
        options: Options(headers: {
          "accept": "text/plain",
          "Authorization": "Bearer $accessToken",
          "Content-Type": "application/json"
        }));
    if (response.statusCode == 201) {
      return SuccessModel.fromJson(response.data);
    } else {
      print('error userCheckOut ${response.statusCode}');
    }
  } catch (e) {
    return await userCheckOutExpectTwo(context, accessToken, expId, bId, total,
        pID, disID, villID, items, _files);
  }
}

Future<SuccessModel?> userCheckOutExpectTwo(
    BuildContext context,
    String accessToken,
    int expId,
    int bId,
    double total,
    int pID,
    int disID,
    int villID,
    List<Map<String, dynamic>> items,
    File _files) async {
  String url = PathAPI.USER_CHECK_OUT;
  try {
    FormData formData = FormData.fromMap({
      "exprese_id": expId,
      "branch_id": bId,
      "total": total,
      "pr_id": pID,
      "dr_id": disID,
      "vill_id": villID,
      "items": items,
      "image": await MultipartFile.fromFile(_files.path,
          filename: _files.path.split('/').last),
    });
    var response = await Dio().post(url,
        data: formData,
        options: Options(headers: {
          "accept": "text/plain",
          "Authorization": "Bearer $accessToken",
          "Content-Type": "application/json"
        }));
    if (response.statusCode == 201) {
      return SuccessModel.fromJson(response.data);
    } else {
      print('error userCheckOut ${response.statusCode}');
    }
  } catch (e) {
    print('errrrrrrrrrrr $e');
    rethrow;
    // showDialog(
    //   context: context,
    //   builder: (context) {
    //     return const ErrorAlertDialog(
    //         content: 'ຂໍອະໄພເກີດຂໍ້ຜິດພາດ ກະລຸນາລອງໃໝ່ອີກຄັ້ງ',
    //         icon: MyImages.erroricon);
    //   },
    // );
  }
}
