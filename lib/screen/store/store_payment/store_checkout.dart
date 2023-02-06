import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:meesooklife_app/business_provider/login_provider.dart';
import 'package:meesooklife_app/business_provider/payment_provider.dart';
import 'package:meesooklife_app/business_provider/store_provider.dart';
import 'package:meesooklife_app/constant/font.dart';
import 'package:meesooklife_app/constant/my_colors.dart';
import 'package:meesooklife_app/screen/model/member_model.dart';
import 'package:meesooklife_app/widget/text_button.dart';
import 'package:provider/provider.dart';
import '../../../constant/theme.dart';

class StoreCheckOut extends StatefulWidget {
  const StoreCheckOut({super.key});

  @override
  State<StoreCheckOut> createState() => _StoreCheckOutState();
}

class _StoreCheckOutState extends State<StoreCheckOut> {
  final _formKey = GlobalKey<FormState>();
  bool isCheck = true;
  String chooseType = 'cash';
  File? file;
  int userId = 0;
  List<Map<String, dynamic>> itemsModel = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'ລາຍການສັ່ງຊື້',
            style: appBarStyle(),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: MSLheme.appBarGradient,
            ),
          ),
        ),
        body: Consumer3<PaymentProvider, StoreProvider, LoginProvider>(
          builder: (context, payvalue, storeModel, loginmodel, _) {
            return payvalue.getSqliteStoreModel.isEmpty
                ? Center(
                    child: Text(
                      'ຍັງບໍ່ມີລາຍການສິນຄ້າ',
                      style: TextStyle(
                          color: MyColors.hintColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp),
                    ),
                  )
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 20, bottom: 60),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'ຊື່ສິນຄ້າ',
                                  style: TextStyle(
                                      color: MyColors.blueColor,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'ລາຄາ',
                                  style: TextStyle(
                                      color: MyColors.blueColor,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'ຈຳນວນ',
                                  style: TextStyle(
                                      color: MyColors.blueColor,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'ລາຄາລວມ',
                                  style: TextStyle(
                                      color: MyColors.blueColor,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              const Expanded(
                                flex: 1,
                                child: SizedBox(),
                              ),
                            ],
                          ),
                          const Divider(
                            thickness: 1,
                            color: MyColors.blackColor,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: payvalue.getSqliteStoreModel.length,
                              itemBuilder: (context, index) {
                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        payvalue.getSqliteStoreModel[index]
                                            .productName
                                            .toString(),
                                        maxLines: 2,
                                        style: const TextStyle(
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        NumberFormat.currency(
                                                symbol: '', decimalDigits: 0)
                                            .format(int.parse(payvalue
                                                .getSqliteStoreModel[index]
                                                .price
                                                .toString())),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        payvalue
                                            .getSqliteStoreModel[index].amount
                                            .toString(),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        NumberFormat.currency(
                                                symbol: '', decimalDigits: 0)
                                            .format(int.parse(payvalue
                                                .getSqliteStoreModel[index]
                                                .total
                                                .toString())),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: InkWell(
                                        onTap: () async {
                                          await payvalue
                                              .sqliteStoreDeletes(
                                                  context,
                                                  payvalue
                                                      .getSqliteStoreModel[
                                                          index]
                                                      .id!)
                                              .then((value) {
                                            payvalue
                                                .setStoreTotalPrice = payvalue
                                                    .getStoreTotalPrice -
                                                int.parse(payvalue
                                                    .getSqliteStoreModel[index]
                                                    .total
                                                    .toString());
                                            payvalue.setreadDataFormSqliteStore(
                                                context);
                                          });
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          size: 20.sp,
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              },
                            ),
                          ),
                          const Divider(
                            thickness: 1,
                            color: MyColors.blackColor,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'ລາຄາລວມທັງໝົດ:',
                                  style: TextStyle(
                                      color: MyColors.blackColor,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  '${NumberFormat.currency(symbol: '', decimalDigits: 0).format(payvalue.getStoreTotalPrice)} ກີບ',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          const Divider(
                            thickness: 1,
                            color: MyColors.blackColor,
                          ),
                          // const Text(
                          //   'ຮູບເເບບການຊຳລະເງິນ',
                          //   style: TextStyle(
                          //       color: MyColors.blackColor, fontSize: 16),
                          // ),
                          // RadioListTile(
                          //   dense: true,
                          //   value: 'cash',
                          //   groupValue: chooseType,
                          //   onChanged: (value) {
                          //     setState(() {
                          //       chooseType = value.toString();
                          //     });
                          //   },
                          //   title: Text('ເເບບເງິນສົດ'),
                          // ),
                          // RadioListTile(
                          //   dense: true,
                          //   value: 'transfer',
                          //   groupValue: chooseType,
                          //   onChanged: (value) {
                          //     setState(() {
                          //       chooseType = value.toString();
                          //     });
                          //   },
                          //   title: Text('ເເບບເງິນໂອນ'),
                          // ),
                          // chooseType == 'transfer'
                          //     ? Padding(
                          //         padding: const EdgeInsets.symmetric(
                          //             horizontal: 10),
                          //         child: Row(
                          //           mainAxisAlignment:
                          //               MainAxisAlignment.spaceAround,
                          //           children: [
                          //             Expanded(
                          //               child: IconButton(
                          //                 onPressed: () =>
                          //                     chooseImages(ImageSource.camera),
                          //                 icon: const Icon(
                          //                     Icons.add_a_photo_rounded,
                          //                     size: 48,
                          //                     color: Color(0xff707070)),
                          //               ),
                          //             ),
                          //             Expanded(
                          //               flex: 2,
                          //               child: Container(
                          //                 height: 200,
                          //                 width: 200,
                          //                 child: file != null
                          //                     ? Image.file(
                          //                         file!,
                          //                         fit: BoxFit.fill,
                          //                       )
                          //                     : Image.asset(
                          //                         MyImages.gallery,
                          //                         fit: BoxFit.fill,
                          //                         color: MyColors.hintColor,
                          //                       ),
                          //               ),
                          //             ),
                          //             Expanded(
                          //               child: IconButton(
                          //                 onPressed: () =>
                          //                     chooseImages(ImageSource.gallery),
                          //                 icon: const Icon(Icons.photo,
                          //                     size: 48,
                          //                     color: Color(0xff707070)),
                          //               ),
                          //             ),
                          //           ],
                          //         ),
                          //       )
                          //     : SizedBox(),

                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: Text(
                              'ເລືອກລູກຄ້າ',
                              style: TextStyle(
                                  fontSize: 16.sp, fontWeight: FontWeight.w600),
                            ),
                          ),
                          Form(
                            key: _formKey,
                            child: Container(
                              child: DropdownButtonFormField(
                                hint: const Text(
                                  'ເລືອກລູກຄ້າ',
                                  style: TextStyle(color: MyColors.hintColor),
                                ),
                                decoration: InputDecoration(
                                  fillColor: MyColors.whiteColor,
                                  isDense: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                    borderSide: const BorderSide(
                                        color: MyColors.hoverColors),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                    borderSide: const BorderSide(
                                        color: MyColors.hoverColors),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                    borderSide: const BorderSide(
                                        color: MyColors.hoverColors),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                    borderSide: const BorderSide(
                                        color: MyColors.hoverColors),
                                  ),
                                ),
                                items: storeModel.getmembers.map((e) {
                                  return DropdownMenuItem<Member>(
                                    value: e,
                                    child: Text('${e.name} ${e.lastName}'),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  userId = value!.id;
                                },
                                validator: (value) {
                                  if (value == null) {
                                    return 'ກະລຸນາເລືອກລູກຄ້າ';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 50.h),
                          Row(
                            children: [
                              Expanded(
                                child: MSLButton(
                                  text: 'ຍົກເລີກສັ່ງຊື້',
                                  onpressed: () async {
                                    await payvalue
                                        .sqliteStoreDeleteAll(context)
                                        .then((va) {
                                      payvalue
                                          .setreadDataFormSqliteStore(context);
                                    });
                                  },
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: MSLButton(
                                  text: 'ສັ່ງຊື້',
                                  onpressed: () {
                                    itemsModel.clear();
                                    for (var i
                                        in payvalue.getSqliteStoreModel) {
                                      itemsModel.add({
                                        'product_id': i.productId,
                                        'amount': i.amount,
                                      });
                                    }
                                    if (_formKey.currentState!.validate()) {
                                      payvalue.setBranchCheckoutLast(
                                          context,
                                          userId,
                                          loginmodel.getBId,
                                          payvalue.getStoreTotalPrice,
                                          'cash',
                                          itemsModel);
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
          },
        ));
  }

  Future<void> chooseImages(ImageSource imageSource) async {
    ImagePicker imagePicker = ImagePicker();
    try {
      XFile? images = await imagePicker.pickImage(
          source: imageSource,
          maxHeight: 1000,
          maxWidth: 1000,
          imageQuality: 100);
      setState(() {
        if (images != null) {
          file = File(images.path);
        }
      });
    } catch (e) {
      // return null;
      print('ereeeeeeeee $e');
    }
  }
}
