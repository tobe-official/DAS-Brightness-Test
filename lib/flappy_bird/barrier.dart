import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

class Barrier extends StatelessWidget {
  final double xPos;
  final double height;
  final bool isBottom;
  final double offset;

  const Barrier({
    super.key,
    required this.xPos,
    required this.height,
    required this.isBottom,
    required this.offset,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double left = screenWidth * (xPos + 1) / 2;

    return Positioned(
      left: left,
      top: isBottom ? null : offset,
      bottom: isBottom ? offset : null,
      child: Container(
        width: 55,
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [SBBColors.iron, SBBColors.charcoal],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: isBottom
              ? const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                )
              : const BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
        ),
      ),
    );
  }
}
