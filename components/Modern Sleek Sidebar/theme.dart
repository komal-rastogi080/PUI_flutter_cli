import 'package:flutter/material.dart';

class SidebarTheme {
  final List<Color> gradient;
  final Color glow;
  final Color active;
  final Color inactive;

  const SidebarTheme({
    required this.gradient,
    required this.glow,
    required this.active,
    required this.inactive,
  });

  factory SidebarTheme.light() {
    return SidebarTheme(
      gradient: [
        const Color(0xFFE9FFFB),
        const Color(0xFFB9F5E9),
      ],
      glow: const Color(0xFF1BC5A3),
      active: const Color(0xFF1BC5A3),
      inactive: Colors.grey.shade800,
    );
  }

  factory SidebarTheme.dark() {
    return SidebarTheme(
      gradient: [
        const Color(0xFF121212),
        const Color(0xFF0A0A0A),
      ],
      glow: const Color(0xFF1BC5A3),
      active: const Color(0xFF1BC5A3),
      inactive: Colors.grey.shade400,
    );
  }
}
