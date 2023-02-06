import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../constant/my_colors.dart';

class TitleProfile extends StatelessWidget {
  final String title;
  const TitleProfile({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: TextStyle(color: MyColors.blackColor, fontSize: 16));
  }
}
