import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ip_sprint_brightness/assets.dart';

class Bird extends StatelessWidget {
  final String? evu;

  const Bird({
    super.key,
    required this.evu,
  });

  @override
  Widget build(BuildContext context) {
    String assetPath;

    switch (evu) {
      case 'BLS':
        assetPath = AppAssets.blsTrain;
        break;
      case 'SOB':
        assetPath = AppAssets.sobTrain;
        break;
      default:
        assetPath = AppAssets.sbbTrain;
        break;
    }

    return Transform.translate(
      offset: const Offset(-45, -15),
      child: Transform.scale(
        scale: assetPath != AppAssets.sbbTrain ? 2 : 1,
        child: SvgPicture.asset(
          assetPath,
          width: 90,
          height: 30,
        ),
      ),
    );
  }
}
