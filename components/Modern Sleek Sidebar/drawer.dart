import 'package:flutter/material.dart';
import 'item.dart';
import 'theme.dart';
import 'container.dart';

class ResponsiveSidebar extends StatelessWidget {
  final bool isDark;
  final ValueChanged<bool> onThemeToggle;
  final int selectedIndex;
  final ValueChanged<int> onItemTap;

  const ResponsiveSidebar({
    super.key,
    required this.isDark,
    required this.onThemeToggle,
    required this.selectedIndex,
    required this.onItemTap,
  });

  static const items = [
    SidebarItem(icon: Icons.home, label: "Home"),
    SidebarItem(icon: Icons.search, label: "Explore"),
    SidebarItem(icon: Icons.event, label: "My Events"),
    SidebarItem(icon: Icons.check_circle_outline, label: "Tasks"),
    SidebarItem(icon: Icons.person_add, label: "Invite Friends"),
    SidebarItem(icon: Icons.settings, label: "Settings"),
    SidebarItem(icon: Icons.info_outline, label: "About"),
  ];

  @override
  Widget build(BuildContext context) {
    final theme =
    isDark ? SidebarTheme.dark() : SidebarTheme.light();

    final sidebar = GlowContainer(
      glow: theme.glow,
      child: Container(
        width: 280,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: theme.gradient,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _Header(isDark: isDark),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (_, i) {
                    final selected = i == selectedIndex;
                    return ListTile(
                      leading: Icon(
                        items[i].icon,
                        color:
                        selected ? theme.active : theme.inactive,
                      ),
                      title: Text(
                        items[i].label,
                        style: TextStyle(
                          color: selected
                              ? theme.active
                              : theme.inactive,
                          fontWeight: selected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                      onTap: () => onItemTap(i),
                    );
                  },
                ),
              ),
              SwitchListTile(
                value: isDark,
                activeColor: theme.active,
                title: Text(
                  "Dark Mode",
                  style: TextStyle(color: theme.inactive),
                ),
                onChanged: onThemeToggle,
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 900) {
          // 📱 MOBILE → Drawer
          return Drawer(child: sidebar);
        }
        // 🖥 DESKTOP → Permanent Sidebar
        return sidebar;
      },
    );
  }
}
class _Header extends StatelessWidget {
  final bool isDark;

  const _Header({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 26,
            backgroundImage: NetworkImage("https://cdn-icons-png.flaticon.com/512/6819/6819255.png"),
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "PUI",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              Text(
                "70 Events",
                style: TextStyle(
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
