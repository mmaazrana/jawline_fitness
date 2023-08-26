import 'package:flutter/material.dart';
import 'package:jawline_fitness/utils/size_config.dart';

import 'colors.dart';

class AppStyles {
  static const TextStyle heading = TextStyle(
    fontSize: 42,
    fontWeight: FontWeight.w800,
    color: AppColors.yellow,
  );

  static const TextStyle secondaryHeading = TextStyle(
    fontWeight: FontWeight.w800,
    fontSize: 32,
    color: AppColors.grey,
  );

  static const TextStyle tertiaryHeading = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w800,
    color: AppColors.grey,
  );

  static const TextStyle alternateHeading = TextStyle(
    fontSize: 32,
    color: AppColors.yellow,
    fontWeight: FontWeight.w900,
    fontStyle: FontStyle.italic,
  );

  static const TextStyle description = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: AppColors.grey,
  );

  static const TextStyle alternateDescription = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.grey,
  );

  static const TextStyle primaryButtonText = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w800,
    color: AppColors.lightBlack,
  );

  static const TextStyle secondaryButtonText = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w800,
    color: AppColors.grey,
  );

  static const TextStyle alternateSecondaryButtonText = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w800,
    color: AppColors.grey,
  );

  static const TextStyle tertiaryButtonText = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.grey,
  );

  static const TextStyle tertiaryButtonTextDisabled = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.darkGrey,
  );

  static const TextStyle counterText = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w800,
    color: AppColors.yellow,
  );

  static const TextStyle alternateCounterText = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w800,
    color: AppColors.yellow,
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
    backgroundColor: AppColors.darkGrey,
    padding: const EdgeInsets.all(12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(100.0),
    ),
  );

  static ButtonStyle zeroPadding =
      IconButton.styleFrom(padding: EdgeInsets.zero);

  static ButtonStyle tertiaryButton = ElevatedButton.styleFrom(
    backgroundColor: AppColors.lightBlack,
    padding: const EdgeInsets.all(12),
  );

  static ButtonStyle skipButton = TextButton.styleFrom(
    padding: EdgeInsets.zero,
    backgroundColor: AppColors.lightBlack,
  );

  static const BoxDecoration bottomOutlineYellow = BoxDecoration(
    border: Border(
      bottom: BorderSide(
        color: AppColors.yellow,
        width: 3,
      ),
    ),
  );

  static const BoxDecoration rightOutlineYellow = BoxDecoration(
    border: Border(
      right: BorderSide(
        color: AppColors.yellow,
        width: 3,
      ),
    ),
  );

  static BoxDecoration yellowOutline = BoxDecoration(
    color: AppColors.lightBlack,
    border: Border.all(
      color: AppColors.yellow,
      width: 2,
      strokeAlign: BorderSide.strokeAlignOutside,
    ),
    borderRadius: BorderRadius.circular(100),
  );

  static BoxDecoration darkGreyOutline = BoxDecoration(
    color: AppColors.lightBlack,
    border: Border.all(
      color: AppColors.darkGrey,
      width: 2,
      strokeAlign: BorderSide.strokeAlignOutside,
    ),
    borderRadius: BorderRadius.circular(100),
  );

  static BoxDecoration calendarBorder = BoxDecoration(
      borderRadius: BorderRadius.circular(18),
      border: Border.all(
        color: AppColors.darkGrey,
        width: 3,
      ));
}
