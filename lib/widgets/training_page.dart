import 'package:flutter/material.dart';
import 'package:jawline_fitness/widgets/levels_list.dart';

import '../utils/routes.dart';
import '../utils/size_config.dart';
import '../utils/styles.dart';
import 'days_list.dart';

class TrainingPage extends StatelessWidget {
  const TrainingPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isLandscape = constraints.maxWidth > 720;
        return isLandscape
            ? _buildTwoColumnLayout(context)
            : _buildSingleColumnLayout(context);
      },
    );
  }

  Widget _buildTwoColumnLayout(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 12, 10, 0),
            child: Column(
              children: [
                LevelsList(viewPortFraction: 1),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 12, 34, 0),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, Routes.exerciseScreen);
                  },
                  style: AppStyles.primaryButton,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Continue",
                        style: AppStyles.primaryButtonText,
                      ),
                      const Icon(
                        Icons.chevron_right_rounded,
                        size: 24,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  height: SizeConfig.screenHeight - 165,
                  child: const DaysList(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSingleColumnLayout(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 150,
          child: LevelsList(viewPortFraction: 0.9),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(34, 25, 34, 0),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(
                      context, Routes.exerciseScreen);
                },
                style: AppStyles.primaryButton,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Continue",
                      style: AppStyles.primaryButtonText,
                    ),
                    const Icon(
                      Icons.chevron_right_rounded,
                      size: 24,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              SizedBox(
                height: SizeConfig.screenHeight - (25 + 45 + 150 + 220),
                child: const DaysList(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
