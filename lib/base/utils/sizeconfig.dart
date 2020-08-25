import 'package:flutter/material.dart';
import 'package:voyager/base/utils/global.dart';

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double screenDimension;
  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    screenDimension = (screenWidth / simulatorWidth);
  }
}
