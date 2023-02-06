import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeroPages extends StatefulWidget {
  final String images;
  const HeroPages({super.key, required this.images});

  @override
  State<HeroPages> createState() => _HeroPagesState();
}

class _HeroPagesState extends State<HeroPages> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 250.h, horizontal: 30.w),
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Hero(
              tag: 'imageHero',
              child: Image.network(
                widget.images,
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
