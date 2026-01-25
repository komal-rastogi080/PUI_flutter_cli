import 'package:flutter/material.dart';
import 'theme.dart';

class CustomSidebar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabChange;
  final VoidCallback onLogout;
  final bool isMobile;

  const CustomSidebar({
    super.key,
    required this.selectedIndex,
    required this.onTabChange,
    required this.onLogout,
    this.isMobile = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isMobile ? MediaQuery.of(context).size.width * 0.8 : 280,
      color: Colors.transparent,
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: _SidebarPainter(drawCurve: isMobile),
            ),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 45, top: 30),
                  child: Text("NAVIGATION", style: SidebarTheme.navTitleStyle),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 45, bottom: 30),
                  child: Text("System Menu",
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.only(left: 30),
                    children: [
                      _buildItem(0, Icons.home_filled, "Home"),
                      _buildItem(1, Icons.explore, "Discover"),
                      _buildItem(2, Icons.analytics, "Analytics"),
                      _buildItem(3, Icons.email, "Messages", hasNotif: true),
                      _buildItem(4, Icons.settings, "Settings"),
                    ],
                  ),
                ),
                const Divider(color: Colors.white10, indent: 40, endIndent: 40),
                _buildProfile(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(int index, IconData icon, String label, {bool hasNotif = false}) {
    bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () => onTabChange(index),
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row( // Align left so the box doesn't stretch
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isSelected ? SidebarTheme.selectionBg : Colors.transparent,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min, // Hugs the content
                children: [
                  Icon(
                      icon,
                      size: 20,
                      color: isSelected ? SidebarTheme.accentColor : Colors.white60
                  ),
                  const SizedBox(width: 16),
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 16,
                      color: isSelected ? SidebarTheme.accentColor : Colors.white60,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  if (hasNotif) ...[
                    const SizedBox(width: 20),
                    const CircleAvatar(radius: 3, backgroundColor: SidebarTheme.accentColor),
                  ]
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfile() {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 35, bottom: 20, right: 20),
      leading: const CircleAvatar(
        radius: 22,
        backgroundImage: NetworkImage('https://static.vecteezy.com/system/resources/previews/014/194/216/non_2x/avatar-icon-human-a-person-s-badge-social-media-profile-symbol-the-symbol-of-a-person-vector.jpg'),
      ),
      title: const Text("PUI@user", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
      subtitle: const Text("LEAD ARCHITECT", style: TextStyle(fontSize: 10, color: Colors.grey)),
      trailing: IconButton(
        icon: const Icon(Icons.logout, size: 22, color: Colors.white38),
        onPressed: onLogout,
      ),
    );
  }
}

class _SidebarPainter extends CustomPainter {
  final bool drawCurve;
  _SidebarPainter({required this.drawCurve});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = SidebarTheme.drawerBg;
    Paint accentPaint = Paint()..color = SidebarTheme.accentColor;

    canvas.drawRect(Rect.fromLTWH(0, 0, 10, size.height), accentPaint);

    Path path = Path();
    path.moveTo(10, 0);

    if (drawCurve) {
      path.lineTo(size.width * 0.7, 0);
      path.quadraticBezierTo(size.width, size.height * 0.2, size.width * 0.8, size.height * 0.5);
      path.quadraticBezierTo(size.width * 0.6, size.height * 0.8, size.width * 0.85, size.height);
    } else {
      path.lineTo(size.width, 0);
      path.lineTo(size.width, size.height);
    }

    path.lineTo(10, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }
  @override
  bool shouldRepaint(covariant _SidebarPainter oldDelegate) => oldDelegate.drawCurve != drawCurve;
}