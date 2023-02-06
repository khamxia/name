import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meesooklife_app/widget/title_profile.dart';
import '../constant/my_colors.dart';
import '../screen/model/address_model.dart';

class TextFormFileEditProfile extends StatelessWidget {
  final int maxLength;
  final String hintText;
  final TextInputType textInputType;
  final TextEditingController controller;
  final String validate;
  const TextFormFileEditProfile(
      {super.key,
      required this.hintText,
      required this.controller,
      required this.maxLength,
      required this.textInputType,
      required this.validate});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: maxLength,
      controller: controller,
      keyboardType: textInputType,
      decoration: InputDecoration(
        fillColor: MyColors.whiteColor,
        counterText: '',
        isDense: true,
        hintText: hintText,
        hintStyle: const TextStyle(color: MyColors.hintColor),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: MyColors.hoverColors),
          borderRadius: BorderRadius.circular(8.r),
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: MyColors.hoverColors),
            borderRadius: BorderRadius.circular(8.r)),
        errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: MyColors.hoverColors),
            borderRadius: BorderRadius.circular(8.r)),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: MyColors.hoverColors),
            borderRadius: BorderRadius.circular(8.r)),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return validate;
        }
        return null;
      },
    );
  }
}

class AddressDropDownUpdate extends StatelessWidget {
  final List<DropdownMenuItem<Province>> prDropDownItems;
  final Function(Province?) onChangedProvince;

  final List<DropdownMenuItem<District>> distDropDownItems;
  final Function(District?) onChangedDistrict;

  final List<DropdownMenuItem<Village>> villDropDownItems;
  final Function(Village?) onChangedVillage;

 // final Province? selectedProvince;
  final District? selectedDistrict;
  final Village? selectedVillage;

  const AddressDropDownUpdate(
      {super.key,
      required this.prDropDownItems,
      required this.onChangedProvince,
      required this.distDropDownItems,
      required this.onChangedDistrict,
      required this.villDropDownItems,
      required this.onChangedVillage,
      //required this.selectedProvince,
      required this.selectedDistrict,
      required this.selectedVillage});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.h),
        const TitleProfile(title: 'ເເຂວງ'),
        Container(
          child: DropdownButtonFormField(
            hint: const Text(
              'ເລືອກແຂວງ',
              style: TextStyle(color: MyColors.hintColor),
            ),
            decoration: InputDecoration(
              fillColor: MyColors.whiteColor,
              isDense: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: const BorderSide(color: MyColors.hoverColors),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: const BorderSide(color: MyColors.hoverColors),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: const BorderSide(color: MyColors.hoverColors),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: const BorderSide(color: MyColors.hoverColors),
              ),
            ),
            items: prDropDownItems,
            onChanged: onChangedProvince,
           // value: selectedProvince,
            validator: (value) {
              if (value == null) {
                return 'ກະລຸນາເລືອກແຂວງ';
              }
              return null;
            },
          ),
        ),
        SizedBox(height: 10.h),
        const TitleProfile(title: 'ເມືອງ'),
        Container(
          child: DropdownButtonFormField(
            hint: const Text(
              'ເລືອກເມືອງ',
              style: TextStyle(color: MyColors.hintColor),
            ),
            decoration: InputDecoration(
              fillColor: MyColors.whiteColor,
              isDense: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: const BorderSide(color: MyColors.hoverColors),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: const BorderSide(color: MyColors.hoverColors),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: const BorderSide(color: MyColors.hoverColors),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: const BorderSide(color: MyColors.hoverColors),
              ),
            ),
            items: distDropDownItems,
            onChanged: onChangedDistrict,
            value: selectedDistrict,
            validator: (value) {
              if (value == null) {
                return 'ກະລຸນາເລືອກເມືອງ';
              }
              return null;
            },
          ),
        ),
        SizedBox(height: 10.h),
        const TitleProfile(title: 'ບ້ານ'),
        Container(
          child: DropdownButtonFormField(
            hint: const Text('ເລືອກບ້ານ',
                style: TextStyle(color: MyColors.hintColor)),
            decoration: InputDecoration(
              fillColor: MyColors.whiteColor,
              isDense: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: const BorderSide(color: MyColors.hoverColors),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: const BorderSide(color: MyColors.hoverColors),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: const BorderSide(color: MyColors.hoverColors),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: const BorderSide(color: MyColors.hoverColors),
              ),
            ),
            items: villDropDownItems,
            onChanged: onChangedVillage,
            value: selectedVillage,
            validator: (value) {
              if (value == null) {
                return 'ກະລຸນາເລືອກບ້ານ';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
