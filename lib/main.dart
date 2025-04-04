import 'package:flutter/material.dart';
import 'package:ip_sprint_brightness/pages/home_page/home_page.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: SBBTheme.light(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
