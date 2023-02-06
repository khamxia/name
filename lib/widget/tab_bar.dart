import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constant/my_colors.dart';

class TabBars extends StatelessWidget {
  final String title;
  const TabBars({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(
        title,
        style: TextStyle(
            color: MyColors.blackColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600),
      ),
    );
  }
}
