import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'size_config.dart';

class SvgAssets {
  static FittedBox createLineSvg(String svgAssetPath) {
    return FittedBox(
      fit: BoxFit.fitWidth,
      child: SizedBox(
        width: SizeConfig.screenWidth,
        child: Transform.scale(
          scale: 1.35,
          child: SvgPicture.asset(
            svgAssetPath,
          ),
        ),
      ),
    );
  }

  static final FittedBox line1 = createLineSvg("assets/line1.svg");
  static final FittedBox line2 = createLineSvg("assets/line2.svg");
  static final FittedBox line3 = createLineSvg("assets/line3.svg");
  static final FittedBox line4 = createLineSvg("assets/line4.svg");
  static final FittedBox line5 = createLineSvg("assets/line5.svg");
  static final FittedBox line6 = createLineSvg("assets/line6.svg");
}
