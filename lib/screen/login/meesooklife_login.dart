import 'package:flutter/material.dart';
import 'package:meesooklife_app/constant/image.dart';
import 'package:meesooklife_app/constant/my_colors.dart';
import 'package:meesooklife_app/constant/theme.dart';
import 'package:meesooklife_app/business_provider/login_provider.dart';
import 'package:meesooklife_app/screen/deverloper_team/deverloper_team_page.dart';
import 'package:meesooklife_app/screen/privacy_conditional/privacy_condition_page.dart';
import 'package:meesooklife_app/widget/alert_diog/alert_error.dart';
import 'package:meesooklife_app/widget/textformfield_login.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class MeesookLifeLogin extends StatefulWidget {
  const MeesookLifeLogin({super.key});

  @override
  State<MeesookLifeLogin> createState() => _MeesookLifeLoginState();
}

class _MeesookLifeLoginState extends State<MeesookLifeLogin> {
  final TextEditingController _numberPhoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool visibilityEYE = true;

  @override
  void dispose() {
    _numberPhoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size sized = MediaQuery.of(context).size;
    return GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        behavior: HitTestBehavior.opaque,
        child: Consumer<LoginProvider>(
          builder: (context, models, _) {
            return Scaffold(
              body: Container(
                decoration:
                    const BoxDecoration(gradient: MSLheme.appBarGradient),
                child: SafeArea(
                  child: Container(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: sized.height * 0.05,
                          horizontal: sized.width * 0.05,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Center(
                              child: Container(
                                  height: sized.height * 0.25,
                                  width: sized.width * 0.4,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 2, color: MyColors.tealColor),
                                    shape: BoxShape.circle,
                                    image: const DecorationImage(
                                      image: AssetImage(MyImages.logo),
                                    ),
                                  )),
                            ),
                            const Text(
                              'ສະບາຍດີ! ຍິນດີຕ້ອນຮັບທຸກທ່ານ',
                              style: TextStyle(
                                  color: MyColors.tealColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: sized.height * 0.10),
                            TextFormfieldLogin(
                                keyboardType: TextInputType.phone,
                                controller: _numberPhoneController,
                                length: 10,
                                labelText: 'ເບີໂທລະສັບ',
                                hintText: '20 xxxxxxxx ຫຼື 30 xxxxxxx',
                                icon: Icons.person),
                            SizedBox(height: sized.height * 0.025),
                            // TextFormfieldLogin(
                            //     keyboardType: TextInputType.number,
                            //     controller: _passwordController,
                            //     length: 11,
                            //     labelText: 'ລະຫັດຜ່ານ',
                            //     hintText: '* * * * * *',
                            //     icon: Icons.lock),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              controller: _passwordController,
                              maxLength: 11,
                              obscureText: visibilityEYE,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: MyColors.whiteColor,
                                counterText: '',
                                isDense: true,
                                labelText: 'ລະຫັດຜ່ານ',
                                labelStyle: const TextStyle(
                                    color: MyColors.tealColor, fontSize: 16),
                                hintText: '* * * * * *',
                                hintStyle:
                                    const TextStyle(color: MyColors.hintColor),
                                prefixIcon: const Icon(
                                  Icons.lock,
                                  color: MyColors.tealColor,
                                  size: 25,
                                ),
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        visibilityEYE = !visibilityEYE;
                                      });
                                    },
                                    icon: Icon(
                                      visibilityEYE
                                          ? Icons.visibility_off
                                          : Icons.remove_red_eye,
                                      size: 25,
                                      color: MyColors.tealColor,
                                    )),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: MyColors.whiteColor),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: MyColors.whiteColor),
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              onFieldSubmitted: (val) async {
                                if (_numberPhoneController.text.isNotEmpty &&
                                    _passwordController.text.isNotEmpty) {
                                  await models.setConnectTokenModel(
                                      context,
                                      _numberPhoneController.text,
                                      _passwordController.text);
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return const ErrorAlertDialog(
                                          content:
                                              'ກະລຸນາປ້ອນຂໍ້ມູນໃຫ້ຄົບກ່ອນ \n ຂໍຂອບໃຈ',
                                          icon: MyImages.erroricon);
                                    },
                                  );
                                }
                              },
                            ),
                            SizedBox(height: sized.height * 0.05),
                            Container(
                              width: double.infinity,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: MyColors.blueColor,
                                  padding: EdgeInsets.symmetric(
                                      vertical: sized.height * 0.02,
                                      horizontal: sized.width * 0.05),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                ),
                                onPressed: () async {
                                  if (_numberPhoneController.text.isNotEmpty &&
                                      _passwordController.text.isNotEmpty) {
                                    await models.setConnectTokenModel(
                                        context,
                                        _numberPhoneController.text,
                                        _passwordController.text);
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return const ErrorAlertDialog(
                                            content:
                                                'ກະລຸນາປ້ອນຂໍ້ມູນໃຫ້ຄົບກ່ອນ \n ຂໍຂອບໃຈ',
                                            icon: MyImages.erroricon);
                                      },
                                    );
                                  }
                                },
                                child: Text(
                                  'ເຂົ້າສູ່ລະບົບ',
                                  style: TextStyle(
                                      color: MyColors.whiteColor,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            SizedBox(height: sized.height * 0.11),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const PrivacyConditionalPage()));
                                  },
                                  child: const Text(
                                    'ນະໂຍບາຍ ແລະ ເງືອນໄຂ',
                                    style:
                                        TextStyle(color: MyColors.whiteColor),
                                  ),
                                ),
                                Container(
                                  width: 2.w,
                                  height: 10.h,
                                  color: MyColors.whiteColor,
                                ),
                                TextButton(
                                  onPressed: () {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           const DeverloperTeamPage(),
                                    //     ));
                                  },
                                  child: const Text(
                                    'ທີມນັກພັດທະນາ',
                                    style:
                                        TextStyle(color: MyColors.whiteColor),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const [
                                Text('version 1.0.1   ',
                                    style: TextStyle(
                                      color: MyColors.whiteColor,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
