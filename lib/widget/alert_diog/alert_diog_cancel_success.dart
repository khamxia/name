import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meesooklife_app/constant/my_colors.dart';

alertdiogcancelsuccess(
    {required BuildContext context,
    required String title,
    required String image}) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              image,
              width: 70,
              height: 70,
              fit: BoxFit.fill,
            ),
            Expanded(
              child: Text(
                title,
                style: TextStyle(color: MyColors.succcessColors, fontSize: 16),
              ),
            ),
          ],
        )
      ],
    ),
  );
}

alertdiogError(
    {required BuildContext context,
    required String title,
    required String image}) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              image,
              width: 50.w,
              height: 50.h,
            ),
            SizedBox(width: 5.w),
            Expanded(
              child: Text(
                title,
                style: TextStyle(color: MyColors.cancelColor, fontSize: 16.sp),
              ),
            ),
          ],
        )
      ],
    ),
  );
}
