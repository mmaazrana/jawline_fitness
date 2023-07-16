import 'package:alarm/alarm.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:jawline_fitness/screens/alarms.dart';
import 'package:jawline_fitness/utils/colors.dart';
import 'package:jawline_fitness/utils/data_provider.dart';
import 'package:jawline_fitness/widgets/onboarding.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Alarm.init(showDebugLogs: true);
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
          useMaterial3: true,
          colorSchemeSeed: Colors.yellow,
        ),
        debugShowCheckedModeBanner: false,
        title: 'Jawline Fitness',
        home: const MyHomePage(title: 'Jawline Fitness Home Page'),
      ),
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
  bool isOnboarded = false;

  @override
  void initState() {
    // TODO: implement initState
    _loadData();
    super.initState();
  }

  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isOnBoardedData = prefs.getBool('isOnboarded') ?? false;
    setState(() {
      isOnboarded = isOnBoardedData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: 'assets/logo.png',
      backgroundColor: AppColors.yellow,
      splashIconSize: 240,
      nextScreen:
          isOnboarded ? const ExampleAlarmHomeScreen() : const OnBoarding(),
    );
  }
}
