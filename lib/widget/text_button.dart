import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meesooklife_app/constant/theme.dart';

import '../constant/my_colors.dart';

class MSLButton extends StatelessWidget {
  final String text;
  final VoidCallback onpressed;
  const MSLButton({super.key, required this.text, required this.onpressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.r),
          gradient: MSLheme.appBarGradient),
      child: TextButton(
        onPressed: onpressed,
        child: Text(
          text,
          style: TextStyle(
              color: MyColors.whiteColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
