import 'package:flutter/material.dart';

class StepTwo extends StatelessWidget {
  final void Function(String gender) setGender;
  const StepTwo({
    super.key,
    required this.setGender,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              setGender("MALE");
            },
            child: const Text(
              "Male",
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setGender("FEMALE");
            },
            child: const Text(
              "Female",
            ),
          ),
        ],
      ),
    );
  }
}
