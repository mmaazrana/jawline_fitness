import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class AppTitleBar extends StatelessWidget implements PreferredSizeWidget {
  const AppTitleBar({
    super.key,
  });

  @override
  Size get preferredSize =>
      const Size.fromHeight(55); // Customize the height as needed

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.lightBlack,
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: RichText(
        text: const TextSpan(
            text: "BUILD A RAZOR SHARP ",
            style: TextStyle(
              color: AppColors.grey,
              fontWeight: FontWeight.w800,
              fontSize: 20,
            ),
            children: [
              TextSpan(
                text: "JAWLINE",
                style: TextStyle(
                  color: AppColors.yellow,
                  fontStyle: FontStyle.italic,
                ),
              )
            ]),
      ),
    );
  }
}
