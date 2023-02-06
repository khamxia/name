import 'package:flutter/material.dart';

class BillNo extends StatelessWidget {
  final String billNo;
  final String amount;
  final String total;
  final String date;
  final VoidCallback onTap;
  const BillNo({
    super.key,
    required this.billNo,
    required this.amount,
    required this.total,
    required this.date,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Expanded(
              child: Text(
                billNo,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Text(
                amount,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Text(
                total,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Text(
                date,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
    ;
  }
}
