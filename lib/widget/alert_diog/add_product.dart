import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meesooklife_app/constant/my_colors.dart';
import 'package:meesooklife_app/database/user_database/sqlite_database.dart';
import 'package:meesooklife_app/utilities/calculate_price.dart';

addProductsAlertdiog(
    {required BuildContext context,
    required String prdImage,
    required int prdId,
    required String prdName,
    required int prdAmount,
    required String prdCategory,
    required int prdPrice,
    required int brId,
    required String brhName}) {
  int myAmount = 1;
  return showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            icon: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                width: 50.w,
                height: 150.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  image: DecorationImage(
                    image: NetworkImage(prdImage),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            content: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      if (myAmount > 0) {
                        setState(() {
                          myAmount--;
                        });
                      }
                    },
                    child: Icon(
                      Icons.remove_circle,
                      color: MyColors.blueColor,
                      size: 30.sp,
                    ),
                  ),
                  Text(myAmount.toString(),
                      style: TextStyle(
                          color: MyColors.blueColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp)),
                  InkWell(
                    onTap: () {
                      setState(() {
                        myAmount++;
                      });
                    },
                    child: Icon(
                      Icons.add_circle,
                      color: MyColors.blueColor,
                      size: 30.sp,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.r),
                          side: const BorderSide(color: MyColors.hoverColors),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'ຍົກເລີກ',
                        style: TextStyle(
                            color: MyColors.blueColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp),
                      ),
                    ),
                  ),
                  SizedBox(width: 20.w),
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.r),
                          side: const BorderSide(color: MyColors.hoverColors),
                        ),
                      ),
                      onPressed: () {
                        calculatePrice(context, prdId, prdName, myAmount,
                            prdCategory, prdPrice, brId, brhName);
                        //     .then((vl) {
                        //   Navigator.pop(context);
                        // });
                      },
                      child: Text('ບັນທຶກ',
                          style: TextStyle(
                              color: MyColors.blueColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp)),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      );
    },
  );
}
