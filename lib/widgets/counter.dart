import 'package:flutter/material.dart';

import '../utils/colors.dart';

class Counter extends StatelessWidget {
  const Counter({
    super.key,
    required this.currentExerciseTime,
  });

  final int currentExerciseTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.98),
                    offset: Offset(0, 13),
                    blurRadius: 28,
                    spreadRadius: 0,
                  ),
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.85),
                    offset: Offset(0, 50),
                    blurRadius: 50,
                    spreadRadius: 0,
                  ),
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.50),
                    offset: Offset(0, 113),
                    blurRadius: 68,
                    spreadRadius: 0,
                  ),
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.15),
                    offset: Offset(0, 201),
                    blurRadius: 81,
                    spreadRadius: 0,
                  ),
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.02),
                    offset: Offset(0, 315),
                    blurRadius: 88,
                    spreadRadius: 0,
                  ),
                ],
                color: AppColors.darkGrey,
                borderRadius: BorderRadius.circular(10)),
            child: Text(
              (currentExerciseTime ~/ 60).toString().padLeft(2, '0'),
              style: TextStyle(
                fontSize: 28,
                height: 1,
                fontWeight: FontWeight.w900,
                color: AppColors.grey,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.98),
                  offset: Offset(0, 13),
                  blurRadius: 28,
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.85),
                  offset: Offset(0, 50),
                  blurRadius: 50,
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.50),
                  offset: Offset(0, 113),
                  blurRadius: 68,
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.15),
                  offset: Offset(0, 201),
                  blurRadius: 81,
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.02),
                  offset: Offset(0, 315),
                  blurRadius: 88,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Text(
              ":",
              style: TextStyle(
                fontSize: 28,
                height: 1,
                fontWeight: FontWeight.w900,
                color: AppColors.grey,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.98),
                    offset: Offset(0, 13),
                    blurRadius: 28,
                    spreadRadius: 0,
                  ),
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.85),
                    offset: Offset(0, 50),
                    blurRadius: 50,
                    spreadRadius: 0,
                  ),
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.50),
                    offset: Offset(0, 113),
                    blurRadius: 68,
                    spreadRadius: 0,
                  ),
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.15),
                    offset: Offset(0, 201),
                    blurRadius: 81,
                    spreadRadius: 0,
                  ),
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.02),
                    offset: Offset(0, 315),
                    blurRadius: 88,
                    spreadRadius: 0,
                  ),
                ],
                color: AppColors.darkGrey,
                borderRadius: BorderRadius.circular(10)),
            child: Text(
              (currentExerciseTime % 60).toString().padLeft(2, '0'),
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w900,
                height: 1,
                color: AppColors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
