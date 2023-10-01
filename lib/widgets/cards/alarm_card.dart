import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:jawline_fitness/utils/colors.dart';
import 'package:jawline_fitness/utils/theme.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../switches/custom_switch.dart';

class AlarmCard extends StatefulWidget {
  // final AlarmSettings? alarmSettings;

  const AlarmCard({super.key});

  @override
  State<AlarmCard> createState() => _AlarmCardState();
}

class _AlarmCardState extends State<AlarmCard> {
  // late bool creating;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  late SharedPreferences prefs;

  late TimeOfDay selectedTime;
  late bool loopAudio;
  late bool vibrate;
  late bool showNotification;
  late String assetAudio;
  late AlarmSettings currentAlarm;
  late bool reminder;
  late int year;
  late int month;
  late int day;
  late int hour;
  late int minute;
  late int alarmId;

  bool isLoading = true;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    AppThemes().init(context);
  }

  void loadData() async {
    final now = DateTime.now();
    final dt = DateTime.now().add(const Duration(minutes: 1));
    selectedTime = TimeOfDay(hour: dt.hour, minute: dt.minute);
    prefs = await SharedPreferences.getInstance();
    reminder = prefs.getBool("reminder") ?? false;
    year = prefs.getInt("year") ?? now.year;
    month = prefs.getInt("month") ?? now.month;
    day = prefs.getInt("day") ?? now.day;
    hour = prefs.getInt("hour") ?? now.hour;
    minute = prefs.getInt("minute") ?? now.minute;
    assetAudio = prefs.getString("ringTone") ?? "assets/ring1.mp3";
    vibrate = prefs.getBool("isVibrationEnabled") ?? true;
    showNotification = prefs.getBool("showNotification") ?? true;
    loopAudio = prefs.getBool("loopAudio") ?? true;
    alarmId = prefs.getInt("alarmId") ?? 0;

    currentAlarm = AlarmSettings(
      id: alarmId,
      dateTime: DateTime(year, month, day, hour, minute, 0, 0),
      assetAudioPath: assetAudio,
    );

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
    // creating = widget.alarmSettings == null;
    // if (creating) {
    //   final dt = DateTime.now().add(const Duration(minutes: 1));
    //   selectedTime = TimeOfDay(hour: dt.hour, minute: dt.minute);
    //   loopAudio = true;
    //   vibrate = true;
    //   showNotification = true;
    //   assetAudio = 'assets/ring1.mp3';
    // } else {
    //   selectedTime = TimeOfDay(
    //     hour: widget.alarmSettings!.dateTime.hour,
    //     minute: widget.alarmSettings!.dateTime.minute,
    //   );
    //   loopAudio = widget.alarmSettings!.loopAudio;
    //   vibrate = widget.alarmSettings!.vibrate;
    //   showNotification = widget.alarmSettings!.notificationTitle != null &&
    //       widget.alarmSettings!.notificationTitle!.isNotEmpty &&
    //       widget.alarmSettings!.notificationBody != null &&
    //       widget.alarmSettings!.notificationBody!.isNotEmpty;
    //   assetAudio = widget.alarmSettings!.assetAudioPath;
    // }
  }

  Future<void> pickTime() async {
    var status = await Permission.scheduleExactAlarm.status;
    if (!status.isDenied) {
      var isPermanentlyDenied =
          await Permission.scheduleExactAlarm.request().isPermanentlyDenied;
      if (isPermanentlyDenied) {
        openAppSettings();
      } else {
        final res = await showTimePicker(
          initialTime: selectedTime,
          context: context,
          builder: (context, child) {
            return Theme(
              data: AppThemes.timePickerTheme,
              child: child!,
            );
          },
        );
        if (res != null) {
          setState(() => selectedTime = res);
          saveAlarm();
        }
      }
    }
  }

  AlarmSettings buildAlarmSettings() {
    final now = DateTime.now();
    // final id = creating
    //     ? DateTime.now().millisecondsSinceEpoch % 100000
    //     : widget.alarmSettings!.id;
    DateTime dateTime;
    if (selectedTime.hour <= now.hour && selectedTime.minute <= now.minute) {
      dateTime = DateTime(
        now.year,
        now.month,
        now.day,
        selectedTime.hour,
        selectedTime.minute,
        0,
        0,
      ).add(
        const Duration(days: 1),
      );
    } else {
      dateTime = DateTime(
        now.year,
        now.month,
        now.day,
        selectedTime.hour,
        selectedTime.minute,
        0,
        0,
      );
    }
    ;

    prefs.setInt("year", dateTime.year);
    prefs.setInt("month", dateTime.month);
    prefs.setInt("day", dateTime.day);
    prefs.setInt("hour", dateTime.hour);
    prefs.setInt("minute", dateTime.minute);

    setState(() {
      hour = selectedTime.hour;
      minute = selectedTime.minute;
    });

    if (dateTime.isBefore(DateTime.now())) {
      dateTime = dateTime.add(const Duration(days: 1));
    }

    final alarmSettings = AlarmSettings(
      id: alarmId,
      dateTime: dateTime,
      loopAudio: loopAudio,
      vibrate: vibrate,
      notificationTitle: showNotification ? 'Jawline Fitness Reminder' : null,
      notificationBody: showNotification ? 'Time to Train your Jaw' : null,
      assetAudioPath: assetAudio,
      stopOnNotificationOpen: false,
    );
    // currentAlarm = alarmSettings;
    return alarmSettings;
  }

  void saveAlarm() {
    Alarm.set(alarmSettings: buildAlarmSettings()).then(
      (res) {
        if (res) {
          prefs.setBool("reminder", true);
          setState(() => reminder = true);
        }
      },
    );
  }

  void deleteAlarm() {
    Alarm.stop(
      alarmId,
    ).then(
      (res) {
        if (res) {
          prefs.setBool("reminder", false);
          setState(() => reminder = false);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container()
        : Padding(
            padding: const EdgeInsets.all(20.0),
            child: RawMaterialButton(
              splashColor: AppColors.lightBlack,
              onPressed: () {
                pickTime();
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                height: 105,
                decoration: BoxDecoration(
                  color: AppColors.darkGrey,
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "$hour : $minute",
                          style: const TextStyle(
                            color: AppColors.grey,
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const Text(
                          "Everyday",
                          style: TextStyle(
                            color: AppColors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    CustomSwitch(
                      reminder: reminder,
                      onEnable: pickTime,
                      onDisable: deleteAlarm,
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
