import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/colors.dart';

class StepOne extends StatelessWidget {
  const StepOne({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: SvgPicture.asset(
        "assets/welcome.svg",
      ),
    );
  }
}
