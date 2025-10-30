import 'package:flutter/material.dart';

class ThemeState {
  final ThemeData themeData;
  final bool isDarkMode;

  ThemeState({required this.themeData, required this.isDarkMode});

  ThemeState copyWith({ThemeData? themeData, bool? isDarkMode}) {
    return ThemeState(
      themeData: themeData ?? this.themeData,
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }
}
