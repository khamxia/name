import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meesooklife_app/constant/theme.dart';

import '../constant/my_colors.dart';

class ButtonDetailProduct extends StatelessWidget {
  final TextEditingController moneycontroller;
  final VoidCallback onPressed;
  final VoidCallback addCartOnPressed;

  const ButtonDetailProduct({
    super.key,
    required this.moneycontroller,
    required this.onPressed,
    required this.addCartOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Expanded(
          //   child: Container(
          //     height: 50,
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceAround,
          //       children: [
          //         InkWell(
          //           hoverColor: MyColors.blueColor,
          //           highlightColor: MyColors.succcessColors,
          //           onTap: minusOnPressed,
          //           child: const Icon(Icons.remove_circle_outline, size: 20),
          //         ),
          //         Text(amount.toString()),
          //         InkWell(
          //           hoverColor: MyColors.blueColor,
          //           highlightColor: MyColors.succcessColors,
          //           onTap: plusOnPressed,
          //           child: const Icon(Icons.add_circle_outline, size: 20),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          Expanded(
            flex: 1,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(color: MyColors.hintColor),
                  // color: MyColors.blueColor,
                  borderRadius: BorderRadius.circular(5)),
              child: TextButton.icon(
                onPressed: addCartOnPressed,
                icon: const Icon(
                  Icons.shopping_cart,
                  color: MyColors.hintColor,
                ),
                label: Text(
                  'ເພີ່ມເຂົ້າກະຕ່າ',
                  style: TextStyle(
                      color: MyColors.hintColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
          SizedBox(width: 5.w),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: onPressed,
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    gradient: MSLheme.appBarGradient,
                    // color: MyColors.blueColor,
                    borderRadius: BorderRadius.circular(5)),
                child: const Center(
                  child: Text(
                    'ສັ່ງຊື້',
                    style: TextStyle(
                        color: MyColors.whiteColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
