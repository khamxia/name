import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meesooklife_app/constant/my_colors.dart';

class WalletDetail extends StatelessWidget {
  final String images;
  final String date;
  final String wallet;
  final String detail;
  final String billNo;
  const WalletDetail({
    super.key,
    required this.images,
    required this.date,
    required this.wallet,
    required this.detail,
    required this.billNo,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 55.w,
              height: 55.h,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage(images), fit: BoxFit.fill)),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(date),
                      Text(
                        wallet,
                        style: TextStyle(
                            color: MyColors.cancelColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 16.sp),
                      ),
                    ],
                  ),
                  Text(
                    'ລາຍລະອຽດ: $detail',
                    maxLines: 1,
                    style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(billNo),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
