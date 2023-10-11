import 'package:flutter/material.dart';
import 'package:jawline_fitness/utils/colors.dart';
import 'package:jawline_fitness/utils/size_config.dart';

class AboutExerciseBottomSheet extends StatelessWidget {
  final String exerciseTitle;
  final String exerciseDescription;

  const AboutExerciseBottomSheet({
    super.key,
    required this.exerciseDescription,
    required this.exerciseTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      padding: const EdgeInsets.all(34),
      decoration: const BoxDecoration(
        color: AppColors.lightBlack, // Semi-dark background color
        border: Border(
          top: BorderSide(
            color: AppColors.darkGrey,
            width: 4,
          ),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              exerciseTitle,
              style: const TextStyle(
                color: AppColors.grey,
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              exerciseDescription,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                color: AppColors.grey,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
