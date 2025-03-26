import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, this.title});

  final String? title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(
        color: SBBColors.white,
      ),
      title: Text(
        title ?? 'DAS Brightness Controller',
        style: TextStyle(color: SBBColors.white),
      ),
      backgroundColor: SBBColors.royal,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(sbbDefaultSpacing * 4);
}
