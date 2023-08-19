import 'package:flutter/material.dart';
import 'package:jawline_fitness/utils/colors.dart';
import 'package:jawline_fitness/utils/styles.dart';

class SmoothLinearProgressButton extends StatefulWidget {
  final bool isPaused;
  final Function() onPressed;

  const SmoothLinearProgressButton({
    super.key,
    required this.isPaused,
    required this.onPressed,
  });

  @override
  SmoothLinearProgressButtonState createState() =>
      SmoothLinearProgressButtonState();
}

class SmoothLinearProgressButtonState extends State<SmoothLinearProgressButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);

    if (!widget.isPaused) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(SmoothLinearProgressButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isPaused) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: AppStyles.zeroPadding,
        child: Stack(
          children: [
            LinearProgressIndicator(
              value: _animation.value,
              minHeight: 50,
              backgroundColor: AppColors.lightBlack,
              color: AppColors.darkGrey,
            ),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.isPaused ? 'Resume' : 'Pause',
                    style: AppStyles.secondaryButtonText,
                  ),
                  const SizedBox(width: 5),
                  Icon(
                    widget.isPaused ? Icons.play_arrow : Icons.pause,
                    color: AppColors.grey,
                    size: 28,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
