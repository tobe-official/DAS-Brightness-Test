import 'package:flutter/material.dart';

@immutable
class AppAssets {
  const AppAssets._();

  static const String _imagesDir = 'assets/images';
  static const String _iconsDir = 'assets/icons';

  // images
  static const method1 = '$_imagesDir/method1.svg';
  static const method3 = '$_imagesDir/method3.svg';
  static const method4 = '$_imagesDir/method4.svg';
  static const method5 = '$_imagesDir/not-found.svg';
  static const method7 = '$_imagesDir/method7.svg';
  static const sbbTrain = '$_imagesDir/sbb-train.svg';
  static const blsTrain = '$_imagesDir/bls-train.svg';
  static const sobTrain = '$_imagesDir/sob-train.svg';

  //icons
  static const iconHeaderStop = '$_iconsDir/icon_header_stop.svg';
}
