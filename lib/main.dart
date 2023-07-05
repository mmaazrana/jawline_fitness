import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:jawline_fitness/utils/colors.dart';
import 'package:jawline_fitness/widgets/onboarding.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jawline Fitness',
      home: MyHomePage(title: 'Crypto Project Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: 'assets/logo.png',
      backgroundColor: AppColors.yellow,
      splashIconSize: 240,
      nextScreen: const Scaffold(
        backgroundColor: AppColors.lightBlack,
        body: OnBoarding(
            heading: "Welcome",
            description: "Description for the first step",
            step: 0),
      ),
    );
  }
}
