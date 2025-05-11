import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData.dark().copyWith(
  primaryColor: const Color(0xff060E1E),
  scaffoldBackgroundColor: const Color(0xff060E1E),
  colorScheme: const ColorScheme.dark(
    primary: Color(0xff060E1E),
    secondary: Color(0xff1A1F2B),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white),
  ),
);
