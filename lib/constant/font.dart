import 'package:flutter/cupertino.dart';
import 'package:meesooklife_app/constant/my_colors.dart';

const FONT_NOTOSANS = "NotoSans";

TextStyle appBarStyle() {
  return const TextStyle(
    fontFamily: FONT_NOTOSANS,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: MyColors.whiteColor,
  );
}
