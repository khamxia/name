import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meesooklife_app/constant/api.dart';
import 'package:meesooklife_app/screen/model/branch_model.dart';

import '../constant/image.dart';
import '../widget/alert_diog/alert_error.dart';

Future<BranchModel?> branchModel(
    BuildContext context, String accesstoken) async {
  String url = PathAPI.TOP_BRANCH;
  try {
    var response = await http.get(Uri.parse(url), headers: {
      'accept': 'text/plain',
      'Authorization': 'Bearer $accesstoken'
    });
    if (response.statusCode == 200) {
      return branchModelFromJson(response.body);
    } else {
      print('response error ${response.statusCode}');
    }
  } catch (e) {
    return await branchModelExpectOne(context, accesstoken);
  }
}

Future<BranchModel?> branchModelExpectOne(
    BuildContext context, String accesstoken) async {
  String url = PathAPI.TOP_BRANCH;
  try {
    var response = await http.get(Uri.parse(url), headers: {
      'accept': 'text/plain',
      'Authorization': 'Bearer $accesstoken'
    });
    if (response.statusCode == 200) {
      return branchModelFromJson(response.body);
    } else {
      print('response error ${response.statusCode}');
    }
  } catch (e) {
    return await branchModelExpectTwo(context, accesstoken);
  }
}

Future<BranchModel?> branchModelExpectTwo(
    BuildContext context, String accesstoken) async {
  String url = PathAPI.TOP_BRANCH;
  try {
    var response = await http.get(Uri.parse(url), headers: {
      'accept': 'text/plain',
      'Authorization': 'Bearer $accesstoken'
    });
    if (response.statusCode == 200) {
      return branchModelFromJson(response.body);
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
