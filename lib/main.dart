import 'package:alarm/alarm.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:jawline_fitness/screens/home.dart';
import 'package:jawline_fitness/screens/vibration_control.dart';
import 'package:jawline_fitness/screens/reminders.dart';
import 'package:jawline_fitness/screens/rest.dart';
import 'package:jawline_fitness/screens/reminder_settings.dart';
import 'package:jawline_fitness/screens/voice_control.dart';
import 'package:jawline_fitness/utils/colors.dart';
import 'package:jawline_fitness/utils/constants.dart';
import 'package:jawline_fitness/utils/data_provider.dart';
import 'package:jawline_fitness/utils/routes.dart';
import 'package:jawline_fitness/widgets/onboarding.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/day.dart';
import 'models/exercise.dart';
import 'screens/exercise_complete.dart';
import 'screens/exercise.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Alarm.init(showDebugLogs: true);
  await Hive.initFlutter();
  Hive.registerAdapter(DayAdapter());
  Hive.registerAdapter(ExerciseAdapter());
  MobileAds.instance.initialize();
  RequestConfiguration configuration =
      RequestConfiguration(testDeviceIds: ["953A2723522E21AC2CAF8306CC03323E"]);
  MobileAds.instance.updateRequestConfiguration(configuration);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return DataProvider();
      },
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'Raleway',
          useMaterial3: true,
          colorSchemeSeed: Colors.yellow,
          // Use Raleway font as the default font for the entire app.
        ),
        debugShowCheckedModeBanner: false,
        title: 'Jawline Fitness',
        initialRoute: AppRoutes.splashScreen,
        routes: {
          AppRoutes.home: (context) => const Home(),
          AppRoutes.onBoarding: (context) => const OnBoarding(),
          AppRoutes.splashScreen: (context) => const SplashScreen(),
          AppRoutes.exerciseScreen: (context) => const ExerciseScreen(),
          AppRoutes.restScreen: (context) => const RestScreen(),
          AppRoutes.completeScreen: (context) =>
              const ExcerciseCompleteScreen(),
          AppRoutes.reminders: (context) => const CustomReminders(),
          AppRoutes.vibrationControl: (context) => const VibrationControl(),
          AppRoutes.reminderSettings: (context) => const ReminderSettings(),
          AppRoutes.voiceControl: (context) => const VoiceControl(),
          // AppRoutes.dayPreview: (context, {int? index}) =>
          //     DayPreview(day: index! + 1),
        },
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late bool isOnboarded = false;
  late bool isVibrationEnabled = true;
  late int restDuration = 20;

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isOnBoardedData = prefs.getBool('isOnboarded') ?? false;
    bool isVibrationEnabledData = prefs.getBool('isVibrationEnabled') ?? true;
    int restDurationData = prefs.getInt('restDuration') ?? 20;

    setState(() {
      isOnboarded = isOnBoardedData;
      restDuration = restDurationData;
      isVibrationEnabled = isVibrationEnabledData;
      // isOnboarded = false; //hard coded for testing
    });
    if (!isOnboarded) {
      final daysBox = await Hive.openBox<Day>('days_box');
      for (final day in Constants.days) {
        await daysBox.add(day);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: 'assets/logo.png',
      backgroundColor: AppColors.yellow,
      splashIconSize: 240,
      nextScreen: isOnboarded ? const Home() : const OnBoarding(),
    );
  }
}
