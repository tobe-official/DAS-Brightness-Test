import 'package:ip_sprint_brightness/assets.dart';
import 'package:ip_sprint_brightness/models/method_model.dart';

class MethodList {
  final List<MethodModel> methods = [
    MethodModel(
        name: 'Double Tap',
        description: 'Double tap on the header to either increase or decrease the brightness',
        image: AppAssets.method3,
        page: 'Method3'),
    MethodModel(
        name: 'Long press on the screen',
        description: 'Press long on the header to increase or decrease the brightness',
        image: AppAssets.method4,
        page: 'Method4'),
    MethodModel(
        name: 'Drag up and down',
        description: 'Swipe down on the header to lower brightness and up on the header to increase the brightness.',
        image: AppAssets.method1,
        page: 'Method1'),
    MethodModel(
        name: 'Horizontal drags',
        description:
            'Drag horizontally on the header to the right to increase and horizontally to the left on the header to decrease the brightness',
        image: AppAssets.method7,
        page: 'Method7'),
    MethodModel(
        name: 'Set to max brightness',
        description: 'Set to max brightness by tapping on the header once',
        image: AppAssets.method5,
        page: 'Method5'),
  ];
}
