import 'package:flutter/material.dart';

class AuthColors {
  static const Color background = Color(0xFF000033);
  static const Color neonYellow = Color(0xFFFFFF00);
  static const Color lightGrey = Color(0xFF888888);
}

class AuthStyles {
  static final glassDecoration = BoxDecoration(
    color: Colors.white.withOpacity(0.05),
    borderRadius: BorderRadius.circular(4),
    border: const Border(
      bottom: BorderSide(color: AuthColors.neonYellow, width: 2),
    ),
  );

  static const labelStyle = TextStyle(
    color: AuthColors.neonYellow,
    fontSize: 10,
    fontWeight: FontWeight.w900,
    letterSpacing: 2.0,
  );
}