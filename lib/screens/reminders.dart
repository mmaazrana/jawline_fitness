import 'package:flutter/material.dart';
import 'package:jawline_fitness/utils/colors.dart';
import 'package:jawline_fitness/utils/styles.dart';
import 'package:jawline_fitness/widgets/buttons/primary_button.dart';
import 'package:jawline_fitness/widgets/cards/alarm_card.dart';
import 'dart:async';

import 'package:alarm/alarm.dart';
import 'package:jawline_fitness/screens/edit_alarm.dart';
import 'package:jawline_fitness/screens/ring.dart';
import 'package:jawline_fitness/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/progress_indicator.dart';
import '../widgets/tile.dart';

class CustomReminders extends StatefulWidget {
  const CustomReminders({Key? key}) : super(key: key);

  @override
  State<CustomReminders> createState() => _CustomRemindersState();
}

class _CustomRemindersState extends State<CustomReminders> {
  late List<AlarmSettings> alarms;

  // static StreamSubscription? subscription;

  @override
  void initState() {
    super.initState();
    loadAlarms();
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

  // @override
  // void dispose() {
  //   subscription?.cancel();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlack,
      appBar: AppBar(
        title: const Text(
          "REMINDERS",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.lightBlack,
        foregroundColor: AppColors.grey,
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left_rounded,
            size: 32,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        titleSpacing: 0,
      ),
      body: const Padding(
        padding: EdgeInsets.fromLTRB(32, 24, 32, 0),
        child: SafeArea(
          child: AlarmCard(),
          // Column(
          // children: [
          // alarms.isNotEmpty

          // ? SizedBox(
          //     height: 500,
          //     child: ListView.builder(
          //       itemCount: alarms.length,
          //       itemBuilder: (context, index) {
          //         return AlarmCard();
          //         // return ExampleAlarmTile(
          //         //   key: Key(alarms[index].id.toString()),
          //         //   title: TimeOfDay(
          //         //     hour: alarms[index].dateTime.hour,
          //         //     minute: alarms[index].dateTime.minute,
          //         //   ).format(context),
          //         //   onPressed: () =>
          //         //       navigateToAlarmScreen(alarms[index]),
          //         //   onDismissed: () {
          //         //     Alarm.stop(alarms[index].id)
          //         //         .then((_) => loadAlarms());
          //         //   },
          //         // );
          //       },
          //     ),
          //   )
          // :
          // const Center(
          //     child: Column(
          //       children: [
          //         Text(
          //           "No Reminders set",
          //           style: AppStyles.description,
          //         ),
          //       ],
          //     ),
          //   ),
          // const SizedBox(height: 24),
          // PrimaryButton(
          //   onPressed: () {},
          //   text: "Add Alarm",
          // )
          // ],
          // ),
        ),
      ),
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.all(10),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       FloatingActionButton(
      //         onPressed: () {
      //           final alarmSettings = AlarmSettings(
      //             id: 42,
      //             dateTime: DateTime.now(),
      //             assetAudioPath: 'assets/ring1.mp3',
      //           );
      //           Alarm.set(alarmSettings: alarmSettings);
      //         },
      //         backgroundColor: Colors.red,
      //         heroTag: null,
      //         child: const Text("RING NOW", textAlign: TextAlign.center),
      //       ),
      //       FloatingActionButton(
      //         onPressed: () => navigateToAlarmScreen(null),
      //         child: const Icon(Icons.alarm_add_rounded, size: 33),
      //       ),
      //     ],
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.lightBlack,
//       appBar: AppBar(
//         title: const Text(
//           "REMINDERS",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         backgroundColor: AppColors.lightBlack,
//         foregroundColor: AppColors.grey,
//         leading: IconButton(
//           icon: const Icon(
//             Icons.chevron_left_rounded,
//             size: 32,
//           ),
//           onPressed: () => Navigator.pop(context),
//         ),
//         titleSpacing: 0,
//       ),
//       body: const Padding(
//         padding: EdgeInsets.fromLTRB(42, 0, 42, 0),
//         child: SingleChildScrollView(
//           child: Column(children: [
//             AlarmCard(),
//             AlarmCard(),
//             AlarmCard(),
//           ]),
//         ),
//       ),
//     );
//   }
}
