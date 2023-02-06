// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:meesooklife_app/business_provider/store_provider.dart';
import 'package:meesooklife_app/constant/font.dart';
import 'package:meesooklife_app/constant/my_colors.dart';
import 'package:meesooklife_app/constant/theme.dart';
import 'package:meesooklife_app/business_provider/login_provider.dart';
import 'package:meesooklife_app/screen/profile/edit_profile.dart';
import 'package:meesooklife_app/widget/sheetmodel.dart';
import 'package:meesooklife_app/widget/text_button.dart';
import 'package:meesooklife_app/constant/routes.dart' as user_route;
import 'package:provider/provider.dart';

import '../../business_provider/payment_provider.dart';
import '../../utilities/clear_sharepref.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? pfiles;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        bottomSheet: Padding(
          padding: EdgeInsets.all(10.0.r),
          child: MSLButton(
              text: 'ອອກຈາກລະບົບ',
              onpressed: () async {
                Navigator.pushNamedAndRemoveUntil(
                    context, user_route.Route.logout, (route) => false);
                await clearShatePref(context);
              }),
        ),
        appBar: AppBar(
          elevation: 10,
          title: Text('ຂໍ້ມູນສ່ວນຕົວ', style: appBarStyle()),
          flexibleSpace: Container(
            decoration: const BoxDecoration(gradient: MSLheme.appBarGradient),
          ),
          actions: [
            IconButton(
              onPressed: () {
                context.read<PaymentProvider>().setAddress(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditProfile(),
                    )).then((val) {
                  context.read<LoginProvider>().setUserDashboard(context);
                });
              },
              icon: const Icon(
                Icons.edit,
                color: MyColors.whiteColor,
              ),
            )
          ],
        ),
        body: Consumer<LoginProvider>(
          builder: (context, models, _) {
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
                            chooseSheet(context, () {
                              chooseImage(context, ImageSource.camera);
                            }, () {
                              chooseImage(context, ImageSource.gallery);
                            });
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
                                          image: NetworkImage(
                                              models.getImage.toString()),
                                        )
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
                        Text(
                          '${models.getFname.toString()} ${models.getLname.toString()}',
                          style: TextStyle(
                              color: MyColors.whiteColor, fontSize: 16.sp),
                        ),
                        Text(
                          models.getNumberPhone.toString(),
                          style: const TextStyle(color: MyColors.whiteColor),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.28),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'ຂໍ້ມູນສ່ວນຕົວ:',
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.w400),
                          ),
                        ),
                        Divider(thickness: 2.h),
                        const Text('ທີ່ຢູ່:'),
                        buildTextSpan(
                            'ບ້ານ:  ', '   ${models.getVillage.toString()}'),
                        buildTextSpan(
                            'ເມືອງ:  ', '  ${models.getDistrict.toString()}'),
                        buildTextSpan(
                            'ເເຂວງ: ', '  ${models.getProvince.toString()}'),
                        Divider(thickness: 2.h),
                        SizedBox(height: 10.h),
                        const Text('ຈຳນວນເງິນ:'),
                        Text(
                          '${NumberFormat.currency(symbol: '', decimalDigits: 0).format(int.tryParse(models.getMoneyBuy.toString()))} ກີບ',
                          style: TextStyle(
                              color: MyColors.cancelColor, fontSize: 16.sp),
                        ),
                        SizedBox(height: 10.h),
                        Divider(thickness: 2.h),
                      ],
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
              style: const TextStyle(color: MyColors.hintColor)),
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
        await context.read<StoreProvider>().setUpdateUserP(context, pfiles!);
      }
    } catch (e) {
      rethrow;
    }
  }
}
