import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ip_sprint_brightness/assets.dart';

class Bird extends StatelessWidget {
  const Bird({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      AppAssets.train,
      width: 30,
      height: 30,
    );
  }
}
