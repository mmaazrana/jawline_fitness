import 'package:flutter/material.dart';
import 'package:jawline_fitness/utils/size_config.dart';
import 'package:jawline_fitness/utils/styles.dart';
import 'package:jawline_fitness/utils/theme.dart';
import 'package:jawline_fitness/widgets/days_list.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    AppThemes().init(context);
    SizeConfig().init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      padding: const EdgeInsets.fromLTRB(34, 0, 34, 0),
      child: SizeConfig.isLandscape
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 20),
                  width: SizeConfig.screenWidth * 0.325,
                  height: SizeConfig.screenHeight - 105,
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 10),
                    decoration: AppStyles.calendarBorder,
                    height: SizeConfig.screenHeight - 105,
                    width: SizeConfig.screenWidth,
                    child: Theme(
                      data: AppThemes.calendarTheme,
                      child: CalendarDatePicker(
                        initialDate: DateTime(2018, 12, 12, 12),
                        firstDate: DateTime(2018, 12, 12, 12),
                        lastDate: DateTime(2020, 12, 12, 12),
                        onDateChanged: (value) {},
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 35),
                SizedBox(
                  width: SizeConfig.screenWidth * 0.5 - 80,
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
                        height: SizeConfig.screenHeight - 151,
                        child: const DaysList(),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : Column(
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
                  decoration: AppStyles.calendarBorder,
                  child: Theme(
                    data: AppThemes.calendarTheme,
                    child: CalendarDatePicker(
                      initialDate: DateTime(2018, 12, 12, 12),
                      firstDate: DateTime(2018, 12, 12, 12),
                      lastDate: DateTime(2020, 12, 12, 12),
                      onDateChanged: (value) {},
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Excercises Performed",
                  style: AppStyles.secondaryHeading,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: SizeConfig.screenHeight - 700,
                  child: const DaysList(),
                ),
              ],
            ),
    );
  }
}
