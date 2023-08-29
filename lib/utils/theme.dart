import 'package:flutter/material.dart';

import 'colors.dart';

class AppThemes {
  static late ThemeData calendarTheme;
  static late ThemeData timePickerTheme;

  void init(BuildContext context) {
    calendarTheme = Theme.of(context).copyWith(
      colorScheme: const ColorScheme.dark(
        primary: AppColors.yellow, // header background color
        onSurface: AppColors.grey, // body text color
        onPrimary: AppColors.lightBlack, // header text color
        onSurfaceVariant: AppColors.grey,
        outlineVariant: AppColors.darkGrey,
      ),
      useMaterial3: true,
    );

    timePickerTheme = Theme.of(context).copyWith(
      colorScheme: const ColorScheme.dark(
        primary: AppColors.yellow, // header background color
        onPrimary: AppColors.darkGrey, // header text color
        onSurface: AppColors.grey, // body text color
        onTertiaryContainer: AppColors.grey,
        tertiaryContainer: AppColors.lightBlack,
        surface: AppColors.darkGrey,
        surfaceTint: AppColors.darkGrey,
        outline: AppColors.lightBlack,
      ),
      useMaterial3: true,
      textTheme: const TextTheme(
        headlineSmall: TextStyle(
          color: AppColors.grey,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.yellow, // button text color
        ),
      ),
    );
  }
}
