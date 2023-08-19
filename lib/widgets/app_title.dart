import 'package:flutter/material.dart';

import '../utils/colors.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: const TextSpan(
          text: "BUILD A RAZOR SHARP ",
          style: TextStyle(
            color: AppColors.grey,
            fontWeight: FontWeight.w800,
            fontSize: 20,
          ),
          children: [
            TextSpan(
              text: "JAWLINE",
              style: TextStyle(
                color: AppColors.yellow,
                fontStyle: FontStyle.italic,
              ),
            )
          ]),
    );
  }
}
