import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:meesooklife_app/constant/api.dart';

import '../constant/image.dart';
import '../screen/model/address_model.dart';
import '../widget/alert_diog/alert_error.dart';

Future<AddressModel?> addressModel(
    BuildContext context, String accessToken) async {
  String url = PathAPI.ADDRESS;
  try {
    var response = await http.get(Uri.parse(url), headers: {
      'accept': 'text/plain',
      'Authorization': 'Bearer $accessToken'
    });
    if (response.statusCode == 200) {
      return addressModelFromJson(response.body);
    } else {
      print('not success ${response.statusCode} ${response.body}}');
    }
  } catch (e) {
    return await addressModelExpectOne(context, accessToken);
  }
}

Future<AddressModel?> addressModelExpectOne(
    BuildContext context, String accessToken) async {
  String url = PathAPI.ADDRESS;
  try {
    var response = await http.get(Uri.parse(url), headers: {
      'accept': 'text/plain',
      'Authorization': 'Bearer $accessToken'
    });
    if (response.statusCode == 200) {
      return addressModelFromJson(response.body);
    } else {
      print('not success ${response.statusCode} ${response.body}}');
    }
  } catch (e) {
    return await addressModelExpectTwo(context, accessToken);
  }
}

Future<AddressModel?> addressModelExpectTwo(
    BuildContext context, String accessToken) async {
  String url = PathAPI.ADDRESS;
  try {
    var response = await http.get(Uri.parse(url), headers: {
      'accept': 'text/plain',
      'Authorization': 'Bearer $accessToken'
    });
    if (response.statusCode == 200) {
      return addressModelFromJson(response.body);
    } else {
      print('not success ${response.statusCode} ${response.body}}');
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
