import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:jawline_fitness/utils/colors.dart';
import 'package:permission_handler/permission_handler.dart';

class AlarmCard extends StatefulWidget {
  final AlarmSettings? alarmSettings;

  const AlarmCard({super.key, this.alarmSettings});

  @override
  State<AlarmCard> createState() => _AlarmCardState();
}

class _AlarmCardState extends State<AlarmCard> {
  late bool creating;

  late TimeOfDay selectedTime;
  late bool loopAudio;
  late bool vibrate;
  late bool showNotification;
  late String assetAudio;
  late AlarmSettings currentAlarm;
  bool reminder = false;
  @override
  void initState() {
    super.initState();
    creating = widget.alarmSettings == null;
    if (creating) {
      final dt = DateTime.now().add(const Duration(minutes: 1));
      selectedTime = TimeOfDay(hour: dt.hour, minute: dt.minute);
      loopAudio = true;
      vibrate = true;
      showNotification = true;
      assetAudio = 'assets/marimba.mp3';
    } else {
      selectedTime = TimeOfDay(
        hour: widget.alarmSettings!.dateTime.hour,
        minute: widget.alarmSettings!.dateTime.minute,
      );
      loopAudio = widget.alarmSettings!.loopAudio;
      vibrate = widget.alarmSettings!.vibrate;
      showNotification = widget.alarmSettings!.notificationTitle != null &&
          widget.alarmSettings!.notificationTitle!.isNotEmpty &&
          widget.alarmSettings!.notificationBody != null &&
          widget.alarmSettings!.notificationBody!.isNotEmpty;
      assetAudio = widget.alarmSettings!.assetAudioPath;
    }
  }

  Future<void> pickTime() async {
    var status = await Permission.scheduleExactAlarm.status;
    print(status);
    print(status.isDenied);
    if (status.isDenied) {
      var isPermanentlyDenied =
          await Permission.scheduleExactAlarm.request().isPermanentlyDenied;
      print(isPermanentlyDenied);
      if (isPermanentlyDenied)
        openAppSettings();
      else {
        final res = await showTimePicker(
          initialTime: selectedTime,
          context: context,
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.dark(
                  primary: AppColors.yellow, // header background color
                  onPrimary: AppColors.darkGrey, // header text color
                  onSurface: AppColors.grey, // body text color
                  onTertiaryContainer: AppColors.grey,
                  tertiaryContainer: AppColors.lightBlack,
                  surface: AppColors.darkGrey,
                  surfaceTint: AppColors.darkGrey,
                  outline: AppColors.lightBlack,
                ),
                useMaterial3: true,
                textTheme: const TextTheme(
                  headlineSmall: TextStyle(
                    color: AppColors.grey,
                  ),
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.yellow, // button text color
                  ),
                ),
              ),
              child: child!,
            );
          },
        );
        if (res != null) {
          setState(() => selectedTime = res);
          saveAlarm();
        }
        ;
      }
    }
  }

  AlarmSettings buildAlarmSettings() {
    final now = DateTime.now();
    final id = creating
        ? DateTime.now().millisecondsSinceEpoch % 100000
        : widget.alarmSettings!.id;

    DateTime dateTime = DateTime(
      now.year,
      now.month,
      now.day,
      selectedTime.hour,
      selectedTime.minute,
      0,
      0,
    );
    if (dateTime.isBefore(DateTime.now())) {
      dateTime = dateTime.add(const Duration(days: 1));
    }

    final alarmSettings = AlarmSettings(
      id: id,
      dateTime: dateTime,
      loopAudio: loopAudio,
      vibrate: vibrate,
      notificationTitle: showNotification ? 'Alarm example' : null,
      notificationBody: showNotification ? 'Your alarm ($id) is ringing' : null,
      assetAudioPath: assetAudio,
      stopOnNotificationOpen: false,
    );
    currentAlarm = alarmSettings;
    return alarmSettings;
  }

  void saveAlarm() {
    Alarm.set(alarmSettings: buildAlarmSettings()).then(
      (res) {
        if (res) {
          setState(() => reminder = true);
        }
      },
    );
  }

  void deleteAlarm() {
    Alarm.stop(currentAlarm.id).then(
      (res) {
        if (res) {
          setState(() => reminder = false);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: RawMaterialButton(
        splashColor: AppColors.lightBlack,
        onPressed: () {
          pickTime();
        },
        child: Container(
          padding: const EdgeInsets.all(20),
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
                    selectedTime.format(context),
                    style: TextStyle(
                      color: AppColors.grey,
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    "Everyday",
                    style: TextStyle(
                      color: AppColors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Switch(
                value: reminder,
                // thumbColor: MaterialStateProperty.all(
                //   AppColors.yellow,
                // ),
                // trackColor: MaterialStateProperty.all(
                //   AppColors.darkGrey,
                // ),
                trackOutlineColor: MaterialStateProperty.all(
                  reminder ? AppColors.yellow : AppColors.grey,
                ),
                thumbIcon: MaterialStateProperty.all(
                  Icon(
                    Icons.circle,
                    color: AppColors.darkGrey,
                  ),
                ),
                inactiveThumbColor: AppColors.grey,
                inactiveTrackColor: AppColors.darkGrey,
                activeTrackColor: AppColors.darkGrey,
                focusColor: AppColors.yellow,
                hoverColor: AppColors.yellow,
                activeColor: AppColors.yellow,
                overlayColor: MaterialStateProperty.all(
                  AppColors.yellow,
                ),
                onChanged: (bool value) {
                  if (value) {
                    pickTime();
                  } else {
                    deleteAlarm();
                  }
                  ;
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
