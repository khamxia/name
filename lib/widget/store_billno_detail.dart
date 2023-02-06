import 'package:flutter/material.dart';

class StoreBillNoDetail extends StatelessWidget {
  final String proName;
  final String proAmount;
  final String proPrice;
  final String proTotal;
  const StoreBillNoDetail({
    super.key,
    required this.proName,
    required this.proAmount,
    required this.proPrice,
    required this.proTotal,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              proName,
              maxLines: 2,
              style: const TextStyle(overflow: TextOverflow.ellipsis),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              proPrice,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              proAmount,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              proTotal,
            ),
          ),
        ],
      ),
    );
    ;
  }
}
