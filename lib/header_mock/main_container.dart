import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ip_sprint_brightness/assets.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

class MainContainer extends StatelessWidget {
  const MainContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: SBBColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(horizontal: sbbDefaultSpacing * 0.5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _topHeaderRow(context),
          _divider(),
          _bottomHeaderRow(context),
        ],
      ),
    );
  }

  Widget _bottomHeaderRow(BuildContext context) {
    return SizedBox(
      height: 48.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _radioChanel(),
          SizedBox(width: sbbDefaultSpacing * 0.5),
          _departureAuthorization(),
          Spacer(),
          _trainJourneyText(context),
        ],
      ),
    );
  }

  Widget _trainJourneyText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: sbbDefaultSpacing * 0.5),
      child: Text(
        'T9999 SBB',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          fontFamily: SBBFontFamily.sbbFontRoman,
          height: 20 / 16,
          fontStyle: FontStyle.normal,
        ),
      ),
    );
  }

  Widget _divider() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: sbbDefaultSpacing * 0.5),
      child: Divider(height: 1.0, color: SBBColors.cloud),
    );
  }

  Widget _topHeaderRow(BuildContext context) {
    return SizedBox(
      height: 48.0,
      child: Row(
        children: [
          SvgPicture.asset(AppAssets.iconHeaderStop),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: sbbDefaultSpacing * 0.5),
              child: Text(
                'Nächster Halt',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w300,
                  fontFamily: SBBFontFamily.sbbFontLight,
                  height: 32 / 24,
                ),
              ),
            ),
          ),
          _buttonArea(context),
        ],
      ),
    );
  }

  Widget _buttonArea(BuildContext context) {
    return Wrap(
      spacing: sbbDefaultSpacing * 0.5,
      children: [
        _sbbButton('Nachtmodus', SBBIcons.moon_small, context),
        _sbbButton('Pause', SBBIcons.pause_small, context),
        _sbbButton('', SBBIcons.context_menu_small, context),
      ],
    );
  }

  Widget _radioChanel() {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 258),
      child: Row(
        spacing: sbbDefaultSpacing * 0.5,
        children: [
          const Icon(SBBIcons.telephone_gsm_small),
          Text(
            '1311',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w300,
              fontFamily: SBBFontFamily.sbbFontLight,
              height: 32 / 24,
            ),
          ),
        ],
      ),
    );
  }

  Widget _departureAuthorization() {
    return Row(
      children: [
        Icon(
          SBBIcons.circle_tick_small,
          color: SBBColors.black,
        ),
        const SizedBox(width: sbbDefaultSpacing * 0.5),
        Text(
          '',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w300,
            fontFamily: SBBFontFamily.sbbFontLight,
            height: 32 / 24,
          ),
        ),
      ],
    );
  }

  Widget _sbbButton(String label, IconData icon, BuildContext context) {
    return TextButton(
      onPressed: () {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Oops, pressed a button...'),
          ),
        );
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 25,
            color: SBBColors.charcoal,
          ),
          SizedBox(
            width: 4,
          ),
          Text(
            label,
            style: TextStyle(fontSize: 20, color: SBBColors.charcoal),
          )
        ],
      ),
    );
  }
}
