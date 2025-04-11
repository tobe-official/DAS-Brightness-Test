import 'package:flutter/material.dart';
import 'package:ip_sprint_brightness/brightness/brightness_util.dart';
import 'package:ip_sprint_brightness/flappy_bird/flappy_screen.dart';
import 'package:ip_sprint_brightness/global_widgets/custom_appbar.dart';
import 'package:ip_sprint_brightness/header_mock/header.dart';
import 'package:ip_sprint_brightness/models/method_model.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

class BaseSite extends StatefulWidget {
  const BaseSite({super.key, required this.method});

  final MethodModel method;

  @override
  State<BaseSite> createState() => _BaseSiteState();
}

class _BaseSiteState extends State<BaseSite> {
  bool _isPressing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.method.name),
      backgroundColor: SBBColors.milk,
      body: _buildContent(context),
    );
  }

  Widget buildCenteredDescription(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 300),
        child: Text(
          widget.method.description,
          style: const TextStyle(
            fontSize: 16,
            color: SBBColors.black,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget wrapInFullScreenContainer(BuildContext context, {required Widget gestureHeader}) {
    return SizedBox.expand(
      child: Column(
        children: [
          gestureHeader,
          const SizedBox(height: 24),
          Expanded(
            child: buildCenteredDescription(context),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    switch (widget.method.page) {
      case 'Method1':
        return _method1(context);
      case 'Method3':
        return _method3(context);
      case 'Method4':
        return _method4(context);
      case 'Method5':
        return _method5(context);
      case 'Method7':
        return _method7(context);
      default:
        return _defaultMethod();
    }
  }

  Widget _defaultMethod() {
    return const Center(child: Text("No method available."));
  }

  Widget _method1(BuildContext context) {
    return wrapInFullScreenContainer(
      context,
      gestureHeader: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onVerticalDragUpdate: (details) async {
          double value = await BrightnessUtil.getCurrentBrightness();
          if (details.delta.dy < 0) {
            value = (value + 0.01).clamp(0.0, 1.0);
          } else if (details.delta.dy > 0) {
            value = (value - 0.01).clamp(0.0, 1.0);
          }
          BrightnessUtil.setBrightness(value);
        },
        child: const Header(),
      ),
    );
  }

  Widget _method3(BuildContext context) {
    return wrapInFullScreenContainer(
      context,
      gestureHeader: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onDoubleTap: () async {
          final current = await BrightnessUtil.getCurrentBrightness();
          final newBrightness = current < 0.5 ? 1.0 : 0.1;
          BrightnessUtil.setBrightness(newBrightness);
        },
        onLongPress: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const FlappyScreen()));
        },
        child: const Header(),
      ),
    );
  }

  void _startDimming() async {
    _isPressing = true;
    double value = await BrightnessUtil.getCurrentBrightness();
    final bool shouldDim = value >= 0.5 ? true : false;

    while (_isPressing) {
      value = shouldDim ? (value - 0.05).clamp(0.0, 1.0) : (value + 0.05).clamp(0.0, 1.0);
      await BrightnessUtil.setBrightness(value);
      await Future.delayed(const Duration(milliseconds: 100));
    }
  }

  void _stopDimming() {
    _isPressing = false;
  }

  Widget _method4(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onLongPressStart: (_) async {
        _startDimming();
      },
      onLongPressEnd: (_) => _stopDimming(),
      child: const Header(),
    );
  }

  Widget _method5(BuildContext context) {
    return wrapInFullScreenContainer(
      context,
      gestureHeader: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          BrightnessUtil.setBrightness(1.0);
        },
        child: const Header(),
      ),
    );
  }

  Widget _method7(BuildContext context) {
    return wrapInFullScreenContainer(
      context,
      gestureHeader: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onHorizontalDragUpdate: (details) async {
          double value = await BrightnessUtil.getCurrentBrightness();
          if (details.delta.dx > 0) {
            value = (value + 0.01).clamp(0.0, 1.0);
          } else if (details.delta.dx < 0) {
            value = (value - 0.01).clamp(0.0, 1.0);
          }
          BrightnessUtil.setBrightness(value);
        },
        child: const Header(),
      ),
    );
  }
}
