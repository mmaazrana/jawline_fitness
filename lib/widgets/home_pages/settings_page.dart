import 'package:flutter/material.dart';
import 'package:jawline_fitness/utils/routes.dart';
import 'package:jawline_fitness/utils/size_config.dart';
import 'package:jawline_fitness/utils/styles.dart';
import 'package:jawline_fitness/widgets/bottom_sheets/rest_duration_bottom_sheet.dart';
import 'package:jawline_fitness/widgets/cards/settings_card.dart';

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
              style: AppStyles.secondaryHeading,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: SizeConfig.screenWidth - (34 * 2),
              padding: const EdgeInsets.all(20),
              decoration: AppStyles.darkGreyOutlineAlternate,
              child: Column(
                children: [
                  const Text(
                    "General Settings",
                    style: AppStyles.secondaryAlternateHeading,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 15),
                  SettingCard(
                    text: "Custom Reminders",
                    onPressed: () =>
                        Navigator.pushNamed(context, AppRoutes.reminders),
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
              decoration: AppStyles.darkGreyOutlineAlternate,
              child: Column(children: [
                const Text(
                  "Excercise Settings",
                  style: AppStyles.secondaryAlternateHeading,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
                SettingCard(
                  text: "Rest Duration",
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return const RestDurationBottomSheet();
                      },
                    );
                  },
                ),
                const SizedBox(height: 15),
                SettingCard(
                  text: "Voice Guide",
                  onPressed: () {},
                ),
                const SizedBox(height: 15),
                SettingCard(
                  text: "Duration",
                  onPressed: () {},
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
