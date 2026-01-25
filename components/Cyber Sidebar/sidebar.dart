import 'package:flutter/material.dart';
import 'theme.dart';

class CyberSidebar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabChange;
  final VoidCallback onLogout;
  final bool isMobile;

  const CyberSidebar({
    super.key,
    required this.selectedIndex,
    required this.onTabChange,
    required this.onLogout,
    this.isMobile = true,
  });

  @override
  Widget build(BuildContext context) {
    // Width logic: Narrow for desktop, wide for mobile drawer
    final double sidebarWidth = isMobile ? MediaQuery.of(context).size.width * 0.8 : 200;

    return Container(
      width: sidebarWidth,
      color: CyberTheme.background,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children: [
                  _buildItem(0, Icons.grid_view_rounded, "HOME", "CENTRAL NODE"),
                  _buildItem(1, Icons.folder_copy_outlined, "ARCHIVE", "DATA REPOSITORY"),
                  _buildItem(2, Icons.sensors, "TRANSMISSIONS", "SIGNAL LOGS"),
                  _buildItem(3, Icons.settings_input_component, "SETTINGS", "CORE PARAMS"),
                  _buildItem(4, Icons.lock_outline, "ENCRYPTED", "LVL 5 DATA"),
                ],
              ),
            ),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(int index, IconData icon, String title, String sub) {
    bool isActive = selectedIndex == index;
    return GestureDetector(
      onTap: () => onTabChange(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? CyberTheme.primaryNeon.withOpacity(0.08) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, color: isActive ? CyberTheme.primaryNeon : Colors.white30, size: 18),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: CyberTheme.sidebarTitle.copyWith(
                  color: isActive ? Colors.white : Colors.white54,
                )),
                if (isActive)
                  Text(sub, style: const TextStyle(fontSize: 8, color: CyberTheme.primaryNeon)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Padding(
      padding: EdgeInsets.only(left: 25, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("INTERFACE", style: CyberTheme.subLabel),
          Text("NAVIGATION", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(border: Border(top: BorderSide(color: Colors.white10))),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage('https://static.vecteezy.com/system/resources/previews/014/194/216/non_2x/avatar-icon-human-a-person-s-badge-social-media-profile-symbol-the-symbol-of-a-person-vector.jpg'),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("PUI@user", style: TextStyle(fontSize: 11, color: CyberTheme.primaryNeon, fontWeight: FontWeight.bold)),
                Text("Alpha_7", style: TextStyle(fontSize: 9, color: Colors.white38)),
              ],
            ),
          ),
          IconButton(
            onPressed: onLogout,
            icon: const Icon(Icons.power_settings_new, color: Colors.white30, size: 18),
          ),
        ],
      ),
    );
  }
}