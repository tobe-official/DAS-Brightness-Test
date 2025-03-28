import 'package:flutter/material.dart';
import 'package:ip_sprint_brightness/brightness/brightness_util.dart';
import 'package:ip_sprint_brightness/global_widgets/custom_appbar.dart';
import 'package:ip_sprint_brightness/models/method_model.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

class BaseSite extends StatefulWidget {
  const BaseSite({super.key, required this.method});

  final MethodModel method;

  @override
  State<BaseSite> createState() => _BaseSiteState();
}

class _BaseSiteState extends State<BaseSite> {
  Widget? content;

  @override
  void initState() {
    super.initState();
    switch (widget.method.page) {
      case 'Method1':
        content = _method1();
        break;
      case 'Method2':
        content = _method2();
        break;
      case 'Method3':
        content = _method3();
        break;
      case 'Method4':
        content = _method4();
        break;
      case 'Method5':
        content = _method5();
        break;
      case 'Method6':
        content = _method6();
        break;
      case 'Method7':
        content = _method7();
        break;
      default:
        content = _defaultMethod();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.method.name),
      backgroundColor: SBBColors.white,
      body: content ?? _defaultMethod(),
    );
  }

  Widget _defaultMethod() {
    return Center(child: Text("No method available."));
  }

  Widget _method1() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onPanUpdate: (details) {
        if (details.delta.dx > 5 && details.delta.dy > 5) {
          BrightnessUtil.setBrightness(0.2, context);
        } else if (details.delta.dx < -5 && details.delta.dy < -5) {
          BrightnessUtil.setBrightness(0.8, context);
        }
      },
      child: _showWhatToDo(),
    );
  }

  Widget _method2() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onPanUpdate: (details) {
        if (details.delta.dy > 5) {
          BrightnessUtil.setBrightness(0.2, context);
        } else if (details.delta.dy < -5) {
          BrightnessUtil.setBrightness(0.8, context);
        }
      },
      child: _showWhatToDo(),
    );
  }

  Widget _method3() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onDoubleTap: () async {
        final current = await BrightnessUtil.getCurrentBrightness();
        final newBrightness = current < 0.5 ? 1.0 : 0.1;
        BrightnessUtil.setBrightness(newBrightness, context);
      },
      child: _showWhatToDo(),
    );
  }

  Widget _method4() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onLongPress: () async {
        final current = await BrightnessUtil.getCurrentBrightness();
        final newBrightness = current < 0.5 ? 1.0 : 0.1;
        BrightnessUtil.setBrightness(newBrightness, context);
      },
      child: _showWhatToDo(),
    );
  }

  Widget _method5() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        BrightnessUtil.setBrightness(1.0, context);
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        child: ElevatedButton(
          onPressed: () {
            BrightnessUtil.setBrightness(1.0, context);
          },
          child: const Text('Set to max brightness'),
        ),
      ),
    );
  }

  Widget _method6() {
    return GestureDetector(
      //Implement later
      child: _showWhatToDo(),
    );
  }

  Widget _method7() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onHorizontalDragUpdate: (details) async {
        double value = await BrightnessUtil.getCurrentBrightness();
        if (details.delta.dx > 0) {
          value = (value + 0.05).clamp(0.0, 1.0);
        } else if (details.delta.dx < 0) {
          value = (value - 0.05).clamp(0.0, 1.0);
        }
        BrightnessUtil.setBrightness(value, context);
      },
      child: _showWhatToDo(),
    );
  }

  Widget _showWhatToDo() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      child: Center(
        child: Text(widget.method.description, style: SBBTextStyle().textStyle, textAlign: TextAlign.center),
      ),
    );
  }
}
