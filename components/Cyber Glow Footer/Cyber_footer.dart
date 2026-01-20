import 'package:flutter/material.dart';

class AnimatedCyberFooter extends StatefulWidget {
  const AnimatedCyberFooter({super.key});

  @override
  State<AnimatedCyberFooter> createState() => _AnimatedCyberFooterState();
}

class _AnimatedCyberFooterState extends State<AnimatedCyberFooter> {
  int _selectedIndex = 0;
  bool _isFabOpen  = false;

  // Placeholder for different screens
  final List<Widget> _pages = [
    const Center(child: Text("Home Screen", style: TextStyle(color: Colors.white, fontSize: 24))),
    const Center(child: Text("Maps Screen", style: TextStyle(color: Colors.white, fontSize: 24))),
    const Center(child: Text("Data Analytics", style: TextStyle(color: Colors.white, fontSize: 24))),
    const Center(child: Text("User Profile", style: TextStyle(color: Colors.white, fontSize: 24))),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // AnimatedSwitcher provides a smooth fade transition between pages
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _pages[_selectedIndex],
      ),
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _buildFab(),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildFab() {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isFabOpen = true),
      onTapUp: (_) => setState(() => _isFabOpen = false),
      onTapCancel: () => setState(() => _isFabOpen = false),
      onTap: () {
        // Add your primary action logic here
        print("Global Action Triggered");
      },
      child: AnimatedScale(
        scale: _isFabOpen ? 0.85 : 1.0, // Shrinks when pressed
        duration: const Duration(milliseconds: 100),
        child: Container(
          height: 65,
          width: 65,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.cyanAccent.withOpacity(_isFabOpen ? 0.6 : 0.3),
                blurRadius: _isFabOpen ? 25 : 15,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.cyanAccent,
            ),
            child: AnimatedRotation(
              turns: _isFabOpen ? 0.125 : 0, // Rotates 45 degrees
              duration: const Duration(milliseconds: 200),
              child: const Icon(
                Icons.add,
                size: 35,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 30),
      height: 70,
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white10, width: 0.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(0, Icons.home_rounded, "HOME"),
          _buildNavItem(1, Icons.explore_rounded, "MAPS"),
          const SizedBox(width: 40), // Gap for FAB
          _buildNavItem(2, Icons.bar_chart_rounded, "DATA"),
          _buildNavItem(3, Icons.person_rounded, "PROFILE"),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    bool isActive = _selectedIndex == index;

    return GestureDetector(
      onTap: () => _onItemTapped(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isActive ? Colors.cyanAccent : Colors.grey.shade600,
              size: isActive ? 28 : 24,
              shadows: isActive
                  ? [const Shadow(color: Colors.cyanAccent, blurRadius: 20)]
                  : null,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isActive ? Colors.cyanAccent : Colors.grey.shade600,
                fontSize: 10,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}