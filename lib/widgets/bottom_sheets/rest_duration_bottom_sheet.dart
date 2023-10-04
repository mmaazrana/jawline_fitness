import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jawline_fitness/utils/colors.dart';
import 'package:jawline_fitness/utils/size_config.dart';
import 'package:jawline_fitness/utils/styles.dart';
import 'package:jawline_fitness/widgets/number_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RestDurationBottomSheet extends StatefulWidget {
  const RestDurationBottomSheet({super.key});

  @override
  State<RestDurationBottomSheet> createState() =>
      _RestDurationBottomSheetState();
}

class _RestDurationBottomSheetState extends State<RestDurationBottomSheet> {
  late int currentRestDuration = 20;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int restDurationData = prefs.getInt('restDuration') ?? 20;
    setState(() {
      currentRestDuration = restDurationData;
      // isOnboarded = false; //hard coded for testing
    });
  }

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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 34),
            const Text(
              "Current Rest Duration",
              style: TextStyle(
                color: AppColors.grey,
                fontSize: 20.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              "${currentRestDuration}s",
              style: const TextStyle(
                color: AppColors.yellow,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 25),
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
            const SizedBox(height: 25),
            ElevatedButton(
              style: AppStyles.primaryButton,
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setInt('restDuration', currentRestDuration);
                // Show a SnackBar when the button is pressed
                const snackBar = SnackBar(
                  content: Text('Rest Duration Updated Successfully'),
                  duration: Duration(seconds: 2),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                Navigator.of(context).pop();
              },
              child: const Text(
                "Save",
                style: AppStyles.primaryButtonText,
              ),
            ),
            const SizedBox(height: 34),
          ],
        ),
      ),
    );
  }
}
