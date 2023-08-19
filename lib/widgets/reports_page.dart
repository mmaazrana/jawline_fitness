import 'package:flutter/material.dart';
import 'package:jawline_fitness/utils/colors.dart';
import 'package:jawline_fitness/utils/size_config.dart';
import 'package:jawline_fitness/widgets/days_list.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      padding: const EdgeInsets.fromLTRB(34, 0, 34, 0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "History",
              style: TextStyle(
                fontSize: 30,
                color: AppColors.grey,
                fontWeight: FontWeight.w800,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: AppColors.darkGrey,
                    width: 3,
                  )),
              child: Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: const ColorScheme.dark(
                    primary: AppColors.yellow, // header background color
                    onSurface: AppColors.grey, // body text color
                    onPrimary: AppColors.lightBlack, // header text color
                    onSurfaceVariant: AppColors.grey,
                    outlineVariant: AppColors.darkGrey,
                  ),
                  useMaterial3: true,
                ),
                child: CalendarDatePicker(
                  initialDate: DateTime(2018, 12, 12, 12),
                  firstDate: DateTime(2018, 12, 12, 12),
                  lastDate: DateTime(2020, 12, 12, 12),
                  onDateChanged: (value) {},
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Excercises Performed",
              style: TextStyle(
                fontSize: 30,
                color: AppColors.grey,
                fontWeight: FontWeight.w800,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: SizeConfig.screenHeight - 690,
              child: const DaysList(),
            ),
          ]),
    );
  }
}
