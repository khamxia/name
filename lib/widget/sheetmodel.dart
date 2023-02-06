import 'package:flutter/material.dart';
import 'package:meesooklife_app/constant/my_colors.dart';
import 'package:meesooklife_app/widget/sheet_dialog.dart';

Future<void> chooseSheet(BuildContext context, VoidCallback cameratap,
    VoidCallback gallerytap) async {
  showModalBottomSheet(
    backgroundColor: MyColors.hoverColors,
    context: context,
    builder: (context) {
      return ProfileButtomDialog(cameraTap: cameratap, galleryTap: gallerytap);
    },
  );
}
