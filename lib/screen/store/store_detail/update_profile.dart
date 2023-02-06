import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meesooklife_app/business_provider/login_provider.dart';
import 'package:meesooklife_app/business_provider/payment_provider.dart';
import 'package:meesooklife_app/business_provider/profile_provider.dart';
import 'package:meesooklife_app/constant/font.dart';
import 'package:provider/provider.dart';

import '../../../constant/my_colors.dart';
import '../../../constant/theme.dart';
import '../../../widget/text_button.dart';
import '../../../widget/textformfield_edit_profile.dart';
import '../../../widget/title_profile.dart';
import '../../model/address_model.dart';

class UpdateBranchProfile extends StatefulWidget {
  const UpdateBranchProfile({super.key});

  @override
  State<UpdateBranchProfile> createState() => _UpdateBranchProfileState();
}

class _UpdateBranchProfileState extends State<UpdateBranchProfile> {
  final TextEditingController _nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  List<District> district = [];
  List<Village> village = [];
  int prId = 0;
  int distId = 0;
  int villId = 0;
  @override
  void dispose() {
    _nameController.dispose();
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
                if (formKey.currentState!.validate()) {
                  await context
                      .read<ProfileProvider>()
                      .setUpdateBranchProfile(
                          context, _nameController.text, prId, distId, villId)
                      .then((value) {
                    Navigator.pop(context);
                  });
                }
              }),
        ),
        appBar: AppBar(
          title: Text(
            'ເເກ້ໄຂຂໍ້ມູນສາຂາ',
            style: appBarStyle(),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(gradient: MSLheme.appBarGradient),
          ),
        ),
        body: Consumer2<PaymentProvider, LoginProvider>(
          builder: (context, paymodels, logmodels, _) {
            _nameController.text = logmodels.getBranchName;
            return SingleChildScrollView(
              child: paymodels.getProvinceList != null
                  ? GestureDetector(
                      onTap: () =>
                          FocusScope.of(context).requestFocus(FocusNode()),
                      behavior: HitTestBehavior.opaque,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 50.h),
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const TitleProfile(title: 'ຊື່ສາຂາ'),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                // child: TextFormFileEditProfile(
                                //   hintText: 'ຊື່ສາຂາ',
                                //   controller: _nameController,
                                //   maxLength: 200,
                                //   textInputType: TextInputType.text,
                                //   validate: 'ກະລຸນາປ້ອນຊື່ສາຂາ',
                                // ),
                                child: TextFormField(
                                  controller: _nameController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    fillColor: MyColors.whiteColor,
                                    counterText: '',
                                    isDense: true,
                                    hintText: 'ຊື່ສາຂາ',
                                    hintStyle: const TextStyle(
                                        color: MyColors.hintColor),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: MyColors.hoverColors),
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: MyColors.hoverColors),
                                        borderRadius:
                                            BorderRadius.circular(8.r)),
                                    errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: MyColors.hoverColors),
                                        borderRadius:
                                            BorderRadius.circular(8.r)),
                                    focusedErrorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: MyColors.hoverColors),
                                        borderRadius:
                                            BorderRadius.circular(8.r)),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'ກະລຸນາປ້ອນຊື່ສາຂາ';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              AddressDropDownUpdate(
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
                                    logmodels.setBranchName =
                                        _nameController.text;
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
                            ],
                          ),
                        ),
                      ),
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
            );
          },
        ));
  }
}
