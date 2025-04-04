import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

class TimeContainer extends StatelessWidget {
  const TimeContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: SBBColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsetsDirectional.fromSTEB(
        sbbDefaultSpacing * 0.5,
        0,
        sbbDefaultSpacing * 0.5,
        0,
      ),
      padding: const EdgeInsets.symmetric(horizontal: sbbDefaultSpacing * 0.5),
      child: SizedBox(
        width: 124.0,
        height: 113,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _currentTime(),
            _divider(),
            _punctualityDisplay(context),
          ],
        ),
      ),
    );
  }
}

Widget _divider() {
  return const Padding(
    padding: EdgeInsets.symmetric(vertical: sbbDefaultSpacing * 0.5),
    child: Divider(height: 1.0, color: SBBColors.cloud),
  );
}

Widget _punctualityDisplay(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(sbbDefaultSpacing * 0.5, 0.0, sbbDefaultSpacing * 0.5, sbbDefaultSpacing * 0.5),
    child: Text(
      '-00:00',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w300,
        fontFamily: SBBFontFamily.sbbFontLight,
        height: 32 / 24,
      ),
    ),
  );
}

Widget _currentTime() {
  return Padding(
    padding: const EdgeInsets.fromLTRB(sbbDefaultSpacing * 0.5, sbbDefaultSpacing * 0.5, sbbDefaultSpacing * 0.5, 0),
    child: Text(
      '13:58:29',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w300,
        fontFamily: SBBFontFamily.sbbFontLight,
        height: 32 / 24,
      ),
    ),
  );
}
