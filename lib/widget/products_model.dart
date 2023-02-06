import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../constant/my_colors.dart';

class ProductsWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String imageProduct;
  final String nameProduct;
  final String subNameProduct;
  final int priceProduct;
  const ProductsWidget(
      {super.key,
      required this.onTap,
      required this.imageProduct,
      required this.nameProduct,
      required this.subNameProduct,
      required this.priceProduct});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.network(
                    imageProduct,
                    fit: BoxFit.fill,
                    width: double.infinity,
                    height: 110.h,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Text(
                    nameProduct,
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        color: MyColors.blackColor,
                        overflow: TextOverflow.ellipsis),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Text(
                    subNameProduct,
                    maxLines: 3,
                    style: const TextStyle(
                      color: MyColors.hintColor,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 5.h),
              child: Center(
                child: Text(
                  '${NumberFormat.currency(symbol: '', decimalDigits: 0).format(priceProduct)} ກີບ',
                  style: TextStyle(
                    color: MyColors.cancelColor,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
