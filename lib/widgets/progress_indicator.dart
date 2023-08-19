import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:jawline_fitness/utils/colors.dart';

class CustomCircularProgressIndicator extends StatefulWidget {
  const CustomCircularProgressIndicator({super.key});

  @override
  _CustomCircularProgressIndicatorState createState() =>
      _CustomCircularProgressIndicatorState();
}

class _CustomCircularProgressIndicatorState
    extends State<CustomCircularProgressIndicator> {
  double _progress = 0.0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    const duration = Duration(seconds: 10);
    const interval = Duration(milliseconds: 50);

    int step = 0;
    _timer = Timer.periodic(interval, (Timer timer) {
      setState(() {
        step++;
        if (step > 200) {
          timer.cancel();
        }
        _progress = min(1.0,
            step / 200); // Adjust this number to control the uneven filling
      });
    });

    // _timer!.cancel();
    // _timer = Timer.periodic(duration, (Timer timer) {
    //   setState(() {
    //     _progress = 0.0;
    //     step = 0;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        size: const Size(100, 100),
        painter: _CircularProgressPainter(progress: _progress),
      ),
    );
  }
}

class _CircularProgressPainter extends CustomPainter {
  final double progress;

  _CircularProgressPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = AppColors.yellow // Set your desired color here
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 12;

    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = (size.width - paint.strokeWidth) / 2;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -0.5 * pi, // Start angle (top position)
      2 * pi * progress, // Sweep angle (how much of the circle to fill)
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(_CircularProgressPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
