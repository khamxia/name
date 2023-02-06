import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constant/my_colors.dart';

class BestProduct extends StatelessWidget {
  final VoidCallback onTap;
  final String image;
  final String title;
  final String description;
  final String price;
  final String titleCart;
  const BestProduct(
      {super.key,
      required this.onTap,
      required this.image,
      required this.title,
      required this.description,
      required this.price,required this.titleCart});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size.width * 0.5,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
          elevation: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      height: 170.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          image: DecorationImage(
                            image: NetworkImage(image),
                            fit: BoxFit.fill,
                          )),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Text(
                      title,
                      maxLines: 1,
                      style: const TextStyle(
                          fontSize: 16,
                          overflow: TextOverflow.ellipsis,
                          color: MyColors.blackColor,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              Center(
                  child: Text(
                price,
                style: TextStyle(
                  color: MyColors.cancelColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              )),
              Container(
                margin: EdgeInsets.zero,
                width: double.infinity,
                height: 50.h,
                decoration: BoxDecoration(
                  color: MyColors.cartColor,
                  // gradient: MSLheme.appBarGradient,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: MyColors.hoverColors),
                ),
                child: Center(
                  child: Text(
                    titleCart,
                    style: TextStyle(
                        color: MyColors.whiteColor,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
