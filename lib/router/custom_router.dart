import 'package:flutter/material.dart';
import 'package:ip_sprint_brightness/models/method_model.dart';
import 'package:ip_sprint_brightness/pages/base_site/base_site.dart';

class CustomRouter {
  const CustomRouter({required this.context});

  final BuildContext context;

  void routeToPage(MethodModel method) {
    switch (method.page) {
      case 'BaseSite':
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BaseSite(
              method: method,
            ),
          ),
        );
        break;
      default:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BaseSite(
              method: method,
            ),
          ),
        );
        break;
    }
  }
}
