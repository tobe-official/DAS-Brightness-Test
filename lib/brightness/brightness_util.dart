import 'package:flutter/material.dart';
import 'package:screen_brightness/screen_brightness.dart';

class BrightnessUtil {
  static Future<bool> setBrightness(double brightness) async {
    try {
      await ScreenBrightness().setApplicationScreenBrightness(brightness.clamp(0.0, 1.0));
      return true;
    } catch (e) {
      debugPrint("Helligkeit konnte nicht geändert werden: $e");
      return false;
    }
  }

  static Future<double> getCurrentBrightness() async {
    try {
      return await ScreenBrightness().application;
    } catch (e) {
      debugPrint("Fehler beim Abfragen der Helligkeit: $e");
      return 0.5;
    }
  }
}
