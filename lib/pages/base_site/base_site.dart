import 'package:flutter/material.dart';
import 'package:ip_sprint_brightness/global_widgets/custom_appbar.dart';
import 'package:ip_sprint_brightness/models/method_model.dart';

class BaseSite extends StatelessWidget {
  const BaseSite({super.key, required this.method});

  final MethodModel method;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Base Methods',
      ),
      body: Center(
        child: Text('Description: ${method.description}'),
      ),
    );
  }
}
