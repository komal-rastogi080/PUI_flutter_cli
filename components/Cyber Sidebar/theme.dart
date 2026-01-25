import 'package:flutter/material.dart';

class CyberTheme {
  static const Color primaryNeon = Color(0xFFFF00FF); // Magenta
  static const Color background = Color(0xFF0D0D0E);
  static const Color surface = Color(0xFF161618);

  static ThemeData get theme => ThemeData.dark().copyWith(
    scaffoldBackgroundColor: background,
    primaryColor: primaryNeon,
  );

  static const TextStyle subLabel = TextStyle(
    fontSize: 8,
    letterSpacing: 2,
    color: primaryNeon,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle sidebarTitle = TextStyle(
    fontSize: 14, // Reduced from 16
    fontWeight: FontWeight.bold,
    letterSpacing: 1,
  );
}