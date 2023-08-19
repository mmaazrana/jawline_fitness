import 'package:flutter/material.dart';
import '../widgets/help_icon.dart';
import 'package:jawline_fitness/utils/styles.dart';

class ExerciseName extends StatelessWidget {
  final String exerciseName;
  final void Function() onHelpPressed;

  const ExerciseName({
    super.key,
    required this.exerciseName,
    required this.onHelpPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(exerciseName, style: AppStyles.tertiaryHeading),
        SizedBox(
          width: 30,
          height: 30,
          child: TextButton(
            onPressed: onHelpPressed,
            style: AppStyles.zeroPadding,
            child: const HelpIcon(),
          ),
        )
      ],
    );
  }
}
