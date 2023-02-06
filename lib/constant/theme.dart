import 'package:flutter/material.dart';


class MSLheme {
  static const Color gradientStart = Color(0XFF003c8f);
  static const Color gradientend = Color(0xff1565c0);
  static const Color cardStart = Color(0xff00897b);
  static const Color cardEnd = Color(0xffb2dfdb);
  static const appBarGradient = LinearGradient(
      begin: Alignment.centerRight,
      end: Alignment.centerLeft,
      colors: [gradientStart, gradientend]);
  static const cardGradient = LinearGradient(
      begin: Alignment.centerRight,
      end: Alignment.centerLeft,
      colors: [cardStart, cardEnd]);

}
