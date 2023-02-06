import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meesooklife_app/constant/my_colors.dart';
import 'package:meesooklife_app/constant/theme.dart';

import '../../constant/font.dart';

class PrivacyConditionalPage extends StatefulWidget {
  const PrivacyConditionalPage({super.key});

  @override
  State<PrivacyConditionalPage> createState() => _PrivacyConditionalPageState();
}

class _PrivacyConditionalPageState extends State<PrivacyConditionalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'ນະໂຍບາຍ ແລະ ເງືອນໄຂ',
            style: appBarStyle(),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(gradient: MSLheme.appBarGradient),
          )),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            privacyTitle('ນະໂຍບາຍຂອງບໍລິສັດ: Meesooklife4289lao '),
            privcyText(
                '    ປັນບໍລິສັດຂາຍສິນຄ້າທຸກປະເພດ,ແລ້ວເອົາກຳໄລມາແຖມເປັນສະຫວັດດີການໃຫ້ກັບລູກຄ້າທຸກທ່ານທີ່ເຂົ້າມາເປັນສະມາຊິກກັບບໍລິສັດ,ສີ່ງທີ່ທ່ານຈະໄດ້ຮັບການຊ່ວຍເຫຼືອຈາກບໍລີສັດມີສະຫວັດດີການເສຍຊິວິດ,ການແຕ່ງງານ,ການເກີດລູກ,ງານບວດພຣະ ແລະຍັງມີຊ່ອງທາງສ້າງລາຍໄດ້ລາຍວັນ,ລາຍທຸກ10ວັນແລະລາຍເດືອນໃຫ້ຕົວທ່ານອີກ'),
          ],
        ),
      )),
    );
  }

  Widget privacyTitle(String title) {
    return Text(
      title,
      style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: MyColors.blackColor),
    );
  }

  Widget privcyText(String subtitle) {
    return Text(
      subtitle,
      style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: MyColors.hintColor),
    );
  }
}
