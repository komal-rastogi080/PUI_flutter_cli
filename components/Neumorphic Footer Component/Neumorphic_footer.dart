import 'package:flutter/material.dart';

class DynamicNeumorphicFooter extends StatefulWidget {
  const DynamicNeumorphicFooter({super.key});

  @override
  State<DynamicNeumorphicFooter> createState() => _DynamicNeumorphicFooterState();
}

class _DynamicNeumorphicFooterState extends State<DynamicNeumorphicFooter> {
  int _selectedIndex = 0;

  // Define unique colors for each icon as requested
  final List<Color> _navColors = [
    const Color(0xFFFF5733), // Core - Orange
    const Color(0xFF33FF57), // Query - Green
    const Color(0xFF3357FF), // Logs - Blue
    const Color(0xFFFF33E9), // Auth - Pink
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1013),
      body: Stack(
        children: [
          // Content Area
          Center(
            child: Text(
              "Active Section: ${_selectedIndex + 1}",
              style: const TextStyle(color: Colors.white24, fontSize: 32),
            ),
          ),
          // Positioned at the bottom
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: _buildNavigationBar(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1B1E),
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(0, Icons.grid_view_rounded, "CORE"),
          _buildNavItem(1, Icons.search_rounded, "QUERY"),
          _buildNavItem(2, Icons.layers_rounded, "LOGS"),
          _buildNavItem(3, Icons.person_rounded, "AUTH"),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    bool isActive = _selectedIndex == index;
    Color activeColor = _navColors[index];

    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildAnimatedCircle(icon, isActive, activeColor),
          // Animated Title Visibility
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            height: isActive ? 20 : 0,
            curve: Curves.easeInOut,
            child: Opacity(
              opacity: isActive ? 1.0 : 0.0,
              child: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  label,
                  style: TextStyle(
                    color: activeColor,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedCircle(IconData icon, bool isActive, Color color) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFF1A1B1E),
        boxShadow: isActive
            ? null // Inset effect handled by Stack below
            : [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            offset: const Offset(5, 5),
            blurRadius: 10,
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.02),
            offset: const Offset(-2, -2),
            blurRadius: 5,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Internal Shadow (Visible only when active)
            if (isActive) ...[
              Positioned(
                left: -4, top: -4,
                child: Container(
                  width: 68, height: 68,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.9),
                        blurRadius: 8,
                        offset: const Offset(6, 6),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                right: -4, bottom: -4,
                child: Container(
                  width: 68, height: 68,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(-6, -6),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            // Icon with scale transition
            AnimatedScale(
              duration: const Duration(milliseconds: 200),
              scale: isActive ? 1.1 : 0.9,
              child: Icon(
                icon,
                color: isActive ? color : Colors.grey.shade600,
                size: 26,
              ),
            ),
          ],
        ),
      ),
    );
  }
}