import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:meesooklife_app/business_provider/payment_provider.dart';
import 'package:meesooklife_app/business_provider/products_provider.dart';
import 'package:meesooklife_app/constant/font.dart';
import 'package:meesooklife_app/constant/image.dart';
import 'package:meesooklife_app/constant/my_colors.dart';
import 'package:meesooklife_app/database/user_database/sqlite_database.dart';
import 'package:meesooklife_app/screen/hero/hero_file.dart';
import 'package:meesooklife_app/screen/hero/hero_page.dart';
import 'package:meesooklife_app/screen/model/exprese_model.dart';
import 'package:meesooklife_app/widget/address_dropdown.dart';
import 'package:provider/provider.dart';
import '../../constant/theme.dart';
import '../../widget/alert_diog/alert_diog_cancel_success.dart';
import '../../widget/alert_diog/alert_error.dart';
import '../../widget/text_button.dart';
import '../model/address_model.dart';

class PaymentUserCheckOut extends StatefulWidget {
  const PaymentUserCheckOut({super.key});

  @override
  State<PaymentUserCheckOut> createState() => _PaymentUserCheckOutState();
}

class _PaymentUserCheckOutState extends State<PaymentUserCheckOut> {
  final TextEditingController moneycontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  File? file;
  List<District> district = [];
  List<Village> village = [];
  int prId = 0;
  int distId = 0;
  int villId = 0;
  int expressId = 0;
  List<Map<String, dynamic>> itemsModel = [];
  int newTotal = 0;
  @override
  void initState() {
    newTotal = context.read<PaymentProvider>().getTotalPrice;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'ລາຍລະອຽດສິນຄ້າ',
            style: appBarStyle(),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: MSLheme.appBarGradient,
            ),
          ),
        ),
        body: Consumer2<ProductsProvider, PaymentProvider>(
          builder: (context, promodel, paymodels, _) {
            return paymodels.getSqliteModel.isEmpty
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      child: Form(
                        key: _formKey,
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
                                padding: EdgeInsets.symmetric(vertical: 20.h),
                                child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: paymodels.getSqliteModel.length,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            paymodels.getSqliteModel[index]
                                                .productName
                                                .toString(),
                                            maxLines: 2,
                                            style: const TextStyle(
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            NumberFormat.currency(
                                                    symbol: '',
                                                    decimalDigits: 0)
                                                .format(int.parse(paymodels
                                                    .getSqliteModel[index].price
                                                    .toString())),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            paymodels
                                                .getSqliteModel[index].amount
                                                .toString(),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            NumberFormat.currency(
                                                    symbol: '',
                                                    decimalDigits: 0)
                                                .format(int.parse(paymodels
                                                    .getSqliteModel[index].total
                                                    .toString())),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: InkWell(
                                            onTap: () async {
                                              await paymodels
                                                  .sqliteDelete(
                                                      context,
                                                      paymodels
                                                          .getSqliteModel[index]
                                                          .id!)
                                                  .then((value) {
                                                paymodels
                                                    .setTotalPrice = paymodels
                                                        .getTotalPrice -
                                                    int.parse(paymodels
                                                        .getSqliteModel[index]
                                                        .total
                                                        .toString());
                                                paymodels.sqliteRead(context);
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
                                )),
                            const Divider(
                              thickness: 1,
                              color: MyColors.blackColor,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                            text: 'ລວມທັງໝົດ: ',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: FONT_NOTOSANS)),
                                        TextSpan(
                                          text:
                                              '${NumberFormat.currency(symbol: '', decimalDigits: 0).format(paymodels.getTotalPrice)} ກີບ',
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontFamily: FONT_NOTOSANS,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ]),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              thickness: 1,
                              color: MyColors.blackColor,
                            ),
                            const Text(
                              'ຊຳລະເງິນ',
                              style: TextStyle(
                                  color: MyColors.blackColor, fontSize: 16),
                            ),
                            RichText(
                              text: const TextSpan(
                                  text: 'ຂໍ້ເເນະນຳ: ',
                                  style: TextStyle(
                                      color: MyColors.cancelColor,
                                      fontFamily: FONT_NOTOSANS),
                                  children: [
                                    TextSpan(
                                      text:
                                          ' ທ່ານຈຳເປັນຕ້ອງໄດ້ເເຄັບຮູບພາບການຊຳລະເງິນໃນ BCEL ONE ເມື່ອຊຳລະແລ້ວ ເພື່ອເປັນຫຼັກຖານການໂອນເງິນອີກຄັ້ງ.',
                                      style: TextStyle(
                                          color: MyColors.hintColor,
                                          fontFamily: FONT_NOTOSANS),
                                    ),
                                  ]),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 5.h),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: MyColors.hoverColors),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 110.w),
                                  child: paymodels.getBranchPayment != null
                                      ? GestureDetector(
                                          child: Hero(
                                            tag: 'imageHero',
                                            child: Image.network(
                                              paymodels.getBranchPayment!
                                                  .branchQrcode
                                                  .toString(),
                                              width: 150.w,
                                              height: 150.h,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        HeroPages(
                                                          images: paymodels
                                                              .getBranchPayment!
                                                              .branchQrcode
                                                              .toString(),
                                                        )));
                                          })
                                      : Image.asset(
                                          MyImages.loading,
                                          width: 150.w,
                                          height: 150.h,
                                          fit: BoxFit.fill,
                                        ),
                                ),
                              ),
                            ),
                            Container(
                              child: TextFormField(
                                readOnly: true,
                                initialValue: paymodels.getBranchPayment != null
                                    ? paymodels.getBranchPayment!.bceloneNumber
                                        .toString()
                                    : '',
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
                                  suffixIcon: IconButton(
                                    onPressed: () async {
                                      Clipboard.setData(
                                        ClipboardData(
                                            text: paymodels
                                                .getBranchPayment!.bceloneNumber
                                                .toString()),
                                      ).then((value) {
                                        alertdiogcancelsuccess(
                                            context: context,
                                            title: 'copy ສຳເລັດແລ້ວ',
                                            image: MyImages.success);
                                      });
                                      await Future.delayed(
                                        const Duration(seconds: 1),
                                      ).then((value) {
                                        Navigator.pop(context);
                                      });
                                    },
                                    icon: Icon(
                                      Icons.copy,
                                      size: 25.sp,
                                      color: MyColors.blueColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Divider(
                              thickness: 1,
                              color: MyColors.blackColor,
                            ),
                            Text(
                              'ຫຼັກຖານການຊຳລະເງິນ',
                              style: TextStyle(
                                  color: MyColors.blackColor, fontSize: 16.sp),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: MyColors.hoverColors),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    child: Container(
                                      width: 70.w,
                                      height: 70.h,
                                      decoration: BoxDecoration(
                                        color:
                                            MyColors.blueColor.withOpacity(0.7),
                                        border: Border.all(
                                            color: MyColors.hoverColors),
                                        shape: BoxShape.circle,
                                      ),
                                      child: IconButton(
                                        onPressed: () =>
                                            chooseImages(ImageSource.camera),
                                        icon: Icon(Icons.photo_camera_outlined,
                                            size: 32.sp,
                                            color: MyColors.whiteColor),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      height: 200,
                                      width: 200,
                                      child: file != null
                                          ? Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 15.h),
                                              child: GestureDetector(
                                                child: Hero(
                                                  tag: 'fileHero',
                                                  child: Image.file(
                                                    file!,
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              HeroFile(
                                                                  files:
                                                                      file!)));
                                                },
                                              ),
                                            )
                                          : Image.asset(
                                              MyImages.gallery,
                                              fit: BoxFit.fill,
                                              color: MyColors.blueColor
                                                  .withOpacity(0.7),
                                            ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      width: 70.w,
                                      height: 70.h,
                                      decoration: BoxDecoration(
                                        color:
                                            MyColors.blueColor.withOpacity(0.7),
                                        border: Border.all(
                                            color: MyColors.hoverColors),
                                        shape: BoxShape.circle,
                                      ),
                                      child: IconButton(
                                        onPressed: () =>
                                            chooseImages(ImageSource.gallery),
                                        icon: Icon(Icons.photo,
                                            size: 32.sp,
                                            color: MyColors.whiteColor),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              thickness: 1,
                              color: MyColors.blackColor,
                            ),
                            const Text(
                              'ສະຖານທີ່ຮັບສິນຄ້າ',
                              style: TextStyle(
                                  color: MyColors.blackColor, fontSize: 16),
                            ),
                            AddressDropDown(
                              prDropDownItems:
                                  paymodels.getProvinceList!.map((e) {
                                return DropdownMenuItem<Province>(
                                  value: e,
                                  child: Text(e.prName.toString()),
                                );
                              }).toList(),
                              onChangedProvince: (prvalue) {
                                district.clear();
                                village.clear();
                                setState(() {
                                  prId = prvalue!.prId;
                                  district = prvalue.districts;
                                });
                              },
                              distDropDownItems: district
                                  .where((element) => element.prId == prId)
                                  .map((e) {
                                return DropdownMenuItem<District>(
                                  value: e,
                                  child: Text(e.drName.toString()),
                                );
                              }).toList(),
                              onChangedDistrict: (drvalue) {
                                village.clear();
                                setState(() {
                                  distId = drvalue!.drId;
                                  village = drvalue.villages;
                                  villId = drvalue.villages.first.villId;
                                });
                              },
                              villDropDownItems: village
                                  .where((element) => element.drId == distId)
                                  .map((e) {
                                return DropdownMenuItem<Village>(
                                  value: e,
                                  child: Text(e.villName.toString()),
                                );
                              }).toList(),
                              onChangedVillage: (villvalue) {
                                setState(() {
                                  villId = villvalue!.villId;
                                });
                              },
                              // selectedProvince: paymodels.getProvinceList != null
                              //     ? paymodels.getProvinceList!.first
                              //     : null,
                              selectedDistrict:
                                  district.isNotEmpty ? district.first : null,
                              selectedVillage:
                                  village.isNotEmpty ? village.first : null,
                            ),
                            const Divider(
                              thickness: 1,
                              height: 20,
                              color: MyColors.blackColor,
                            ),
                            const Text(
                              'ບໍລິສັດຂົນສົ່ງ',
                              style: TextStyle(
                                  color: MyColors.blackColor, fontSize: 16),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 5.h),
                              child: Container(
                                child: DropdownButtonFormField(
                                  hint: const Text(
                                    'ເລືອກຂົນສົ່ງ',
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
                                  ),
                                  items: paymodels.getExpreseList.map((e) {
                                    return DropdownMenuItem<Exprese>(
                                      value: e,
                                      child: Text(e.name.toString()),
                                    );
                                  }).toList(),
                                  onChanged: ((value) {
                                    expressId = value!.id!;
                                  }),
                                  validator: (value) {
                                    if (value == null) {
                                      return 'ກະລຸນາເລືອກບໍລິສັດຂົນສົ່ງ';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: MSLButton(
                                      text: 'ຍົກເລີກ',
                                      onpressed: () async {
                                        await SQLiteHelper()
                                            .deleteAllData()
                                            .then((value) {
                                          paymodels.sqliteRead(context);
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  Expanded(
                                    child: MSLButton(
                                      text: 'ສັ່ງຊື້',
                                      onpressed: () async {
                                        itemsModel.clear();
                                        for (var i
                                            in paymodels.getSqliteModel) {
                                          itemsModel.add({
                                            'product_id': i.productId,
                                            'amount': i.amount,
                                          });
                                        }
                                        if (_formKey.currentState!.validate()) {
                                          if (file != null) {
                                            await paymodels.setUserPayment(
                                              context,
                                              expressId,
                                              promodel.getBranchId,
                                              paymodels.getTotalPrice
                                                  .toDouble(),
                                              prId,
                                              distId,
                                              villId,
                                              itemsModel,
                                              file!,
                                            );
                                          } else {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return const ErrorAlertDialog(
                                                    content:
                                                        'ກະລຸນາສົ່ງຫຼັກຖານການຊຳລະເງິນພ້ອມ\n ຂໍຂອບໃຈ',
                                                    icon: MyImages.erroricon);
                                              },
                                            );
                                          }
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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
      );
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
