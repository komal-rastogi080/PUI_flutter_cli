import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class TerminalColors {
  static const Color background = Color(0xFF030A04);
  static const Color terminalGreen = Color(0xFF00FF41);
  static const Color alertRed = Color(0xFFFF3131);
}

class TerminalStyles {
  static const textStyle = TextStyle(
    color: TerminalColors.terminalGreen,
    fontFamily: 'Courier',
    letterSpacing: 1.2,
  );

  static final boxDecoration = BoxDecoration(
    color: Colors.black,
    borderRadius: BorderRadius.circular(4),
    border: Border.all(color: TerminalColors.terminalGreen.withOpacity(0.3), width: 1),
    boxShadow: [
      BoxShadow(color: TerminalColors.terminalGreen.withOpacity(0.05), blurRadius: 10),
    ],
  );
}

// --- PASSWORD FIELD WITH VISIBILITY TOGGLE ---
class TerminalPasswordField extends StatefulWidget {
  final String label;
  final String prefix;
  final String hint;
  const TerminalPasswordField({required this.label, required this.prefix, required this.hint, Key? key}) : super(key: key);

  @override
  _TerminalPasswordFieldState createState() => _TerminalPasswordFieldState();
}

class _TerminalPasswordFieldState extends State<TerminalPasswordField> {
  bool _isObscured = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: TerminalStyles.textStyle.copyWith(fontSize: 10, color: TerminalColors.terminalGreen.withOpacity(0.6))),
        TextField(
          obscureText: _isObscured,
          style: TerminalStyles.textStyle,
          cursorColor: TerminalColors.terminalGreen,
          decoration: InputDecoration(
            prefixText: widget.prefix,
            prefixStyle: TerminalStyles.textStyle,
            hintText: widget.hint,
            hintStyle: TerminalStyles.textStyle.copyWith(color: TerminalColors.terminalGreen.withOpacity(0.3)),
            suffixIcon: IconButton(
              icon: Icon(_isObscured ? Icons.visibility_off : Icons.visibility, color: TerminalColors.terminalGreen.withOpacity(0.5), size: 18),
              onPressed: () => setState(() => _isObscured = !_isObscured),
            ),
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: TerminalColors.terminalGreen.withOpacity(0.3))),
            focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: TerminalColors.terminalGreen)),
          ),
        ),
      ],
    );
  }
}

// --- ANIMATION WIDGETS ---
class TypewriterText extends StatefulWidget {
  final String text;
  final TextStyle style;
  const TypewriterText({required this.text, required this.style, Key? key}) : super(key: key);
  @override
  _TypewriterTextState createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText> {
  String _displayedText = "";
  int _currentIndex = 0;
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      if (_currentIndex < widget.text.length) {
        setState(() { _displayedText += widget.text[_currentIndex]; _currentIndex++; });
      } else { _timer?.cancel(); }
    });
  }
  @override
  void dispose() { _timer?.cancel(); super.dispose(); }
  @override
  Widget build(BuildContext context) => Text(_displayedText, style: widget.style);
}

class NeonGlitchText extends StatefulWidget {
  final String text;
  final TextStyle style;
  const NeonGlitchText({required this.text, required this.style, Key? key}) : super(key: key);
  @override
  _NeonGlitchTextState createState() => _NeonGlitchTextState();
}

class _NeonGlitchTextState extends State<NeonGlitchText> {
  double _xOffset = 0;
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 150), (timer) {
      if (Random().nextInt(10) > 8) setState(() => _xOffset = (Random().nextDouble() * 3) - 1.5);
      else setState(() => _xOffset = 0);
    });
  }
  @override
  void dispose() { _timer?.cancel(); super.dispose(); }
  @override
  Widget build(BuildContext context) => Transform.translate(offset: Offset(_xOffset, 0), child: Text(widget.text, style: widget.style));
}