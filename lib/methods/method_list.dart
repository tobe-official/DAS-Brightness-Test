import 'package:ip_sprint_brightness/assets.dart';
import 'package:ip_sprint_brightness/models/method_model.dart';

class MethodList {
  final List<MethodModel> methods = [
    MethodModel(
        name: 'Drag up and down',
        description:
            'Swipe from top left to bottom right to lower brightness and from bottom left to top right to increase the brightness.',
        image: AppAssets.method1,
        page: 'Method1'),
    MethodModel(
        name: 'Drag up and down',
        description:
            'Swipe from top left to bottom right to decrease the brightness and from bottom right to top left to increase it',
        image: AppAssets.method2,
        page: 'Method2'),
    MethodModel(
        name: 'Double Tap',
        description: 'Double tap on the text to either increase or decrease the brightness',
        image: AppAssets.method3,
        page: 'Method3'),
    MethodModel(
        name: 'Long press on the screen',
        description: 'Press long on the text to increase or decrease the brightness',
        image: AppAssets.method4,
        page: 'Method4'),
    MethodModel(
        name: 'Horizontal drags',
        description:
            'Drag horizontally to the right to increase and horizontally to the left to decrease the brightness',
        image: AppAssets.method7,
        page: 'Method7'),
    MethodModel(
        name: 'Set to max brightness',
        description: 'Set to max brightness using this button',
        image: AppAssets.method5,
        page: 'Method5'),
  ];
}
