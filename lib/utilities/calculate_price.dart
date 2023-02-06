import 'package:flutter/material.dart';
import 'package:meesooklife_app/constant/image.dart';
import 'package:meesooklife_app/constant/my_colors.dart';
import 'package:meesooklife_app/database/user_database/sqlite_database.dart';
import 'package:meesooklife_app/database/user_database/sqlite_model.dart';
import 'package:meesooklife_app/widget/alert_diog/alert_error.dart';
import 'package:toast/toast.dart';


Future<void> calculatePrice(
    BuildContext context,
    int prId,
    String prName,
    int pramount,
    String category,
    int price,
    int brId,
    String branchNames) async {
  int total = 0;
  total = pramount * price;
  int chId = 0;

  Map<String, dynamic> map = Map();

  map['productId'] = prId.toString();
  map['productName'] = prName;
  map['amount'] = pramount.toString();
  map['category'] = category;
  map['price'] = (price..toInt()).toString();
  map['total'] = (total.toInt()).toString();
  map['branchId'] = brId.toString();
  map['branchName'] = branchNames;
  SQLiteModel sqLiteModel = SQLiteModel.fromJson(map);
  var checkId = await SQLiteHelper().readData();
  if (checkId.length == 0 && checkId.isEmpty) {
    await SQLiteHelper().insertData(sqLiteModel).then((value) {
      Navigator.pop(context);
      showMessage(context, 'ເພີ່ມສິນຄ້າສຳເລັດແລ້ວ');
    });
  } else {
    // create
    // read
    // read all select * from tb_carts
    // read single product select * from tb_carts where product_id = id
    // update
    // delete

    // carts []
    // insert
    // carts [1]
    // sqlite where product_id = 1;
    // id 1 == carts [1]  update
    // insert
    String branch_id = checkId.first.branchId.toString();
    if (int.parse(branch_id) == brId) {
      var singles = await SQLiteHelper().readDataSingle(prId);
      if (singles.isNotEmpty) {
        int id = int.parse(singles.first.id.toString());
        int namount = int.parse(singles.first.amount.toString()) + pramount;
        int ntotal = namount * price;
        await SQLiteHelper()
            .updateAmountAndTotal(
                prId.toString(), namount.toString(), ntotal.toString())
            .then((value) {
          Navigator.pop(context);
          showMessage(context, 'ເພີ່ມສິນຄ້າສຳເລັດແລ້ວ');
        });
      } else {
        await SQLiteHelper().insertData(sqLiteModel).then((value) {
          Navigator.pop(context);
          showMessage(context, 'ເພີ່ມສິນຄ້າສຳເລັດແລ້ວ');
        });
      }
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return ErrorAlertDialog(
              content:
                  'ຂໍອະໄພ ທ່ານຍັງມີລາຍການສັ່ງຊື້ທີ່ຍັງຄ້າງຢູ່ (${checkId.first.branchName}) ກະລຸນາເຂົ້າໄປສັ່ງຊື້ ຫຼື ຍົກເລີກການສັ່ງຊື້ກ່ອນ\n ຂໍຂອບໃຈ',
              icon: MyImages.erroricon);
        },
      );
    }
  }
}

void showMessage(BuildContext context, String title) async {
  ToastContext().init(context);
  Toast.show(title, duration: Toast.lengthLong, gravity: Toast.bottom);
}

void showMessageSuccess(BuildContext context, String title) async {
  ToastContext().init(context);
  Toast.show(title,
      duration: Toast.lengthLong,
      gravity: Toast.bottom,
      backgroundColor: MyColors.succcessColors,
      textStyle: const TextStyle(color: MyColors.whiteColor));
}
