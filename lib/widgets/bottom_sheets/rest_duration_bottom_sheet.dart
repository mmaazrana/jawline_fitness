import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jawline_fitness/utils/colors.dart';
import 'package:jawline_fitness/utils/size_config.dart';
import 'package:jawline_fitness/utils/styles.dart';
import 'package:jawline_fitness/widgets/number_picker.dart';

class RestDurationBottomSheet extends StatefulWidget {
  const RestDurationBottomSheet({super.key});

  @override
  State<RestDurationBottomSheet> createState() =>
      _RestDurationBottomSheetState();
}

class _RestDurationBottomSheetState extends State<RestDurationBottomSheet> {
  int currentRestDuration = 20;

  void setRestDuration(int restDuration) {
    setState(() {
      currentRestDuration = restDuration;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight,
      decoration: BoxDecoration(
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 34),
            Text(
              "Current Rest Duration",
              style: TextStyle(
                color: AppColors.grey,
                fontSize: 20.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              currentRestDuration.toString() + "s",
              style: TextStyle(
                color: AppColors.yellow,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SvgPicture.asset(
                  "assets/pointer.svg",
                ),
                SizedBox(
                  width: SizeConfig.isLandscape
                      ? SizeConfig.screenWidth - 382
                      : SizeConfig.screenWidth - 82,
                  child: NumberPicker(
                    value: currentRestDuration,
                    minValue: 1,
                    maxValue: 100,
                    step: 1,
                    haptics: true,
                    itemCount: 3,
                    itemHeight: 80,
                    itemWidth: SizeConfig.screenWidth - 120,
                    onChanged: (value) {
                      setRestDuration(value);
                    },
                  ),
                ),
                SvgPicture.asset("assets/pointer.svg",
                    colorFilter: const ColorFilter.mode(
                        AppColors.lightBlack, BlendMode.srcIn),
                    semanticsLabel: 'A red up arrow'),
              ],
            ),
            SizedBox(height: 25),
            ElevatedButton(
              style: AppStyles.primaryButton,
              onPressed: () {
                // Save button pressed
                // Add your save logic here
              },
              child: Text(
                "Save",
                style: AppStyles.primaryButtonText,
              ),
            ),
            SizedBox(height: 34),
          ],
        ),
      ),
    );
  }
}
