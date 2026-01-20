import 'package:flutter/material.dart';

class CyberField extends StatefulWidget {
  final String label;
  final String hint;
  final IconData? icon;
  final bool isPassword;

  const CyberField({
    super.key,
    required this.label,
    required this.hint,
    this.icon,
    this.isPassword = false,
  });

  @override
  State<CyberField> createState() => _CyberFieldState();
}

class _CyberFieldState extends State<CyberField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label.toUpperCase(),
            style: const TextStyle(color: Colors.white30, fontSize: 10, letterSpacing: 1.5, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        // Custom Inset Shadow Implementation
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: const Color(0xFF252525),
            boxShadow: [
              // Outer highlight for depth
              BoxShadow(
                color: Colors.white.withOpacity(0.05),
                offset: const Offset(-1, -1),
                blurRadius: 1,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Stack(
              children: [
                // Inner Shadow Top/Left (Dark)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: Colors.black.withOpacity(0.5), width: 2),
                    ),
                  ),
                ),
                TextField(
                  obscureText: widget.isPassword ? _obscure : false,
                  style: const TextStyle(color: Colors.white70),
                  decoration: InputDecoration(
                    hintText: widget.hint,
                    hintStyle: const TextStyle(color: Colors.white12, fontSize: 14),
                    prefixIcon: widget.icon != null ? Icon(widget.icon, color: Colors.white24, size: 20) : null,
                    suffixIcon: widget.isPassword
                        ? IconButton(
                        icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility, color: Colors.white24, size: 20),
                        onPressed: () => setState(() => _obscure = !_obscure))
                        : null,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CyberButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onTap;

  const CyberButton({super.key, required this.text, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text.toUpperCase(),
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
            const SizedBox(width: 10),
            const Icon(Icons.arrow_forward, color: Colors.white, size: 18),
          ],
        ),
      ),
    );
  }
}
class FlowingText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final Color baseColor;
  final Color highlightColor;

  const FlowingText({
    super.key,
    required this.text,
    required this.style,
    this.baseColor = Colors.white,
    this.highlightColor = Colors.orange,
  });

  @override
  State<FlowingText> createState() => _FlowingTextState();
}

class _FlowingTextState extends State<FlowingText> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [
                _controller.value - 0.2,
                _controller.value,
                _controller.value + 0.2,
              ],
              colors: [
                widget.baseColor.withOpacity(0.6),
                widget.highlightColor,
                widget.baseColor.withOpacity(0.6),
              ],
            ).createShader(bounds);
          },
          child: Text(
            widget.text,
            style: widget.style.copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }
}