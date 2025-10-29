import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  // 🔁 Change focus between text fields
  fieldFocusChange(BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  // 🔔 Toast message
  static void toastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  // ❌ Error flushbar
  static void flushBarErrorMessage(String message, BuildContext context) {
    Flushbar(
      message: message,
      icon: const Icon(Icons.error_outline, size: 28.0, color: Colors.white),
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      padding: const EdgeInsets.all(15.0),
      borderRadius: BorderRadius.circular(12),
      backgroundColor: Colors.red.shade600,
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      forwardAnimationCurve: Curves.decelerate,
      reverseAnimationCurve: Curves.easeInOut,
      leftBarIndicatorColor: Colors.white,
      positionOffset: 20,
    ).show(context);
  }

  // ✅ Success flushbar
  static void flushBarSuccessMessage(String message, BuildContext context) {
    Flushbar(
      message: message,
      icon: const Icon(Icons.check_circle_outline, size: 28.0, color: Colors.white),
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      padding: const EdgeInsets.all(15.0),
      borderRadius: BorderRadius.circular(12),
      backgroundColor: Colors.green.shade600,
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      forwardAnimationCurve: Curves.decelerate,
      reverseAnimationCurve: Curves.easeInOut,
      leftBarIndicatorColor: Colors.white,
      positionOffset: 20,
    ).show(context);
  }

  // 📢 Basic snackbar (optional fallback)
  snackBar(String message, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(message),
      ),
    );
  }



}
