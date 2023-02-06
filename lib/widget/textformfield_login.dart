import 'package:flutter/material.dart';
import '../constant/my_colors.dart';

class TextFormfieldLogin extends StatelessWidget {
  final int length;
  final String hintText;
  final IconData icon;
  final String labelText;
  final TextEditingController controller;
  final TextInputType keyboardType;

  const TextFormfieldLogin(
      {super.key,
      required this.length,
      required this.hintText,
      required this.labelText,
      required this.icon,
      required this.controller,
      required this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      maxLength: length,
      decoration: InputDecoration(
        filled: true,
        fillColor: MyColors.whiteColor,
        counterText: '',
        isDense: true,
        labelText: labelText,
        labelStyle: const TextStyle(color: MyColors.tealColor, fontSize: 16),
        hintText: hintText,
        hintStyle: const TextStyle(color: MyColors.hintColor),
        prefixIcon: Icon(
          icon,
          color: MyColors.tealColor,
          size: 25,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: MyColors.whiteColor),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: MyColors.whiteColor),
            borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
