import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meesooklife_app/constant/api.dart';
import 'package:meesooklife_app/constant/image.dart';
import 'package:meesooklife_app/screen/model/connect_token_model.dart';
import 'package:meesooklife_app/widget/alert_diog/alert_error.dart';

Future<ConnectTokenModel?> connectToken(
    BuildContext context, String payload) async {
  String url = PathAPI.LOGIN;
  try {
    var response = await http.post(Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        },
        body: payload);
    if (response.statusCode == 200) {
      return connectTokenModelFromJson(response.body);
    } else if (response.statusCode == 401) {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) {
          return const ErrorAlertDialog(
              content:
                  'ຂໍອະໄພ \n ເບີໂທສະສັບ ຫຼື ລະຫັດຜ່ານບໍ່ຖືກຕ້ອງ ກະລຸນາປ້ອນໃໝ່ອີກຄັ້ງ',
              icon: MyImages.erroricon);
        },
      );
    } else if (response.statusCode == 402) {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) {
          return const ErrorAlertDialog(
              content:
                  'ຂໍອະໄພ \n ບັນຊີຂອງທ່ານຖືກປິດແລ້ວ ກະລຸນາຕິດຕໍ່ຫາບໍລິສັດ meesooklife2489',
              icon: MyImages.erroricon);
        },
      );
    } else {
      Navigator.pop(context);
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
    return await connectTokenExpectOne(context, payload);
  }
}

Future<ConnectTokenModel?> connectTokenExpectOne(
    BuildContext context, String payload) async {
  String url = PathAPI.LOGIN;
  try {
    var response = await http.post(Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        },
        body: payload);
    if (response.statusCode == 200) {
      return connectTokenModelFromJson(response.body);
    } else if (response.statusCode == 401) {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) {
          return const ErrorAlertDialog(
              content:
                  'ຂໍອະໄພ \n ເບີໂທສະສັບ ຫຼື ລະຫັດຜ່ານບໍ່ຖືກຕ້ອງ ກະລຸນາປ້ອນໃໝ່ອີກຄັ້ງ',
              icon: MyImages.erroricon);
        },
      );
    } else if (response.statusCode == 402) {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) {
          return const ErrorAlertDialog(
              content:
                  'ຂໍອະໄພ \n ບັນຊີຂອງທ່ານຖືກປິດແລ້ວ ກະລຸນາຕິດຕໍ່ຫາບໍລິສັດ meesooklife2489',
              icon: MyImages.erroricon);
        },
      );
    } else {
      Navigator.pop(context);
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
    return await connectTokenExpectTwo(context, payload);
  }
}

Future<ConnectTokenModel?> connectTokenExpectTwo(
    BuildContext context, String payload) async {
  String url = PathAPI.LOGIN;
  try {
    var response = await http.post(Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        },
        body: payload);
    if (response.statusCode == 200) {
      return connectTokenModelFromJson(response.body);
    } else if (response.statusCode == 401) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) {
          return const ErrorAlertDialog(
              content:
                  'ຂໍອະໄພ \n ເບີໂທສະສັບ ຫຼື ລະຫັດຜ່ານບໍ່ຖືກຕ້ອງ ກະລຸນາປ້ອນໃໝ່ອີກຄັ້ງ',
              icon: MyImages.erroricon);
        },
      );
    } else if (response.statusCode == 402) {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) {
          return const ErrorAlertDialog(
              content:
                  'ຂໍອະໄພ \n ບັນຊີຂອງທ່ານຖືກປິດແລ້ວ ກະລຸນາຕິດຕໍ່ຫາບໍລິສັດ meesooklife2489',
              icon: MyImages.erroricon);
        },
      );
    } else {
      Navigator.pop(context);
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
    Navigator.pop(context);
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
