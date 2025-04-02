import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

class Barrier extends StatelessWidget {
  final double xPos;
  final double height;
  final bool isBottom;

  const Barrier({
    super.key,
    required this.xPos,
    required this.height,
    required this.isBottom,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: MediaQuery.of(context).size.width * (xPos + 1) / 2,
      top: isBottom ? null : 0,
      bottom: isBottom ? 0 : null,
      child: Container(
        width: 45,
        height: height,
        color: SBBColors.white,
      ),
    );
  }
}
