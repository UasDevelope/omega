import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomToast {
  static void show({
    required String message,
    ToastGravity gravity = ToastGravity.BOTTOM,
    Color backgroundColor = Colors.black87,
    Color textColor = Colors.white,
    double fontSize = 14.0,
    Toast toastLength = Toast.LENGTH_SHORT,
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: toastLength,
      gravity: gravity,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: fontSize,
    );
  }

  static void success(String message) {
    show(message: message, backgroundColor: Colors.green);
  }

  static void error(String message) {
    show(message: message, backgroundColor: Colors.red);
  }

  static void warning(String message) {
    show(message: message, backgroundColor: Colors.orange);
  }

  static void info(String message) {
    show(message: message, backgroundColor: Colors.blueGrey);
  }
}
