import 'package:flutter/material.dart';
import 'package:jawline_fitness/utils/size_config.dart';

import '../../utils/colors.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: SizeConfig.screenWidth,
        padding: const EdgeInsets.fromLTRB(34, 0, 34, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Settings",
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
              width: SizeConfig.screenWidth - (34 * 2),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: AppColors.darkGrey,
                    width: 3,
                  )),
              child: const Column(
                children: [
                  Text(
                    "General Settings",
                    style: TextStyle(
                      fontSize: 24,
                      color: AppColors.grey,
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SettingButton(
                    text: "Custom Reminders",
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: SizeConfig.screenWidth - (34 * 2),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: AppColors.darkGrey,
                    width: 3,
                  )),
              child: const Column(children: [
                Text(
                  "Excercise Settings",
                  style: TextStyle(
                    fontSize: 24,
                    color: AppColors.grey,
                    fontWeight: FontWeight.w800,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 15,
                ),
                SettingButton(
                  text: "Rest Duration",
                ),
                SizedBox(
                  height: 15,
                ),
                SettingButton(
                  text: "Voice Guide",
                ),
                SizedBox(
                  height: 15,
                ),
                SettingButton(
                  text: "Duration",
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}

class SettingButton extends StatelessWidget {
  final String text;

  const SettingButton({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: null,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.darkGrey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: const TextStyle(
                color: AppColors.grey,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(0),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: AppColors.yellow,
                borderRadius: BorderRadius.circular(100),
              ),
              child: const Icon(
                Icons.chevron_right,
                size: 16,
                color: AppColors.lightBlack,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
