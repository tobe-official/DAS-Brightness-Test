import 'package:flutter/material.dart';
import 'package:ip_sprint_brightness/header_mock/main_container.dart';
import 'package:ip_sprint_brightness/header_mock/time_container.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 113,
      width: MediaQuery.of(context).size.width * 0.9,
      child: _containers(context),
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
