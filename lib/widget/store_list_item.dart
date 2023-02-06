import 'package:flutter/material.dart';

class StoreListItem extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final String title;
  const StoreListItem(
      {super.key,
      required this.onTap,
      required this.icon,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 170,
        child: Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(
              children: [
                Icon(
                  icon,
                  size: 40,
                ),
                Text(title),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
