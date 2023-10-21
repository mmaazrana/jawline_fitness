import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jawline_fitness/utils/size_config.dart';
import 'package:jawline_fitness/utils/styles.dart';
import 'package:jawline_fitness/utils/theme.dart';
import 'package:jawline_fitness/widgets/lists/days_list.dart';

import '../../models/day.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  DateTime selectedDate = DateTime.now();
  late List<Day> days = [];
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    AppThemes().init(context);
    SizeConfig().init(context);
  }

  void selectDate(DateTime value) {
    setState(() {
      selectedDate = value;
    });
    getDaysByDate(selectedDate);
  }

  void getDaysByDate(DateTime targetDate) async {
    final daysBox = await Hive.openBox<Day>('days_box');

    // Use the `values` property to get all Day objects from the box
    final List<Day> allDays = daysBox.values.toList();

    // Filter the list based on the targetDate, ignoring the time component
    final List<Day> filteredDays = allDays.where((day) {
      final dayDate = day.completedOn;

      // Compare year, month, and day components only
      return dayDate.year == targetDate.year &&
          dayDate.month == targetDate.month &&
          dayDate.day == targetDate.day;
    }).toList();
    setState(() {
      days = filteredDays;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDaysByDate(selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      padding: const EdgeInsets.fromLTRB(34, 0, 34, 0),
      child: SizeConfig.isLandscape
          ? _buildLandscapeLayout()
          : _buildPortraitLayout(),
    );
  }

  Column _buildPortraitLayout() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "History",
          style: AppStyles.secondaryHeading,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.only(bottom: 10),
          decoration: AppStyles.darkGreyOutlineAlternate,
          child: Theme(
            data: AppThemes.calendarTheme,
            child: CalendarDatePicker(
              initialDate: DateTime.now(),
              firstDate: DateTime(2000, 0, 0, 0),
              lastDate: DateTime(3000, 0, 0, 0),
              onDateChanged: (value) => selectDate(value),
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          "Excercises Performed",
          style: AppStyles.tertiaryHeading,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: SizeConfig.screenHeight - 700,
          child: DaysList(
            level: days,
          ),
        ),
      ],
    );
  }

  Row _buildLandscapeLayout() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 20),
          width: SizeConfig.screenWidth * 0.325,
          height: SizeConfig.screenHeight - 105,
          child: Container(
            padding: const EdgeInsets.only(bottom: 10),
            decoration: AppStyles.darkGreyOutlineAlternate,
            height: SizeConfig.screenHeight - 105,
            width: SizeConfig.screenWidth,
            child: Theme(
              data: AppThemes.calendarTheme,
              child: CalendarDatePicker(
                initialDate: DateTime.now(),
                firstDate: DateTime(2000, 0, 0, 0),
                lastDate: DateTime(3000, 0, 0, 0),
                onDateChanged: (value) => selectDate(value),
              ),
            ),
          ),
        ),
        const SizedBox(width: 35),
        SizedBox(
          width: SizeConfig.screenWidth * 0.5 - 88,
          height: SizeConfig.screenHeight - 95,
          child: Column(
            children: [
              const Text(
                "Excercises Performed",
                style: AppStyles.secondaryHeading,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: SizeConfig.screenHeight - 200,
                child: DaysList(
                  level: days,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
