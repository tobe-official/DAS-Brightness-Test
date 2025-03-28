import 'package:flutter/material.dart';
import 'package:screen_brightness/screen_brightness.dart';

class BrightnessUtil {
  static Future<void> setBrightness(double brightness, BuildContext context) async {
    try {
      await ScreenBrightness().setApplicationScreenBrightness(brightness.clamp(0.0, 1.0));
    } catch (e) {
      _showSnackBar(context, "Helligkeit konnte nicht geändert werden.");
      debugPrint("Fehler beim Setzen der Helligkeit: $e");
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

  static void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
