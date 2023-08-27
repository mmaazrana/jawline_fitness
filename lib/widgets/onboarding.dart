import 'package:flutter/material.dart';
import 'package:jawline_fitness/utils/colors.dart';
import 'package:jawline_fitness/utils/size_config.dart';
import 'package:jawline_fitness/utils/styles.dart';
import 'package:jawline_fitness/widgets/buttons/tertiary_button.dart';
import 'package:jawline_fitness/widgets/stepper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../utils/constants.dart';
import '../utils/data_provider.dart';
import '../utils/routes.dart';
import 'buttons/primary_button.dart';
import 'onboarding_steps/step_five.dart';
import 'onboarding_steps/step_four.dart';
import 'onboarding_steps/step_one.dart';
import 'onboarding_steps/step_three.dart';
import 'onboarding_steps/step_two.dart';

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
  int _currentValue = 21;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SizeConfig().init(context);
  }

  Future<void> _nextStep() async {
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

      _redirectToHome();
    }
  }

  // String customTextMapper(String value) {
  //   // Modify the input value to a custom format (e.g., add a suffix)
  //   return '$value years old';
  // }

  void _redirectToHome() =>
      Navigator.pushReplacementNamed(context, Routes.home);
  void _previousStep() => setState(() => {if (currentStep > 0) currentStep--});
  void setGender(gender) => setState(() => this.gender = gender);
  void setAge(value) => setState(() => _currentValue = value);

  @override
  Widget build(BuildContext context) {
    final stepsContent = [
      const StepOne(),
      StepTwo(
        setGender: setGender,
      ),
      StepThree(nameController: nameController),
      StepFour(
        currentValue: _currentValue,
        setAge: setAge,
      ),
      const StepFive(),
    ];

    return Scaffold(
      backgroundColor: AppColors.lightBlack,
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: SafeArea(
              child: SizeConfig.isLandscape
                  ? _buildLandscapeLayout(stepsContent)
                  : _buildPortraitLayout(stepsContent),
            ),
          ),
        ],
      ),
    );
  }

  Container _buildPortraitLayout(List<Widget> stepsContent) {
    return Container(
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
                  onPressed: _previousStep,
                ),
            ],
          ),
        ],
      ),
    );
  }

  Container _buildLandscapeLayout(List<Widget> stepsContent) {
    return Container(
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
                    onPressed: _previousStep,
                  )
                : null,
          ),
          SizedBox(
            width: SizeConfig.screenWidth - 350,
            child: Column(
              children: [
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
                CustomStepper(step: currentStep),
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
    );
  }
}
