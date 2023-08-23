import 'package:flutter/widgets.dart';

class SizeConfig {
  static late double screenWidth;
  static late double screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;
  static late double statusBarHeight;
  static late double textMultiplier;
  static late double imageSizeMultiplier;
  static late double heightMultiplier;
  static late Orientation orientation;
  static late bool isLandscape;
  void init(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    screenWidth = mediaQuery.size.width;
    screenHeight = mediaQuery.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
    statusBarHeight = mediaQuery.padding.top;
    textMultiplier = blockSizeVertical;
    imageSizeMultiplier = blockSizeHorizontal;
    orientation = mediaQuery.orientation;
    isLandscape = orientation == Orientation.landscape || screenWidth > 720;
  }
}
