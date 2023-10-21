import 'dart:io';

import 'package:flutter/material.dart';

import '../models/exercise.dart';
import '../widgets/bottom_sheets/about_exercise_bottom_sheet.dart';

class Helpers {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/6300978111";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/2934735716";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get nativeAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/2247696110";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/3986624511";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String formatDate(DateTime date) {
    // Implement date formatting logic here
    return date.toString();
  }

  static String formatTime(int hour, int minute) {
    return '${formatNumberToTwoDigit(hour)}:${formatNumberToTwoDigit(minute)}';
  }

  static String formatNumberToTwoDigit(int number) {
    return number.toString().padLeft(2, '0');
  }

  static void aboutExercise({
    required BuildContext context,
    required Exercise exercise,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return AboutExerciseBottomSheet(
          exerciseTitle: exercise.title,
          exerciseDescription: exercise.description,
        );
      },
    );
  }
}
