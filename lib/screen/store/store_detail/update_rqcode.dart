import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meesooklife_app/business_provider/login_provider.dart';
import 'package:meesooklife_app/business_provider/profile_provider.dart';
import 'package:meesooklife_app/constant/image.dart';
import 'package:meesooklife_app/widget/alert_diog/alert_error.dart';
import 'package:meesooklife_app/widget/sheetmodel.dart';
import 'package:meesooklife_app/widget/text_button.dart';
import 'package:provider/provider.dart';
import '../../../constant/font.dart';
import '../../../constant/my_colors.dart';
import '../../../constant/theme.dart';

class UpdateQRCode extends StatefulWidget {
  const UpdateQRCode({super.key});

  @override
  State<UpdateQRCode> createState() => _UpdateQRCodeState();
}

class _UpdateQRCodeState extends State<UpdateQRCode> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();
  File? qrcodefile;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomSheet: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          child: MSLButton(
              text: 'ບັນທຶກ',
              onpressed: () async {
                if (_formKey.currentState!.validate()) {
                  // ignore: unrelated_type_equality_checks
                  if (int.parse(controller.text) !=
                      context.read<LoginProvider>().getBBankAcount) {
                    if (qrcodefile != null) {
                      await context
                          .read<ProfileProvider>()
                          .setUpdateBranchQRCode(
                              context, int.parse(controller.text), qrcodefile!);
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return const ErrorAlertDialog(
                              content: 'ກະລຸນາປ່ຽນ QRCode ໃໝ່ \nຂໍຂອບໃຈ',
                              icon: MyImages.erroricon);
                        },
                      );
                    }
                  } else if (int.parse(controller.text) ==
                      context.read<LoginProvider>().getBBankAcount) {
                    if (qrcodefile != null) {
                      await context
                          .read<ProfileProvider>()
                          .setUpdateBranchQRCode(
                              context, int.parse(controller.text), qrcodefile!);
                    } else {
                      Navigator.pop(context);
                    }
                  }
                }
              }),
        ),
        appBar: AppBar(
          title: Text(
            'ເເກ້ໄຂເລກບັນຊີ ແລະ QRCode',
            style: appBarStyle(),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(gradient: MSLheme.appBarGradient),
          ),
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          behavior: HitTestBehavior.opaque,
          child: Consumer<LoginProvider>(
            builder: (context, logmodels, _) {
              controller.text = logmodels.getBBankAcount.toString();

              return SingleChildScrollView(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'ຮູບພາບ QRCode',
                        style: TextStyle(
                            fontSize: 15.sp, fontWeight: FontWeight.w500),
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
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
                                  borderRadius: BorderRadius.circular(8.r),
                                  border: Border.all(
                                      color: MyColors.hoverColors, width: 1.w)),
                              child: Container(
                                width: 150.w,
                                height: 200.h,
                                margin: EdgeInsets.symmetric(
                                    vertical: 40.h, horizontal: 40.w),
                                decoration: BoxDecoration(
                                  color: MyColors.whiteColor,
                                  borderRadius: BorderRadius.circular(8.r),
                                  image: qrcodefile == null
                                      ? DecorationImage(
                                          image: NetworkImage(
                                              logmodels.getBranchQR),
                                          fit: BoxFit.fill)
                                      : DecorationImage(
                                          image: FileImage(qrcodefile!),
                                          fit: BoxFit.fill),
                                ),
                              ),
                            ),
                          )),
                      Text(
                        'ເລກບັນຊີທະນາຄານ',
                        style: TextStyle(
                            fontSize: 15.sp, fontWeight: FontWeight.w500),
                      ),
                      Form(
                        key: _formKey,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: TextFormField(
                            maxLength: 18,
                            controller: controller,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.account_balance,
                              ),
                              fillColor: MyColors.whiteColor,
                              counterText: '',
                              isDense: true,
                              hintStyle:
                                  const TextStyle(color: MyColors.hintColor),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: MyColors.hoverColors),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: MyColors.hoverColors),
                                  borderRadius: BorderRadius.circular(8.r)),
                              errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: MyColors.hoverColors),
                                  borderRadius: BorderRadius.circular(8.r)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: MyColors.hoverColors),
                                  borderRadius: BorderRadius.circular(8.r)),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'ກະລຸນາປ້ອນເລກບັນຊີທະນາຄານ';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }

  Future<void> chooseImage(BuildContext context, ImageSource source) async {
    ImagePicker imagePicker = ImagePicker();
    try {
      XFile? images = await imagePicker.pickImage(source: source);

      if (images != null) {
        setState(() {
          qrcodefile = File(images.path);
          Navigator.pop(context);
        });
      }
    } catch (e) {
      rethrow;
    }
  }
}
