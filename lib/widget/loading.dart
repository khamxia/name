import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(
                color: Color(0xFF1F4EA4),
              ),
              SizedBox(height: 20.h),
              Text(
                'ກຳລັງໂຫຼດ...',
                style: TextStyle(
                    color: Color(0xFF1D2026),
                    fontWeight: FontWeight.w400,
                    fontSize: 15.sp),
              )
            ],
          ),
        ),
      ),
    );
  }
}
