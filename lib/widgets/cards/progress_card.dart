import 'package:flutter/material.dart';
import 'package:jawline_fitness/utils/colors.dart';
import 'package:jawline_fitness/utils/size_config.dart';

import '../wave_clipper.dart';

class ProgressCard extends StatelessWidget {
  final String heading;
  final String description;
  final double progress;

  const ProgressCard({
    super.key,
    required this.heading,
    required this.description,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(12.5, 0, 12.5, 0),
      width: SizeConfig.screenWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.yellow,
          width: 2,
        ),
        color: AppColors.lightBlack,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ClipPath(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              clipper: WaveClipper(),
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                width: SizeConfig.screenWidth,
                color: AppColors.yellow,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      heading,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        height: 1,
                      ),
                    ),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${(progress * 100).toStringAsFixed(1)}%',
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppColors.yellow),
                ),
                const SizedBox(height: 8),
                Theme(
                    data: ThemeData(
                      colorScheme: const ColorScheme.dark(
                        primary: AppColors.yellow, // header background color
                        surface: AppColors.darkGrey,
                      ),
                      useMaterial3: true,
                    ),
                    child: LinearProgressIndicator(value: progress)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
