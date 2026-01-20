import 'package:flutter/material.dart';

class CenteredPillNav extends StatefulWidget {
  const CenteredPillNav({super.key});

  @override
  State<CenteredPillNav> createState() => _CenteredPillNavState();
}

class _CenteredPillNavState extends State<CenteredPillNav> {
  int _selectedIndex = 0;

  // FIXED WIDTHS: Ensures math stays perfect for centering
  final double iconAreaWidth = 60.0;
  final double expandedWidth = 120.0;

  // Modern, vibrant palette
  final List<Map<String, dynamic>> _navItems = [
    {'icon': Icons.grid_view_rounded, 'label': 'Home', 'color': const Color(0xFF6366F1)},
    {'icon': Icons.bolt_rounded, 'label': 'Activity', 'color': const Color(0xFFF59E0B)},
    {'icon': Icons.rocket_launch_rounded, 'label': 'Explore', 'color': const Color(0xFF10B981)},
    {'icon': Icons.settings_rounded, 'label': 'Settings', 'color': const Color(0xFFEC4899)},
  ];

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    // Calculate cluster width to keep it centered
    double totalNavWidth = (_navItems.length - 1) * iconAreaWidth + expandedWidth;

    return Container(
      height: 100,
      padding: const EdgeInsets.only(bottom: 30),
      child: Center(
        child: Container(
          height: 70,
          width: totalNavWidth + 20, // Cluster container
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1C1C1E) : Colors.white,
            borderRadius: BorderRadius.circular(35),
            boxShadow: [
              BoxShadow(
                color: _navItems[_selectedIndex]['color'].withOpacity(0.2),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Stack(
            children: [
              // 1. Sliding Pill: Positioned precisely relative to icons
              AnimatedPositioned(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutCubic,
                left: _calculatePillLeft() + 10,
                top: 8,
                child: Container(
                  width: expandedWidth - 16,
                  height: 54,
                  decoration: BoxDecoration(
                    color: _navItems[_selectedIndex]['color'],
                    borderRadius: BorderRadius.circular(27),
                  ),
                ),
              ),
              // 2. Icons Row: Centered and overflow-protected
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(_navItems.length, (index) {
                    bool isSelected = _selectedIndex == index;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedIndex = index),
                      behavior: HitTestBehavior.opaque,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeOutCubic,
                        width: isSelected ? expandedWidth : iconAreaWidth,
                        height: 70,
                        child: _buildTabContent(index, isSelected),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double _calculatePillLeft() {
    double left = 0;
    for (int i = 0; i < _selectedIndex; i++) {
      left += iconAreaWidth;
    }
    return left;
  }

  Widget _buildTabContent(int index, bool isSelected) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          _navItems[index]['icon'],
          color: isSelected ? Colors.white : Colors.grey.shade600,
          size: 24,
        ),
        if (isSelected)
          Flexible( // CRITICAL: Fixes the overflow error
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                _navItems[index]['label'],
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                overflow: TextOverflow.ellipsis, // Safe text truncation
                maxLines: 1,
              ),
            ),
          ),
      ],
    );
  }
}