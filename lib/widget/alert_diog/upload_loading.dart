import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meesooklife_app/constant/my_colors.dart';

class LoadingDialog {
  static Future<void> showLoading(BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: SimpleDialog(
                key: key,
                backgroundColor: MyColors.hintColor,
                children: <Widget>[
                  Center(
                    child: Column(
                      children: [
                        const CircularProgressIndicator(
                          color: MyColors.whiteColor,
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          'ກະລຸນາລໍຖ້າ...',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                          ),
                        )
                      ],
                    ),
                  )
                ]),
          );
        });
  }
}
