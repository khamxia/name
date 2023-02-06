// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:meesooklife_app/business_provider/payment_provider.dart';
import 'package:meesooklife_app/business_provider/store_provider.dart';
import 'package:meesooklife_app/constant/routes.dart' as user_route;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:meesooklife_app/business_provider/login_provider.dart';
import 'package:meesooklife_app/business_provider/profile_provider.dart';
import 'package:meesooklife_app/screen/hero/hero_page.dart';
import 'package:meesooklife_app/widget/sheetmodel.dart';
import 'package:provider/provider.dart';
import '../../../constant/font.dart';
import '../../../constant/image.dart';
import '../../../constant/my_colors.dart';
import '../../../constant/theme.dart';

class StoreDetailPage extends StatefulWidget {
  const StoreDetailPage({super.key});

  @override
  State<StoreDetailPage> createState() => _StoreDetailPageState();
}

class _StoreDetailPageState extends State<StoreDetailPage> {
  File? pfiles;
  bool isEnabled = true;
  bool isBlock = true;

  final animationDuration = const Duration(milliseconds:0);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'ລາຍລະອຽດຮ້ານຄ້າ',
            style: appBarStyle(),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(gradient: MSLheme.appBarGradient),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, user_route.Route.updateqrcode)
                    .then((value) async {
                  await context.read<LoginProvider>().setUserDashboard(context);
                });
              },
              icon: const Icon(Icons.fit_screen_outlined,
                  color: MyColors.whiteColor),
            ),
            IconButton(
              onPressed: () {
                context.read<PaymentProvider>().setAddress(context);
                Navigator.pushNamed(
                        context, user_route.Route.updatebranchprofile)
                    .then((value) async {
                  await context.read<LoginProvider>().setUserDashboard(context);
                });
              },
              icon: const Icon(Icons.edit, color: MyColors.whiteColor),
            ),
          ],
        ),
        body: Consumer<LoginProvider>(
          builder: (context, loginmodel, _) {
            print('branch Status: ${loginmodel.getBStatus}');
            return Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    gradient: MSLheme.appBarGradient,
                  ),
                  width: double.infinity,
                  height: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            chooseSheet(
                              context,
                              () => chooseImage(context, ImageSource.camera),
                              () => chooseImage(context, ImageSource.gallery),
                            );
                          },
                          child: Stack(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    top: size.height * 0.05,
                                    bottom: size.height * 0.01),
                                width: 100.w,
                                height: 100.h,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 2, color: MyColors.tealColor),
                                  color: MyColors.whiteColor,
                                  shape: BoxShape.circle,
                                  image: pfiles == null
                                      ? DecorationImage(
                                          image: NetworkImage(loginmodel
                                              .getBranchLogo
                                              .toString()),
                                          fit: BoxFit.fill)
                                      : DecorationImage(
                                          image: FileImage(pfiles!),
                                        ),
                                ),
                              ),
                              Positioned(
                                left: 70.w,
                                top: 110.h,
                                child: CircleAvatar(
                                  backgroundColor: MyColors.whiteColor,
                                  radius: 13.r,
                                  child: Icon(
                                    Icons.photo_camera,
                                    size: 18.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.r),
                      topRight: Radius.circular(30.r),
                    ),
                  ),
                  width: double.infinity,
                  height: double.infinity,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              'ຂໍ້ມູນສ່ວນຕົວ:',
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: MyColors.blackColor),
                            ),
                          ),
                          Divider(thickness: 2.h),
                          Text(
                            'ທີ່ຢູ່:',
                            style: TextStyle(
                                color: MyColors.blackColor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400),
                          ),
                          buildTextSpan('ບ້ານ:  ',
                              '   ${loginmodel.getBVillage.toString()}'),
                          buildTextSpan('ເມືອງ:  ',
                              '  ${loginmodel.getBDistrict.toString()}'),
                          buildTextSpan('ເເຂວງ: ',
                              '  ${loginmodel.getBProvince.toString()}'),
                          Divider(thickness: 2.h),
                          SizedBox(height: 5.h),
                          RichText(
                            text: TextSpan(
                                text: 'ຈຳນວນເງິນຈາກການຊື້ສິນຄ້າ:',
                                style: TextStyle(
                                    color: MyColors.blackColor,
                                    fontSize: 14.sp,
                                    fontFamily: FONT_NOTOSANS),
                                children: [
                                  TextSpan(
                                      text:
                                          ' ${NumberFormat.currency(symbol: '', decimalDigits: 0).format(loginmodel.getMoneyBuy)} ກີບ',
                                      style: TextStyle(
                                          color: MyColors.cancelColor,
                                          fontSize: 16.sp,
                                          fontFamily: FONT_NOTOSANS)),
                                ]),
                          ),
                          SizedBox(height: 5.h),
                          RichText(
                            text: TextSpan(
                                text: 'ຈຳນວນເງິນຈາກການຂາຍສິນຄ້າ:',
                                style: TextStyle(
                                    color: MyColors.blackColor,
                                    fontSize: 14.sp,
                                    fontFamily: FONT_NOTOSANS),
                                children: [
                                  TextSpan(
                                      text:
                                          ' ${NumberFormat.currency(symbol: '', decimalDigits: 0).format(loginmodel.getMoneySale)} ກີບ',
                                      style: TextStyle(
                                          color: MyColors.cancelColor,
                                          fontSize: 16.sp,
                                          fontFamily: FONT_NOTOSANS)),
                                ]),
                          ),
                          SizedBox(height: 5.h),
                          Divider(thickness: 2.h),
                          Text(
                            'RQCode ແລະ ເລກບັນຊີທະນາຄານ:',
                            style: TextStyle(
                                color: MyColors.blackColor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(height: 5.h),
                          Row(
                            children: [
                              GestureDetector(
                                child: Card(
                                  child: loginmodel.getBranchQR.isEmpty
                                      ? Image.asset(MyImages.loading)
                                      : Hero(
                                          tag: 'imageHero',
                                          child: Image.network(
                                            loginmodel.getBranchQR,
                                            width: 100.w,
                                            height: 120.h,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                ),
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HeroPages(
                                            images: loginmodel.getBranchQR))),
                              ),
                              SizedBox(width: 5.w),
                              Expanded(
                                child: TextFormField(
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                        Icons.account_balance_outlined),
                                    fillColor: MyColors.whiteColor,
                                    isDense: true,
                                    hintText:
                                        '${loginmodel.getBBankAcount.toString()}',
                                    hintStyle: TextStyle(
                                        color: MyColors.hintColor,
                                        fontSize: 14.sp,
                                        fontFamily: FONT_NOTOSANS),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                      borderSide: const BorderSide(
                                        color: MyColors.hoverColors,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                      borderSide: const BorderSide(
                                        color: MyColors.hoverColors,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Divider(thickness: 2.h),
                          Text(
                            'ເປີດ ແລະ ປິດຮ້ານຄ້າ:',
                            style: TextStyle(
                                color: MyColors.blackColor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400),
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  await context
                                      .read<StoreProvider>()
                                      .setBranchCloseOnpen(context)
                                      .then((value) {
                                    loginmodel.setUserDashboard(context);
                                  });
                                  setState(() {
                                    isBlock = !isBlock;
                                    isEnabled == false;
                                  });
                                  print('isBlock: $isBlock');
                                  print('isEnabled: $isEnabled');
                                },
                                child: AnimatedContainer(
                                  height: 40.h,
                                  width: 70.w,
                                  duration: animationDuration,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: isEnabled == true
                                        ? loginmodel.getBStatus == 1
                                            ? MyColors.succcessColors
                                            : MyColors.hintColor
                                        : isBlock == true
                                            ? MyColors.succcessColors
                                            : MyColors.hintColor,
                                    border: Border.all(
                                        color: Colors.white, width: 2.w),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade400,
                                        spreadRadius: 2.r,
                                        blurRadius: 10.r,
                                      ),
                                    ],
                                  ),
                                  child: AnimatedAlign(
                                    duration: animationDuration,
                                    alignment: isEnabled == true
                                        ? loginmodel.getBStatus == 1
                                            ? Alignment.centerRight
                                            : Alignment.centerLeft
                                        : isBlock == true
                                            ? Alignment.centerRight
                                            : Alignment.centerLeft,

                                    //  Alignment.centerRight
                                    // : Alignment.centerLeft,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 2.w),
                                      child: Container(
                                        width: 30.w,
                                        height: 30.h,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: MyColors.whiteColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: Text(
                                    isEnabled == true
                                        ? loginmodel.getBStatus == 1
                                            ? '(ຮ້ານຄ້າຂອງທ່ານເປີດແລ້ວ)'
                                            : '(ຮ້ານຄ້າຂອງທ່ານປິດແລ້ວ)'
                                        : isBlock == true
                                            ? '(ຮ້ານຄ້າຂອງທ່ານເປີດແລ້ວ)'
                                            : '(ຮ້ານຄ້າຂອງທ່ານປິດແລ້ວ)',
                                    // '(ຮ້ານຄ້າຂອງທ່ານຍັງເປີດເປັນປະຈຳ)'
                                    // : '(ຮ້ານຄ້າຂອງທ່ານປິດແລ້ວ)',
                                    style: TextStyle(
                                      color: isEnabled == true
                                          ? loginmodel.getBStatus == 1
                                              ? MyColors.succcessColors
                                              : MyColors.cancelColor
                                          : isBlock == true
                                              ? MyColors.succcessColors
                                              : MyColors.cancelColor,
                                      // ? MyColors.succcessColors
                                      // : MyColors.cancelColor,
                                      fontSize: 14.sp,
                                    )),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ));
  }

  Widget buildTextSpan(String title, String subtitle) {
    return RichText(
      text: TextSpan(
        text: title,
        style: TextStyle(
            color: MyColors.blackColor,
            fontFamily: FONT_NOTOSANS,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400),
        children: [
          TextSpan(
              text: subtitle,
              style: const TextStyle(
                  color: MyColors.hintColor, fontFamily: FONT_NOTOSANS)),
        ],
      ),
    );
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
        await context
            .read<ProfileProvider>()
            .setUpdateBranchLogo(context, pfiles!);
      }
    } catch (e) {
      rethrow;
    }
  }
}
