import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meesooklife_app/screen/model/address_model.dart';
import '../constant/my_colors.dart';

class AddressDropDown extends StatelessWidget {
  final List<DropdownMenuItem<Province>> prDropDownItems;
  final Function(Province?) onChangedProvince;

  final List<DropdownMenuItem<District>> distDropDownItems;
  final Function(District?) onChangedDistrict;

  final List<DropdownMenuItem<Village>> villDropDownItems;
  final Function(Village?) onChangedVillage;

 // final Province? selectedProvince;
  final District? selectedDistrict;
  final Village? selectedVillage;

  const AddressDropDown(
      {super.key,
      required this.prDropDownItems,
      required this.onChangedProvince,
      required this.distDropDownItems,
      required this.onChangedDistrict,
      required this.villDropDownItems,
      required this.onChangedVillage,
     // required this.selectedProvince,
      required this.selectedDistrict,
      required this.selectedVillage});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Container(
            child: DropdownButtonFormField(
              hint: const Text(
                'ແຂວງ',
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
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Container(
            child: DropdownButtonFormField(
              hint: const Text(
                'ເມືອງ',
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
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Container(
            child: DropdownButtonFormField(
              hint: const Text('ບ້ານ',
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
        ),
      ],
    );
  }
}
