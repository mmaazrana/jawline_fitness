import 'package:flutter/material.dart';

import '../models/exercise.dart';
import '../widgets/bottom_sheets/about_exercise_bottom_sheet.dart';

class Helpers {
  static String formatDate(DateTime date) {
    // Implement date formatting logic here
    return date.toString();
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
