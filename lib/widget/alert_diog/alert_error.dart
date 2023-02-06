import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meesooklife_app/constant/my_colors.dart';

class ErrorAlertDialog extends StatelessWidget {
  final String content;
  final String icon;

  const ErrorAlertDialog(
      {super.key, required this.content, required this.icon});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      buttonPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      icon: Image.asset(icon, width: 50.w, height: 50.h),
      content: Text(content,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400)),
      actions: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: MyColors.blueColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.r),
                  bottomRight: Radius.circular(20.r))),
          child: TextButton(
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.r),
                      bottomRight: Radius.circular(20.r))),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'ປິດ',
              style: TextStyle(
                fontSize: 16.sp,
                color: MyColors.whiteColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
