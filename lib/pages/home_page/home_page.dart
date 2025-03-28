import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ip_sprint_brightness/brightness/brightness_util.dart';
import 'package:ip_sprint_brightness/global_widgets/custom_appbar.dart';
import 'package:ip_sprint_brightness/methods/method_list.dart';
import 'package:ip_sprint_brightness/models/method_model.dart';
import 'package:ip_sprint_brightness/router/custom_router.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    BrightnessUtil.setBrightness(1, context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<MethodModel> methods = MethodList().methods;
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Choose your favorite way',
      ),
      backgroundColor: SBBColors.white,
      body: _body(context, methods),
    );
  }

  Widget _body(BuildContext context, List<MethodModel> methods) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          sbbDefaultSpacing * 4, sbbDefaultSpacing * 2, sbbDefaultSpacing * 4, sbbDefaultSpacing * 2),
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: methods.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: sbbDefaultSpacing * 5,
          mainAxisSpacing: sbbDefaultSpacing * 5,
          childAspectRatio: 2,
        ),
        itemBuilder: (context, index) {
          final method = methods[index];
          return _buildMethodCard(method, context);
        },
      ),
    );
  }

  Widget _buildMethodCard(MethodModel method, BuildContext context) {
    return GestureDetector(
      onTap: () {
        CustomRouter(context: context).routeToPage(method);
      },
      child: Card(
        elevation: 4,
        color: SBBColors.cloud,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: SvgPicture.asset(
                  method.image,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                method.name,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
