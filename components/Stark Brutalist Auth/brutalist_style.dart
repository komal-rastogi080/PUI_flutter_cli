import 'package:flutter/material.dart';

class StarkColors {
  static const Color background = Colors.white;
  static const Color ink = Colors.black;
  static const Color neonAccent = Color(0xFFEAFF00); // Sharp Yellow
  static const Color greyText = Color(0xFF999999);
}

class BrutalistStyles {
  static final border = Border.all(color: StarkColors.ink, width: 2.5);

  static const headerStyle = TextStyle(
    color: StarkColors.ink,
    fontSize: 48,
    fontWeight: FontWeight.w900,
    height: 0.8,
    letterSpacing: -2,
  );

  static const labelStyle = TextStyle(
    color: StarkColors.ink,
    fontSize: 10,
    fontWeight: FontWeight.w900,
    letterSpacing: 1.2,
  );
}

// Reusable Brutalist Text Field
class BrutalistInput extends StatelessWidget {
  final String label;
  final String hint;
  final bool isPassword;
  final Widget? suffix;

  const BrutalistInput({
    required this.label,
    required this.hint,
    this.isPassword = false,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label.toUpperCase(), style: BrutalistStyles.labelStyle),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(border: BrutalistStyles.border),
          child: TextField(
            obscureText: isPassword,
            cursorColor: StarkColors.ink,
            style: const TextStyle(fontWeight: FontWeight.bold, color: StarkColors.ink),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Color(0xFF757575), fontSize: 12),
              contentPadding: const EdgeInsets.all(16),
              border: InputBorder.none,
              suffixIcon: suffix,
            ),
          ),
        ),
      ],
    );
  }
}
class BrutalistPasswordField extends StatefulWidget {
  final String label;
  final String hint;

  const BrutalistPasswordField({required this.label, required this.hint, Key? key}) : super(key: key);

  @override
  State<BrutalistPasswordField> createState() => _BrutalistPasswordFieldState();
}

class _BrutalistPasswordFieldState extends State<BrutalistPasswordField> {
  bool _isObscured = true; // State to track visibility

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label.toUpperCase(), style: BrutalistStyles.labelStyle),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(border: BrutalistStyles.border),
          child: TextField(
            obscureText: _isObscured,
            cursorColor: StarkColors.ink,
            style: const TextStyle(fontWeight: FontWeight.bold, color: StarkColors.ink, fontSize: 12),
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: const TextStyle(color: Color(0xFF757575)),
              contentPadding: const EdgeInsets.all(16),
              border: InputBorder.none,
              // The working toggle button
              suffixIcon: IconButton(
                icon: Icon(
                  _isObscured ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                  color: StarkColors.ink,
                ),
                onPressed: () {
                  setState(() {
                    _isObscured = !_isObscured;
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}