import 'package:flutter/material.dart';
import 'package:jawline_fitness/utils/size_config.dart';

import 'colors.dart';

class AppStyles {
  static TextStyle heading = const TextStyle(
    fontSize: 42,
    fontWeight: FontWeight.w800,
    color: AppColors.yellow,
  );

  static TextStyle description = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: AppColors.grey,
  );

  static TextStyle primaryButtonText = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w800,
    color: AppColors.lightBlack,
  );

  static TextStyle secondaryButtonText = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.grey,
  );

  static TextStyle boldIconBlack = TextStyle(
    inherit: false,
    color: AppColors.lightBlack,
    fontSize: 28,
    fontWeight: FontWeight.w800,
    fontFamily: Icons.chevron_left_rounded.fontFamily,
    package: Icons.chevron_left_rounded.fontPackage,
  );

  static TextStyle boldIconYellow = TextStyle(
    inherit: false,
    color: AppColors.yellow,
    fontSize: 28,
    fontWeight: FontWeight.w800,
    fontFamily: Icons.chevron_left_rounded.fontFamily,
    package: Icons.chevron_left_rounded.fontPackage,
  );
  static ButtonStyle primaryButton = ElevatedButton.styleFrom(
    backgroundColor: AppColors.yellow,
    padding: const EdgeInsets.all(12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(100.0),
    ),
    minimumSize: Size(
      SizeConfig.screenWidth - 50,
      45,
    ),
  );

  static ButtonStyle secondaryButton = ElevatedButton.styleFrom(
    backgroundColor: AppColors.lightBlack,
    padding: const EdgeInsets.all(12),
  );
}
