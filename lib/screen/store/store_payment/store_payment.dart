import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meesooklife_app/constant/my_colors.dart';
import '../../../constant/font.dart';
import '../../../constant/image.dart';
import '../../../constant/theme.dart';

class StorePayment extends StatefulWidget {
  const StorePayment({super.key});

  @override
  State<StorePayment> createState() => _StorePaymentState();
}

class _StorePaymentState extends State<StorePayment> {
  bool isCheck = true;
  String chooseType = 'cash';
  File? file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: MSLheme.appBarGradient,
              borderRadius: BorderRadius.circular(10)),
          child: TextButton(
            onPressed: () {},
            child: const Text(
              'ຢືນຢັນການຊຳລະເງິນ',
              style: TextStyle(color: MyColors.whiteColor),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        title: Text(
          'ການຊຳລະເງິນ',
          style: appBarStyle(),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: MSLheme.appBarGradient),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'ລາຍລະອຽດການສັ່ງຊື້',
              style: TextStyle(color: MyColors.blackColor, fontSize: 16),
            ),
            const Divider(thickness: 2),
            RichText(
              text: const TextSpan(
                  text: 'ຈຳນວນສິນຄ້າ: ',
                  style: TextStyle(
                      fontFamily: FONT_NOTOSANS, color: MyColors.blackColor),
                  children: [
                    TextSpan(
                        text: ' 5 ລາຍການ',
                        style: TextStyle(
                            color: MyColors.cancelColor,
                            fontFamily: FONT_NOTOSANS)),
                  ]),
            ),
            RichText(
              text: const TextSpan(
                  text: 'ຈຳນວນເງິນທັງໝົດ: ',
                  style: TextStyle(
                      fontFamily: FONT_NOTOSANS, color: MyColors.blackColor),
                  children: [
                    TextSpan(
                        text: ' 100,000 ກີບ',
                        style: TextStyle(
                            color: MyColors.cancelColor,
                            fontFamily: FONT_NOTOSANS)),
                  ]),
            ),
            RichText(
              text: const TextSpan(
                  text: 'ວັນທີສັ່ງຊື້: ',
                  style: TextStyle(
                      fontFamily: FONT_NOTOSANS, color: MyColors.blackColor),
                  children: [
                    TextSpan(
                        text: ' 22/1/2023',
                        style: TextStyle(
                            color: MyColors.cancelColor,
                            fontFamily: FONT_NOTOSANS)),
                  ]),
            ),
            const Divider(thickness: 2),
            const SizedBox(height: 10),
            const Text(
              'ຮູບເເບບການຊຳລະເງິນ',
              style: TextStyle(color: MyColors.blackColor, fontSize: 16),
            ),
            RadioListTile(
              dense: true,
              value: 'cash',
              groupValue: chooseType,
              onChanged: (value) {
                setState(() {
                  chooseType = value.toString();
                });
              },
              title: Text('ເເບບເງິນສົດ'),
            ),
            RadioListTile(
              dense: true,
              value: 'transfer',
              groupValue: chooseType,
              onChanged: (value) {
                setState(() {
                  chooseType = value.toString();
                });
              },
              title: Text('ເເບບເງິນໂອນ'),
            ),
            chooseType == 'transfer'
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: IconButton(
                            onPressed: () => chooseImages(ImageSource.camera),
                            icon: const Icon(Icons.add_a_photo_rounded,
                                size: 48, color: Color(0xff707070)),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 200,
                            width: 200,
                            child: file != null
                                ? Image.file(
                                    file!,
                                    fit: BoxFit.fill,
                                  )
                                : Image.asset(
                                    MyImages.gallery,
                                    fit: BoxFit.fill,
                                    color: MyColors.hintColor,
                                  ),
                          ),
                        ),
                        Expanded(
                          child: IconButton(
                            onPressed: () => chooseImages(ImageSource.gallery),
                            icon: const Icon(Icons.photo,
                                size: 48, color: Color(0xff707070)),
                          ),
                        ),
                      ],
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
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
