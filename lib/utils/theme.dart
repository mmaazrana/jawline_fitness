import 'package:flutter/material.dart';

import 'colors.dart';

class AppThemes {
  static late ThemeData calendarTheme;

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
  }
}
