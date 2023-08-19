import 'package:flutter/material.dart';

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height * 0.94);

    final firstControlPoint = Offset(size.width * 0.05, size.height * 0.83);
    final firstEndPoint = Offset(size.width * 0.2, size.height * 0.85);
    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );

    final secondControlPoint = Offset(size.width * 0.3, size.height * 0.9);
    final secondEndPoint = Offset(size.width * 0.4, size.height * 0.95);
    path.quadraticBezierTo(
      secondControlPoint.dx,
      secondControlPoint.dy,
      secondEndPoint.dx,
      secondEndPoint.dy,
    );

    final thirdControlPoint = Offset(size.width * 0.5, size.height);
    final thirdEndPoint = Offset(size.width * 0.6, size.height * 0.9);
    path.quadraticBezierTo(
      thirdControlPoint.dx,
      thirdControlPoint.dy,
      thirdEndPoint.dx,
      thirdEndPoint.dy,
    );

    final fourthControlPoint = Offset(size.width * 0.7, size.height * 0.8);
    final fourthEndPoint = Offset(size.width * 0.8, size.height * 0.6);
    path.quadraticBezierTo(
      fourthControlPoint.dx,
      fourthControlPoint.dy,
      fourthEndPoint.dx,
      fourthEndPoint.dy,
    );

    final fifthControlPoint = Offset(size.width * 0.9, size.height * 0.4);
    final fifthEndPoint = Offset(size.width, size.height * 0.5);
    path.quadraticBezierTo(
      fifthControlPoint.dx,
      fifthControlPoint.dy,
      fifthEndPoint.dx,
      fifthEndPoint.dy,
    );

    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
