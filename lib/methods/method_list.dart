import 'package:ip_sprint_brightness/assets.dart';
import 'package:ip_sprint_brightness/models/method_model.dart';

class MethodList {
  final List<MethodModel> methods = [
    MethodModel(
        name: 'Drag both directions down',
        description:
            'Swipe from top left to bottom right to lower brightness and from top right to bottom left to increase the brightness.',
        image: AppAssets.method1,
        page: 'BaseSite'),
    MethodModel(
        name: 'Drag up and down',
        description:
            'Swipe from top left to bottom right to decrease the brightness and from bottom left to top right to increase it',
        image: AppAssets.method2,
        page: 'BaseSite'),
    MethodModel(name: 'name2', description: 'method2', image: AppAssets.method3, page: 'BaseSite'),
    MethodModel(name: 'name3', description: 'method3', image: AppAssets.method4, page: 'BaseSite'),
    MethodModel(name: 'name4', description: 'method4', image: AppAssets.method5, page: 'BaseSite'),
  ];
}
