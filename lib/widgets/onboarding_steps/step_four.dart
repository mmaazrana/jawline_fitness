import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jawline_fitness/utils/size_config.dart';

import '../../utils/colors.dart';
import '../number_picker.dart';

class StepFour extends StatelessWidget {
  final void Function(int age) setAge;

  const StepFour({
    super.key,
    required int currentValue,
    required this.setAge,
  }) : _currentValue = currentValue;

  final int _currentValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                value: _currentValue,
                minValue: 18,
                maxValue: 90,
                step: 1,
                haptics: true,
                itemCount: 5,
                itemHeight: 80,
                itemWidth: SizeConfig.screenWidth - 120,
                onChanged: (value) {
                  setAge(value);
                },
              ),
            ),
            SvgPicture.asset("assets/pointer.svg",
                colorFilter: const ColorFilter.mode(
                    AppColors.lightBlack, BlendMode.srcIn),
                semanticsLabel: 'A red up arrow'),
          ],
        ),
        Text('Current value: $_currentValue'),
      ],
    );
  }
}
