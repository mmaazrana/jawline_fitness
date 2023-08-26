import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jawline_fitness/utils/colors.dart';
import 'package:jawline_fitness/utils/size_config.dart';
import 'package:jawline_fitness/utils/styles.dart';
import 'package:jawline_fitness/widgets/alarm_card.dart';
import 'package:jawline_fitness/widgets/buttons/tertiary_button.dart';
import 'package:jawline_fitness/widgets/stepper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';
import '../utils/constants.dart';
import '../utils/data_provider.dart';
import '../utils/routes.dart';
import 'buttons/primary_button.dart';
import 'number_picker.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({
    Key? key,
  }) : super(key: key);

  @override
  OnBoardingState createState() => OnBoardingState();
}

class OnBoardingState extends State<OnBoarding> {
  int currentStep = 0;
  var nameController = TextEditingController();
  late final String gender;
  late final String age;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SizeConfig().init(context);
  }

  Future<void> _nextStep(BuildContext context) async {
    if (currentStep < 4) {
      setState(() {
        currentStep++;
      });
    } else if (currentStep == 4) {
      final userDataProvider =
          Provider.of<DataProvider>(context, listen: false);
      final name = nameController.text;
      final age = _currentValue;
      final gender = this.gender;
      final userData = User(name: name, age: age, gender: gender);
      userDataProvider.saveUserData(userData);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('name', name);
      await prefs.setInt('age', age);
      await prefs.setString('gender', gender);
      await prefs.setBool('isOnboarded', true);
      Navigator.pushReplacementNamed(context, Routes.home);
    }
  }

  void _previousStep() {
    setState(() {
      if (currentStep > 0) {
        currentStep--;
      }
    });
  }

  int _currentValue = 21;
  String customTextMapper(String value) {
    // Modify the input value to a custom format (e.g., add a suffix)
    return '$value years old';
  }

  @override
  Widget build(BuildContext context) {
    final stepsContent = [
      const Padding(
        padding: EdgeInsets.all(25.0),
        child: Text(
          'Step 1 Illustration',
          style: TextStyle(
            color: AppColors.white,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(25.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  gender = "MALE";
                });
              },
              child: const Text(
                "Male",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  gender = "FEMALE";
                });
              },
              child: const Text(
                "Female",
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(25.0),
        child: Center(
          child: TextField(
            controller: nameController,
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              label: const Center(
                child: Text(
                  "Username",
                  style: TextStyle(color: AppColors.grey),
                  textAlign: TextAlign.center,
                ),
              ),
              // labelText: 'Username', // Label text for the TextField
              // labelStyle: const TextStyle(color: AppColors.grey),
              alignLabelWithHint: true,
              hintText:
                  'Enter your username', // Hint text to provide a hint to the user
              hintStyle: TextStyle(color: AppColors.grey.withOpacity(0.7)),
              filled: true,
              fillColor:
                  AppColors.lightBlack, // Background color for the TextField
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.yellow),
                borderRadius: BorderRadius.circular(10.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.darkGrey),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: AppColors.grey), // Text color for the input text
            cursorColor: AppColors.white, // Color of the text cursor
            keyboardType: TextInputType.text, // Keyboard type for the input
            textInputAction: TextInputAction
                .done, // Action button on the keyboard (in this case, the "Done" button)
            onChanged: (value) {
              // Callback when the user types in the TextField
              // You can do something with the value, like updating the state
              // e.g., setState(() { username = value });
            },
            onSubmitted: (value) {
              // Callback when the user submits the TextField (e.g., presses the "Done" button)
              // You can handle form submission or other actions here
            },
          ),
        ),
      ),
      Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SvgPicture.asset(
                "assets/pointer.svg",
              ),
              NumberPicker(
                value: _currentValue,
                minValue: 18,
                maxValue: 90,
                step: 1,
                haptics: true,
                itemCount: 5,
                itemHeight: 80,
                itemWidth: SizeConfig.screenWidth - 120,
                onChanged: (value) => setState(() => _currentValue = value),
              ),
              SvgPicture.asset("assets/pointer.svg",
                  colorFilter: const ColorFilter.mode(
                      AppColors.lightBlack, BlendMode.srcIn),
                  semanticsLabel: 'A red up arrow'),
            ],
          ),
          Text('Current value: $_currentValue'),
        ],
      ),
      const AlarmCard(
        alarmSettings: null,
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.lightBlack,
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: SafeArea(
              child: SizeConfig.isLandscape
                  ? Container(
                      padding: const EdgeInsets.all(25),
                      // height: SizeConfig.screenHeight,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 125,
                            alignment: Alignment.centerLeft,
                            child: (currentStep > 0)
                                ? TertiaryButton(
                                    text: 'Back',
                                    icon: Icons.chevron_left,
                                    isSkip: false,
                                    onPressed: _previousStep)
                                : null,
                          ),
                          SizedBox(
                            width: SizeConfig.screenWidth - 350,
                            child: Column(
                              children: [
                                const SizedBox(height: 10),
                                CustomStepper(step: currentStep),
                                const SizedBox(height: 25),
                                Text(
                                  Constants.steps[currentStep]["heading"]!,
                                  style: AppStyles.heading,
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  Constants.steps[currentStep]["description"]!,
                                  style: AppStyles.description,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 15),
                                const Spacer(),
                                stepsContent[currentStep],
                                const Spacer(),
                                const SizedBox(height: 15),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 125,
                            child: PrimaryButton(
                              onPressed: _nextStep,
                              fullWidth: false,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      padding: const EdgeInsets.all(25),
                      // height: SizeConfig.screenHeight,
                      child: Column(
                        children: [
                          const SizedBox(height: 25),
                          CustomStepper(step: currentStep),
                          const SizedBox(height: 50),
                          Text(
                            Constants.steps[currentStep]["heading"]!,
                            style: AppStyles.heading,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            Constants.steps[currentStep]["description"]!,
                            style: AppStyles.description,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 25),
                          const Spacer(),
                          stepsContent[currentStep],
                          const Spacer(),
                          const SizedBox(height: 25),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              PrimaryButton(
                                onPressed: _nextStep,
                              ),
                              const SizedBox(height: 5),
                              if (currentStep > 0)
                                TertiaryButton(
                                    text: 'Back',
                                    icon: Icons.chevron_left,
                                    isSkip: false,
                                    onPressed: _previousStep),
                            ],
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
