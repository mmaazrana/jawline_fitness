import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jawline_fitness/utils/colors.dart';
import 'package:jawline_fitness/utils/size_config.dart';

class StepTwo extends StatefulWidget {
  final void Function(String gender) setGender;
  const StepTwo({
    super.key,
    required this.setGender,
  });

  @override
  State<StepTwo> createState() => _StepTwoState();
}

class _StepTwoState extends State<StepTwo> {
  List<bool> isSelected = [true, false];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SizeConfig().init(context);
  }

  @override
  Widget build(BuildContext context) {
    return SizeConfig.isLandscape ? _buildLayout(0.25) : _buildLayout(0.375);
  }

  @override
  void initState() {
    super.initState();
  }

  void selectGender(String gender, int selectedIndex) {
    setState(
      () => isSelected =
          List.generate(isSelected.length, (index) => index == selectedIndex),
    );
    widget.setGender(gender);
  }

  _buildLayout(double width) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () => selectGender("MALE", 0),
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(
              AppColors.lightBlack.withOpacity(isSelected[0] ? 0 : 0.75),
              BlendMode.srcOver,
            ),
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                border: Border.all(
                  color: isSelected[0] ? AppColors.yellow : AppColors.darkGrey,
                  width: 4,
                ),
                borderRadius: BorderRadius.circular(100),
              ),
              width: SizeConfig.screenWidth * width,
              height: SizeConfig.screenWidth * width,
              child: SvgPicture.asset(
                "assets/male.svg",
              ),
            ),
          ),
        ),
        TextButton(
          onPressed: () => selectGender("FEMALE", 1),
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(
              AppColors.lightBlack.withOpacity(isSelected[1] ? 0 : 0.75),
              BlendMode.srcOver,
            ),
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                border: Border.all(
                  color: isSelected[1] ? AppColors.yellow : AppColors.darkGrey,
                  width: 4,
                ),
                borderRadius: BorderRadius.circular(100),
              ),
              width: SizeConfig.screenWidth * width,
              height: SizeConfig.screenWidth * width,
              child: SvgPicture.asset(
                "assets/female.svg",
              ),
            ),
          ),
        )
      ],
    );
  }
}
