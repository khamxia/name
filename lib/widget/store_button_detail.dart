import 'package:flutter/material.dart';
import 'package:meesooklife_app/constant/theme.dart';
import '../constant/my_colors.dart';

class StoreButtonDetail extends StatelessWidget {
  final TextEditingController moneycontroller;
  final VoidCallback onPressed;
  const StoreButtonDetail(
      {super.key, required this.moneycontroller, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
              // color: MyColors.blueColor,
              gradient: MSLheme.appBarGradient,
              borderRadius: BorderRadius.circular(5)),
          child: const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
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
      ),
      // Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   children: [
      //     Expanded(
      //       child: Container(
      //         height: 40,
      //         decoration: BoxDecoration(
      //             shape: BoxShape.rectangle,
      //             borderRadius: BorderRadius.circular(5)),
      //         child: TextFormField(
      //           controller: moneycontroller,
      //           readOnly: true,
      //           decoration: InputDecoration(
      //             suffixText: 'ກີບ',
      //             isDense: true,
      //             enabledBorder: OutlineInputBorder(
      //               borderSide: const BorderSide(color: MyColors.hintColor),
      //               borderRadius: BorderRadius.circular(5),
      //             ),
      //             focusedBorder: OutlineInputBorder(
      //                 borderSide: const BorderSide(color: MyColors.hintColor),
      //                 borderRadius: BorderRadius.circular(5)),
      //           ),
      //         ),
      //       ),
      //     ),
      //     const SizedBox(width: 2),
      //     Expanded(
      //       child: InkWell(
      //         onTap: onPressed,
      //         child: Container(
      //           height: 40,
      //           decoration: BoxDecoration(
      //               color: MyColors.blueColor,
      //               borderRadius: BorderRadius.circular(5)),
      //           child: const Center(
      //             child: Text(
      //               'ສັ່ງຊື້',
      //               style: TextStyle(
      //                   color: MyColors.whiteColor,
      //                   fontSize: 16,
      //                   fontWeight: FontWeight.w600),
      //             ),
      //           ),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
    ;
  }
}
