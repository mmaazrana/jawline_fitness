import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/styles.dart';

class Loader extends StatelessWidget {
  final String text;
  const Loader({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlack,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppColors.yellow,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                text,
                style: AppStyles.description,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
