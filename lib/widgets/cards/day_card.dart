import 'package:flutter/material.dart';
import 'package:jawline_fitness/utils/colors.dart';
import 'package:jawline_fitness/utils/styles.dart';

import '../../utils/constants.dart';

class DayCard extends StatelessWidget {
  final String text;
  final int currentDay;
  final bool isSelected;
  final Function() onPressed;
  final Function() onStart;

  const DayCard({
    super.key,
    required this.text,
    required this.currentDay,
    required this.isSelected,
    required this.onPressed,
    required this.onStart,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.all(16.0),
        height: 68,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: isSelected ? AppColors.lightBlack : AppColors.darkGrey,
          border: Border.all(
            color: isSelected ? AppColors.yellow : AppColors.darkGrey,
            width: 2.0,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  color: AppColors.grey,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Constants.days[currentDay].isComplete
                ? Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.lightBlack,
                    ),
                    padding: EdgeInsets.all(4),
                    child: Icon(
                      Icons.check_rounded,
                      color: AppColors.yellow,
                      size: 24,
                    ),
                  )
                : Row(
                    children: [
                      if (isSelected) const SizedBox(width: 16.0),
                      if (isSelected)
                        ElevatedButton(
                          onPressed: onStart,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(5),
                            backgroundColor: AppColors.yellow,
                            minimumSize: const Size(64, 28),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100.0),
                            ),
                          ),
                          child: const Text(
                            'Start',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
