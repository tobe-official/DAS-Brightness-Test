import 'package:flutter/material.dart';
import 'package:ip_sprint_brightness/global_widgets/custom_appbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Choose your favorite way',
      ),
    );
  }
}
