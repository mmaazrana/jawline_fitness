import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jawline_fitness/utils/colors.dart';

import '../../models/day.dart';

class DayCard extends StatefulWidget {
  final String text;
  final int currentDay;
  final bool isSelected;
  final Function() onPressed;
  final Function() onStart;

  const DayCard({
    super.key,
    required this.text,
    required this.currentDay,
    required this.isSelected,
    required this.onPressed,
    required this.onStart,
  });

  @override
  State<DayCard> createState() => _DayCardState();
}

class _DayCardState extends State<DayCard> {
  late final Box<Day> daysBox;
  bool isLoading = true;
  void loadData() async {
    daysBox = await Hive.openBox<Day>('days_box');

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container(
            height: 68,
            margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color:
                  widget.isSelected ? AppColors.lightBlack : AppColors.darkGrey,
              border: Border.all(
                color:
                    widget.isSelected ? AppColors.yellow : AppColors.darkGrey,
                width: 2.0,
                strokeAlign: BorderSide.strokeAlignInside,
              ),
            ),
            child: const Center(
              child: CircularProgressIndicator(color: AppColors.lightBlack),
            ),
          )
        : GestureDetector(
            onTap: widget.onPressed,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              padding: const EdgeInsets.all(16.0),
              height: 68,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: widget.isSelected
                    ? AppColors.lightBlack
                    : AppColors.darkGrey,
                border: Border.all(
                  color:
                      widget.isSelected ? AppColors.yellow : AppColors.darkGrey,
                  width: 2.0,
                  strokeAlign: BorderSide.strokeAlignInside,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      widget.text,
                      style: const TextStyle(
                        color: AppColors.grey,
                        fontSize: 24.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  daysBox.get(widget.currentDay)!.isComplete
                      ? Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.lightBlack,
                          ),
                          padding: const EdgeInsets.all(4),
                          child: const Icon(
                            Icons.check_rounded,
                            color: AppColors.yellow,
                            size: 24,
                          ),
                        )
                      : Row(
                          children: [
                            if (widget.isSelected) const SizedBox(width: 16.0),
                            if (widget.isSelected)
                              ElevatedButton(
                                onPressed: widget.onStart,
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(5),
                                  backgroundColor: AppColors.yellow,
                                  minimumSize: const Size(64, 28),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100.0),
                                  ),
                                ),
                                child: const Text(
                                  'Start',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                          ],
                        ),
                ],
              ),
            ),
          );
  }
}
