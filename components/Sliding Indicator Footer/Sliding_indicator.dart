import 'package:flutter/material.dart';

class SlidingIndicatorNav extends StatefulWidget {
  const SlidingIndicatorNav({super.key});

  @override
  State<SlidingIndicatorNav> createState() => _SlidingIndicatorNavState();
}

class _SlidingIndicatorNavState extends State<SlidingIndicatorNav> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double itemWidth = (screenWidth - 40) / 5; // Adjusting for padding/margins

    return Scaffold(
      backgroundColor: const Color(0xFF0A0C10), // Deep navy background
      body: const Center(
        child: Text("App Content", style: TextStyle(color: Colors.white24)),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(20),
        height: 85,
        decoration: BoxDecoration(
          color: const Color(0xFF12141C), // Slightly lighter navy
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 20,
              offset: const Offset(0, 10),
            )
          ],
        ),
        child: Stack(
          children: [
            // Sliding Top Indicator
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              left: (itemWidth * _selectedIndex) + (itemWidth * 0.1),
              top: 0,
              child: Container(
                width: itemWidth * 0.8,
                height: 3,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueAccent.withOpacity(0.5),
                      blurRadius: 8,
                      spreadRadius: 1,
                    )
                  ],
                ),
              ),
            ),
            // Navigation Items
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _navItem(0, Icons.home_filled, "Home"),
                _navItem(1, Icons.layers_rounded, "Accounts"),
                _navItem(2, Icons.qr_code_scanner_rounded, "Scan QR"),
                _navItem(3, Icons.credit_card_rounded, "Cards"),
                _navItem(4, Icons.person_outline_rounded, "Profile"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _navItem(int index, IconData icon, String label) {
    bool isActive = _selectedIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedIndex = index),
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon with Glow
            Stack(
              alignment: Alignment.center,
              children: [
                if (isActive)
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueAccent.withOpacity(0.15),
                          blurRadius: 15,
                          spreadRadius: 5,
                        )
                      ],
                    ),
                  ),
                Icon(
                  icon,
                  color: isActive ? Colors.blueAccent : Colors.grey.shade600,
                  size: 28,
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isActive ? Colors.blueAccent : Colors.grey.shade600,
                fontSize: 11,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}