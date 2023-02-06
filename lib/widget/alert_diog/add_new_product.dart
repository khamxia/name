import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constant/my_colors.dart';
import '../../utilities/calculate_price.dart';

class AddNewProduct extends StatelessWidget {
  final String prdImage;
  final int prdId;
  final String prdName;
  final int prdAmount;
  final String prdCategory;
  final int prdPrice;
  final int brId;
  final String brhName;

  const AddNewProduct(
      {super.key,
      required this.prdImage,
      required this.prdId,
      required this.prdName,
      required this.prdAmount,
      required this.prdCategory,
      required this.prdPrice,
      required this.brId,
      required this.brhName});

  @override
  Widget build(BuildContext context) {
    int myAmount = 1;

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
  }
}
