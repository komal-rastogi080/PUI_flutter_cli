import 'package:flutter/material.dart';

class SpotlightNav extends StatefulWidget {
  const SpotlightNav({super.key});

  @override
  State<SpotlightNav> createState() => _SpotlightNavState();
}

class _SpotlightNavState extends State<SpotlightNav> {
  int _selectedIndex = 0;
  final int totalItems = 5;

  // Unique colors for each tab's beam
  final List<Color> _beamColors = [
    Colors.blueAccent,
    const Color(0xFFFF4D4D), // Red
    const Color(0xFF00FF88), // Green
    const Color(0xFF7000FF), // Purple
    Colors.amber,
  ];

  @override
  Widget build(BuildContext context) {
    // Detect if the app is currently in Dark or Light mode
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return LayoutBuilder(
      builder: (context, constraints) {
        // Responsive width logic
        double maxWidth = constraints.maxWidth;
        double barWidth = maxWidth > 800 ? 500 : maxWidth * 0.9;
        double itemWidth = barWidth / totalItems;

        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: const EdgeInsets.only(bottom: 24),
            height: 70,
            width: barWidth,
            decoration: BoxDecoration(
              // Theme-aware bar color
              color: isDark ? const Color(0xFF1A1A1A) : Colors.white,
              borderRadius: BorderRadius.circular(35),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(isDark ? 0.5 : 0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Stack(
              children: [
                // Animated Spotlight Beam
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 350),
                  curve: Curves.easeOutCubic,
                  left: _selectedIndex * itemWidth,
                  child: CustomPaint(
                    painter: SpotlightPainter(
                      color: _beamColors[_selectedIndex],
                      isDark: isDark,
                    ),
                    size: Size(itemWidth, 70),
                  ),
                ),
                // Icons Row
                Row(
                  children: List.generate(totalItems, (index) {
                    return _buildIcon(index, itemWidth, isDark);
                  }),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildIcon(int index, double width, bool isDark) {
    final List<IconData> icons = [
      Icons.home_rounded,
      Icons.favorite_rounded,
      Icons.add_circle_rounded,
      Icons.person_rounded,
      Icons.notifications_rounded,
    ];

    bool isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: width,
        height: 70,
        child: Icon(
          icons[index],
          color: isSelected
              ? _beamColors[index]
              : (isDark ? Colors.grey.shade700 : Colors.grey.shade400),
          size: 26,
        ),
      ),
    );
  }
}

class SpotlightPainter extends CustomPainter {
  final Color color;
  final bool isDark;
  SpotlightPainter({required this.color, required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          color.withOpacity(isDark ? 0.4 : 0.2), // Lighter beam in Light mode
          color.withOpacity(isDark ? 0.05 : 0.02),
          Colors.transparent,
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    var path = Path();
    path.moveTo(size.width * 0.25, 0);
    path.lineTo(size.width * 0.75, 0);
    path.lineTo(size.width * 0.95, size.height);
    path.lineTo(size.width * 0.05, size.height);
    path.close();

    canvas.drawPath(path, paint);

    // Top Glowing Accent Line
    final linePaint = Paint()
      ..color = color
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(size.width * 0.25, 1),
      Offset(size.width * 0.75, 1),
      linePaint,
    );
  }

  @override
  bool shouldRepaint(SpotlightPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.isDark != isDark;
}