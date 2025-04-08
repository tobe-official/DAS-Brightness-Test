import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

class EvuBirdSelection extends StatelessWidget {
  const EvuBirdSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      enableDrag: false,
      builder: (context) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: SBBColors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Choose your EVU',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: sbbDefaultSpacing),
              _buildEvuButton(context, 'SBB'),
              const SizedBox(height: sbbDefaultSpacing / 2),
              _buildEvuButton(context, 'BLS'),
              const SizedBox(height: sbbDefaultSpacing / 2),
              _buildEvuButton(context, 'SOB'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEvuButton(BuildContext context, String evu) {
    return ElevatedButton(
      child: Text(evu),
      onPressed: () {
        Navigator.of(context).pop(evu);
      },
    );
  }
}
