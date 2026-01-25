import 'package:flutter/material.dart';

class SidebarTheme {
  // Brand Colors
  static const Color accentColor = Color(0xFFFF5733); // The bright orange/red
  static const Color drawerBg = Color(0xFF1E2328);    // Dark grey background
  static const Color selectionBg = Color(0xFF3D2C2A); // Muted red for active state
  static const Color textSecondary = Colors.grey;

  static ThemeData darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Colors.black,
    primaryColor: accentColor,
  );

  static const TextStyle navTitleStyle = TextStyle(
    color: accentColor,
    letterSpacing: 2.5,
    fontWeight: FontWeight.bold,
    fontSize: 11,
  );

  static const TextStyle menuHeaderStyle = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
}