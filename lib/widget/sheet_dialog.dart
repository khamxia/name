import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meesooklife_app/constant/my_colors.dart';

class ProfileButtomDialog extends StatelessWidget {
  final VoidCallback cameraTap;
  final VoidCallback galleryTap;
  const ProfileButtomDialog(
      {super.key, required this.cameraTap, required this.galleryTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListTile(
            leading: Icon(
              Icons.photo_camera,
              color: MyColors.tealColor,
              size: 30.sp,
            ),
            title: const Text('ຖ່າຍຮູບພາບ'),
            onTap: cameraTap,
          ),
          SizedBox(height: 5.h),
          ListTile(
            leading: Icon(
              Icons.photo,
              color: MyColors.tealColor,
              size: 30.sp,
            ),
            title: const Text('ເລືອກຈາກຄັງຮູບ'),
            onTap: galleryTap,
          ),
        ],
      ),
    );
  }
}
