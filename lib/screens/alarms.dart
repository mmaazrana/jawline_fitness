import 'dart:async';

import 'package:alarm/alarm.dart';
import 'package:jawline_fitness/screens/edit_alarm.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/tile.dart';

class ExampleAlarmHomeScreen extends StatefulWidget {
  const ExampleAlarmHomeScreen({Key? key}) : super(key: key);

  @override
  State<ExampleAlarmHomeScreen> createState() => _ExampleAlarmHomeScreenState();
}

class _ExampleAlarmHomeScreenState extends State<ExampleAlarmHomeScreen> {
  late List<AlarmSettings> alarms;

  // static StreamSubscription? subscription;

  late String savedName;
  late int savedAge;
  late String savedGender;

  @override
  void initState() {
    super.initState();
    loadAlarms();
    _loadData();
    // subscription ??= Alarm.ringStream.stream.listen(
    //   (alarmSettings) => navigateToRingScreen(alarmSettings),
    // );
  }

  void loadAlarms() {
    setState(() {
      alarms = Alarm.getAlarms();
      alarms.sort((a, b) => a.dateTime.isBefore(b.dateTime) ? 0 : 1);
    });
  }

  // Future<void> navigateToRingScreen(AlarmSettings alarmSettings) async {
  //   await Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => AlarmRingScreen(alarmSettings: alarmSettings),
  //       ));
  //   loadAlarms();
  // }

  Future<void> navigateToAlarmScreen(AlarmSettings? settings) async {
    final res = await showModalBottomSheet<bool?>(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: 0.6,
            child: ExampleAlarmEditScreen(alarmSettings: settings),
          );
        });

    if (res != null && res == true) loadAlarms();
  }

  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = prefs.getString('name') ?? '';
    int age = prefs.getInt('age') ?? -1;
    String gender = prefs.getString('gender') ?? '';
    setState(() {
      savedName = name;
      savedAge = age;
      savedGender = gender;
    });
  }

  // @override
  // void dispose() {
  //   subscription?.cancel();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    // final userDataProvider = Provider.of<DataProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text('Package alarm example app')),
      body: SafeArea(
        child: alarms.isNotEmpty
            ? ListView.separated(
                itemCount: alarms.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  return ExampleAlarmTile(
                    key: Key(alarms[index].id.toString()),
                    title: TimeOfDay(
                      hour: alarms[index].dateTime.hour,
                      minute: alarms[index].dateTime.minute,
                    ).format(context),
                    onPressed: () => navigateToAlarmScreen(alarms[index]),
                    onDismissed: () {
                      Alarm.stop(alarms[index].id).then((_) => loadAlarms());
                    },
                  );
                },
              )
            : Center(
                child: Column(
                  children: [
                    Text(
                      "No alarms set",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        var status = await Permission.scheduleExactAlarm.status;
                        if (status.isDenied) {
                          var isPermanentlyDenied = await Permission
                              .scheduleExactAlarm
                              .request()
                              .isPermanentlyDenied;
                          if (isPermanentlyDenied) openAppSettings();
                        }
                      },
                      child: const Text("Check Permission"),
                    ),
                    // const Text("Provider Data"),
                    // const Text("Name"),
                    // Text(userDataProvider.user!.name.toString()),
                    // const Text("Age"),
                    // Text(userDataProvider.user!.age.toString()),
                    // const Text("Gender"),
                    // Text(userDataProvider.user!.gender.toString()),
                    const Text("Shared Preferences Data"),
                    const Text("Name"),
                    Text(savedName.toString()),
                    const Text("Age"),
                    Text(savedAge.toString()),
                    const Text("Gender"),
                    Text(savedGender.toString()),
                  ],
                ),
              ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              onPressed: () {
                final alarmSettings = AlarmSettings(
                  id: 42,
                  dateTime: DateTime.now(),
                  assetAudioPath: 'assets/marimba.mp3',
                );
                Alarm.set(alarmSettings: alarmSettings);
              },
              backgroundColor: Colors.red,
              heroTag: null,
              child: const Text("RING NOW", textAlign: TextAlign.center),
            ),
            FloatingActionButton(
              onPressed: () => navigateToAlarmScreen(null),
              child: const Icon(Icons.alarm_add_rounded, size: 33),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
