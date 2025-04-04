import 'package:flutter/material.dart';
import 'package:ip_sprint_brightness/header_mock/main_container.dart';
import 'package:ip_sprint_brightness/header_mock/time_container.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _background(context),
        _containers(context),
      ],
    );
  }

  Widget _background(BuildContext context) {
    return Container(
      width: double.infinity,
      color: SBBColors.royal,
      height: sbbDefaultSpacing * 2,
    );
  }

  Widget _containers(BuildContext context) {
    return Row(
      children: const [
        Expanded(child: MainContainer()),
        TimeContainer(),
      ],
    );
  }
}
