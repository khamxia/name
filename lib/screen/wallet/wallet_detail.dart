import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:meesooklife_app/constant/image.dart';
import 'package:meesooklife_app/constant/my_colors.dart';
import 'package:meesooklife_app/widget/alert_diog/alert_error.dart';
import 'package:provider/provider.dart';

import '../../business_provider/wallet_provider.dart';
import '../../constant/font.dart';
import '../../constant/theme.dart';
import '../../widget/sheetmodel.dart';

class WalletDetailPage extends StatefulWidget {
  const WalletDetailPage({super.key});

  @override
  State<WalletDetailPage> createState() => _WalletDetailPageState();
}

class _WalletDetailPageState extends State<WalletDetailPage> {
  File? pfiles;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomSheet: Container(
          width: double.infinity,
          decoration: const BoxDecoration(gradient: MSLheme.appBarGradient),
          child: TextButton(
            onPressed: () {
              if (pfiles != null) {
                context.read<WalletProvider>().setBranchsetPayment(
                    context,
                    context
                        .read<WalletProvider>()
                        .getbranchrwalletModel!
                        .userWallet!
                        .moneySale,
                    pfiles!);
              } else {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const ErrorAlertDialog(
                        content:
                            'ຂໍອະໄພ ກະລຸນາສົ່ງຫຼັກຖານການໂອນເງິນພ້ອມ \n ຂໍຂອບໃຈ',
                        icon: MyImages.erroricon);
                  },
                );
              }
            },
            child: Text(
              'ສົ່ງເງິນ',
              style: TextStyle(
                  color: MyColors.whiteColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
        appBar: AppBar(
            title: Text(
              'ລາຍລະອຽດການສົ່ງເງິນ',
              style: appBarStyle(),
            ),
            flexibleSpace: Container(
              decoration: const BoxDecoration(gradient: MSLheme.appBarGradient),
            )),
        body: SafeArea(
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
                child: Consumer<WalletProvider>(
                  builder: (context, value, _) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ຈຳນວນເງິນທີ່ຈະສົ່ງໃຫ້ທາງບໍລິສັດ Meesooklife4289',
                          style: TextStyle(
                            color: MyColors.blackColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                          ),
                        ),
                        Text(
                          '${NumberFormat.currency(symbol: '', decimalDigits: 0).format(value.getbranchrwalletModel!.userWallet!.moneySale)} ກີບ',
                          style: TextStyle(
                            color: MyColors.cancelColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 16.sp,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text('ຫຼັກຖານການສົ່ງເງິນ',
                            style: TextStyle(
                              color: MyColors.blackColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                            )),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: MyColors.hoverColors),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            height: 200.h,
                            width: double.infinity,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20.h, horizontal: 110.w),
                              child: InkWell(
                                onTap: () {
                                  chooseSheet(context, () {
                                    chooseImage(context, ImageSource.camera);
                                  }, () {
                                    chooseImage(context, ImageSource.gallery);
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: MyColors.hoverColors),
                                    borderRadius: BorderRadius.circular(10.r),
                                    image: pfiles == null
                                        ? const DecorationImage(
                                            opacity: 0.5,
                                            image: AssetImage(MyImages.gallery),
                                            fit: BoxFit.fill)
                                        : DecorationImage(
                                            image: FileImage(pfiles!),
                                            fit: BoxFit.fill),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ))));
  }

  Future<void> chooseImage(BuildContext context, ImageSource source) async {
    ImagePicker imagePicker = ImagePicker();
    try {
      XFile? images = await imagePicker.pickImage(source: source);
      if (images != null) {
        setState(() {
          pfiles = File(images.path);
          Navigator.pop(context);
        });
      }
    } catch (e) {
      rethrow;
    }
  }
}
