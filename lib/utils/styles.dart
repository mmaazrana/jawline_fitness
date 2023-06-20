import 'package:flutter/material.dart';

class AppStyles {
  static TextStyle titleTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    primary: Colors.blue,
    textStyle: TextStyle(color: Colors.white),
    // Add more button styles here
  );
}
