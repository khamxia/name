import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meesooklife_app/business_provider/login_provider.dart';
import 'package:meesooklife_app/business_provider/payment_provider.dart';
import 'package:meesooklife_app/business_provider/profile_provider.dart';
import 'package:meesooklife_app/widget/text_button.dart';
import 'package:meesooklife_app/widget/textformfield_edit_profile.dart';
import 'package:meesooklife_app/widget/title_profile.dart';
import 'package:provider/provider.dart';
import '../../constant/font.dart';
import '../../constant/theme.dart';
import '../model/address_model.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<District> district = [];
  List<Village> village = [];
  int prId = 0;
  int distId = 0;
  int villId = 0;

  @override
  void dispose() {
    nameController.dispose();
    lastController.dispose();
    phoneController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ເເກ້ໄຂຂໍ້ມູນ', style: appBarStyle()),
          flexibleSpace: Container(
            decoration: const BoxDecoration(gradient: MSLheme.appBarGradient),
          ),
        ),
        body: Consumer3<PaymentProvider, LoginProvider, ProfileProvider>(
          builder: (context, paymodels, logmodels, profmodel, _) {
            nameController.text = logmodels.getFname;
            lastController.text = logmodels.getLname;
            phoneController.text = logmodels.getNumberPhone.toString();
            return SingleChildScrollView(
              child: GestureDetector(
                onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                behavior: HitTestBehavior.opaque,
                child: paymodels.getProvinceList != null
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 20.h),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const TitleProfile(title: 'ຊື່'),
                              TextFormFileEditProfile(
                                  maxLength: 50,
                                  textInputType: TextInputType.text,
                                  hintText: 'ປ້ອນຊື່',
                                  controller: nameController,
                                  validate: 'ກະລຸນາປ້ອນຊື່'),
                              SizedBox(height: 10.h),
                              const TitleProfile(title: 'ນາມສະກຸນ'),
                              TextFormFileEditProfile(
                                  maxLength: 50,
                                  textInputType: TextInputType.text,
                                  hintText: 'ປ້ອນນາມສະກຸນ',
                                  controller: lastController,
                                  validate: 'ກະລຸນາປ້ອນນາມສະກຸນ'),
                              SizedBox(height: 10.h),
                              const TitleProfile(title: 'ເບີໂທລະສັບ'),
                              TextFormFileEditProfile(
                                  maxLength: 11,
                                  textInputType: TextInputType.phone,
                                  hintText: 'ປ້ອນເບີໂທລະສັບ',
                                  controller: phoneController,
                                  validate: 'ກະລຸນາປ້ອນເບີໂທລະສັບ'),
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
                                    logmodels.setPhone =
                                        int.parse(phoneController.text);
                                    logmodels.setFName = nameController.text;
                                    logmodels.setLName = lastController.text;
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
                              SizedBox(height: 30.h),
                              MSLButton(
                                  text: 'ບັນທຶກ',
                                  onpressed: () async {
                                    
                                    if (_formKey.currentState!.validate()) {
                                      await profmodel
                                          .setUpdateUserProfile(
                                              context,
                                              nameController.text,
                                              lastController.text,
                                              int.parse(phoneController.text),
                                              prId,
                                              distId,
                                              villId)
                                          .then((value) {
                                        Navigator.pop(context);
                                      });
                                    }
                                  }),
                            ],
                          ),
                        ),
                      )
                    : const Center(child: CircularProgressIndicator()),
              ),
            );
          },
        ));
  }
}
