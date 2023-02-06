import 'package:flutter/material.dart';
import 'package:meesooklife_app/constant/font.dart';

import '../../constant/theme.dart';

class DeverloperTeamPage extends StatefulWidget {
  const DeverloperTeamPage({super.key});

  @override
  State<DeverloperTeamPage> createState() => _DeverloperTeamPageState();
}

class _DeverloperTeamPageState extends State<DeverloperTeamPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'ທີມນັກພັດທະນາ',
            style: appBarStyle(),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(gradient: MSLheme.appBarGradient),
          )),
      body: SafeArea(child: Text('')),
    );
  }
}
