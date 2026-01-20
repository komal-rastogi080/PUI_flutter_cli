import 'package:flutter/material.dart';

class BauhausColors {
  static const Color primaryBlue = Color(0xFF0000FF);
  static const Color primaryRed = Color(0xFFFF0000);
  static const Color solarYellow = Color(0xFFFFE600);
  static const Color offWhite = Color(0xFFF5F5F5);
  static const Color black = Color(0xFF000000);
}

class BauhausDecorations {
  static BoxDecoration card() => BoxDecoration(
    color: Colors.white,
    border: Border.all(color: BauhausColors.black, width: 2),
    boxShadow: const [BoxShadow(color: BauhausColors.black, offset: Offset(8, 8))],
  );

  static InputDecoration field(String hint, {Widget? suffix}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.black26, fontSize: 13, fontWeight: FontWeight.bold),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: BauhausColors.black, width: 2),
        borderRadius: BorderRadius.zero,
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: BauhausColors.primaryBlue, width: 3),
        borderRadius: BorderRadius.zero,
      ),
      suffixIcon: suffix,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
    );
  }
}

class AnimatedGeometricBackground extends StatefulWidget {
  const AnimatedGeometricBackground({super.key});
  @override
  State<AnimatedGeometricBackground> createState() => _AnimatedGeometricBackgroundState();
}

class _AnimatedGeometricBackgroundState extends State<AnimatedGeometricBackground> {
  bool _active = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () => setState(() => _active = true));
  }

  @override
  Widget build(BuildContext context) {
    // ClipRect prevents geometric shapes from causing overflow errors
    return ClipRect(
      child: Stack(
        children: [
          // Red Triangle Top-Left
          AnimatedPositioned(
            duration: const Duration(milliseconds: 800),
            top: _active ? -20 : -350,
            left: _active ? -20 : -350,
            child: _triangle(300, BauhausColors.primaryRed),
          ),
          // Solar Yellow Circle
          AnimatedPositioned(
            duration: const Duration(milliseconds: 1000),
            top: 350,
            left: _active ? -70 : -250,
            child: Container(
                width: 150, height: 150,
                decoration: const BoxDecoration(color: BauhausColors.solarYellow, shape: BoxShape.circle)
            ),
          ),
          // Blue Diagonal Line
          AnimatedPositioned(
            duration: const Duration(milliseconds: 1200),
            right: _active ? 40 : -250,
            top: 0,
            child: Transform.rotate(
                angle: 0.7,
                child: Container(width: 20, height: 1200, color: BauhausColors.primaryBlue)
            ),
          ),
          // Black Geometric Footer Block
          Positioned(
            bottom: 0, left: 0, right: 0,
            child: Container(
              height: 30,
              color: BauhausColors.black,
              child: Row(
                children: [
                  Container(width: 100, color: BauhausColors.primaryRed),
                  const Spacer(),
                  Container(width: 50, color: BauhausColors.solarYellow),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _triangle(double size, Color color) => CustomPaint(
    size: Size(size, size),
    painter: _TrianglePainter(color),
  );
}

class _TrianglePainter extends CustomPainter {
  final Color color;
  _TrianglePainter(this.color);
  @override
  void paint(Canvas canvas, Size size) {
    var path = Path()..moveTo(size.width, 0)..lineTo(size.width, size.height)..lineTo(0, 0)..close();
    canvas.drawPath(path, Paint()..color = color);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}