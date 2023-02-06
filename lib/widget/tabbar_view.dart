import 'package:flutter/material.dart';
import '../constant/image.dart';
import '../constant/my_colors.dart';

class TabBarViews extends StatelessWidget {
  final VoidCallback onTap;
  final Widget widget;
  final String title;
  final String subtitle;
  final String trailing;
  final String startWay;
  final String endWay;
  const TabBarViews(
      {super.key,
      required this.onTap,
      required this.widget,
      required this.title,
      required this.subtitle,
      required this.trailing,
      required this.startWay,
      required this.endWay});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        child: Stack(
          children: [
            widget,
            Column(
              children: [
                ListTile(
                  title: Text(
                    'ບິນ $title',
                    maxLines: 1,
                    style: const TextStyle(overflow: TextOverflow.ellipsis),
                  ),
                  subtitle: Text(subtitle),
                  trailing: Text(
                    trailing,
                    style: const TextStyle(
                        color: MyColors.cancelColor, fontSize: 16),
                  ),
                ),
                const Divider(
                  thickness: 2,
                  indent: 15,
                  endIndent: 15,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                    children: [
                      Expanded(child: Text(startWay)),
                      const Expanded(child: Icon(Icons.arrow_forward)),
                      Expanded(child: Text(endWay))
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
    ;
  }
}
