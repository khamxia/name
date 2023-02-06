import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeroFile extends StatefulWidget {
  final File files;
  const HeroFile({super.key, required this.files});

  @override
  State<HeroFile> createState() => _HeroFileState();
}

class _HeroFileState extends State<HeroFile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 230.h, horizontal: 20.w),
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Hero(
              tag: 'fileHero',
              child: Image.file(
                widget.files,
                fit: BoxFit.fill,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
        ),
        onTap: () => Navigator.pop(context),
      ),
    );
  }
}
