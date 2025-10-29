import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';

extension FlushBarErrorExtension on BuildContext {
  void flushBarErrorMessage({required String message}) {
    showFlushbar(context: this, flushbar: Flushbar(
      message: message,
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18),
      padding: const EdgeInsets.all(15.0),
      borderRadius: BorderRadius.circular(12),
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.red.shade600,
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      forwardAnimationCurve: Curves.decelerate,
      reverseAnimationCurve: Curves.easeInOut,
      leftBarIndicatorColor: Colors.white,
      positionOffset: 20,
      icon: const Icon(Icons.error_outline, size: 28.0, color: Colors.white),
    )..show(this));
  }
}

extension FlushBarSuccessExtension on BuildContext {
  void flushBarSuccessMessage({required String message}) {
    showFlushbar(context: this, flushbar: Flushbar(
      message: message,
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18),
      padding: const EdgeInsets.all(15.0),
      borderRadius: BorderRadius.circular(12),
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.green.shade600,
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      forwardAnimationCurve: Curves.decelerate,
      reverseAnimationCurve: Curves.easeInOut,
      leftBarIndicatorColor: Colors.white,
      positionOffset: 20,
      icon: const Icon(Icons.check_circle_outline, size: 28.0, color: Colors.white),
    )..show(this));
  }
}

