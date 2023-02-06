import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meesooklife_app/constant/image.dart';
import 'package:meesooklife_app/constant/my_colors.dart';

class OfflinePage extends StatelessWidget {
  final VoidCallback onPressed;
  const OfflinePage({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 200.w,
                height: 200.h,
                decoration: const BoxDecoration(
                  color: MyColors.hoverColors,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(MyImages.logo),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Text(
                  'ກະລຸນາກວດສອບການເຊື່ອມຕໍ່ຂອງທ່ານ',
                  style:
                      TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp),
                ),
              ),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.hintColor),
                  onPressed: onPressed,
                  icon: const Icon(Icons.history),
                  label: const Text('ລອງໃໝ່ອີກຄັ້ງ'))
            ],
          ),
        ),
      ),
    );
  }
}
