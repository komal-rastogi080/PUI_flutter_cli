import 'dart:ui';

class BrutalistTheme {
  final Color background;
  final Color panel;
  final Color accent;
  final Color text;
  final Color mutedText;
  final Color border;

  const BrutalistTheme({
    required this.background,
    required this.panel,
    required this.accent,
    required this.text,
    required this.mutedText,
    Color? border,
  }) : border = border ?? accent;

  static const night = BrutalistTheme(
    background: Color(0xFF0B0B0B),
    panel: Color(0xFF111111),
    accent: Color(0xFFFFFF00),
    text: Color(0xFFF2F2F2),
    mutedText: Color(0xFFB0B0B0),
    border: Color(0xFF2A2A2A),
  );

  static const day = BrutalistTheme(
    background: Color(0xFFF3F3F3),
    panel: Color(0xFFFFFFFF),
    accent: Color(0xFFFFFF00),
    text: Color(0xFF111111),
    mutedText: Color(0xFF444444),
    border: Color(0xFF000000),
  );
}