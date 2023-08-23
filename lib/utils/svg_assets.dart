import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jawline_fitness/utils/colors.dart';
import 'size_config.dart';

class SvgAssets {
  static Widget createLineSvg(
      String svgAssetPath, double? width, double? height) {
    return ClipRRect(
      child: SizedBox(
        width: width,
        height: height,
        child: Transform.scale(
          alignment: Alignment.center,
          scale: 1.35,
          child: SvgPicture.asset(
            svgAssetPath,
          ),
        ),
      ),
    );
  }

  static const String line1 = "assets/line1.svg";
  static const String line2 = "assets/line2.svg";
  static const String line3 = "assets/line3.svg";
  static const String line4 = "assets/line4.svg";
  static const String line5 = "assets/line5.svg";
  static const String line6 = "assets/line6.svg";
}
