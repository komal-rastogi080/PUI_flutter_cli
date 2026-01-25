import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'theme.dart';

class BrutalistSidebar extends StatefulWidget {
  final BrutalistTheme theme;
  final VoidCallback onToggleTheme;

  const BrutalistSidebar({
    super.key,
    required this.theme,
    required this.onToggleTheme,
  });

  @override
  State<BrutalistSidebar> createState() =>
      _BrutalistSidebarState();
}

class _BrutalistSidebarState extends State<BrutalistSidebar> {
  int activeIndex = 0;
  bool collapsed = false;

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme;
    final isMobile =
        MediaQuery.of(context).size.width < 768;

    return MouseRegion(
      onEnter: (_) {
        if(!isMobile) setState(() => collapsed = false);
      },
      onExit: (_){
        if(!isMobile) setState(() => collapsed = true);
      },
        child: AnimatedContainer(
    duration: const Duration(milliseconds: 250),
    curve: Curves.easeOutCubic,
    width: collapsed && !isMobile ? 72 : 280,
    decoration: BoxDecoration(
    color: theme.panel,
    border: Border(
    right: BorderSide(color: theme.border, width: 2),
    ),
    ),
    child: SafeArea(
    child: Column(
    children: [
      _header(theme, isMobile),

      if (!collapsed || isMobile) ...[
        const SizedBox(height: 12),
        Expanded(
          child: ListView(
            children: [
              _menuItem(0, Icons.dashboard, "DASHBOARD"),
              _menuItem(1, Icons.bar_chart, "ANALYTICS"),
              _menuItem(2, Icons.chat, "COMMS"),
              _menuItem(3, Icons.settings, "SETTINGS"),
            ],
          ),
        ),
        _themeToggle(theme),
        const SizedBox(height: 16),
      ] else
        const Spacer(),
    ],
    ),
    ),
        ),
    );
  }

  /*──────── HEADER ────────*/
  Widget _header(BrutalistTheme theme, bool isMobile) {
    if (collapsed && !isMobile) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Icon(Icons.menu, color: theme.text , size: 28), // Hamburger Icon
      );
    }

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: theme.accent,
            child: const Icon(Icons.person, color: Colors.black),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("SYSTEM_01", style: TextStyle(color: theme.text, fontWeight: FontWeight.bold)),
                Text("STATUS: ACTIVE", style: TextStyle(color: theme.mutedText, fontSize: 10)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /*──────── MENU ITEM ────────*/
  Widget _menuItem(int index, IconData icon, String label) {
    final theme = widget.theme;
    final isActive = activeIndex == index;

    return InkWell(
      onTap: () => setState(() => activeIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        height: isActive ? 88 : 44,
        width: collapsed ? 44 : 250,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: isActive ? theme.accent : Colors.transparent,
          border: Border.all(color: theme.border, width: 2),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Icon(
              icon,
              color: isActive ? Colors.black : theme.text,
            ),
            if (!collapsed) ...[
              const SizedBox(width: 12),
              Flexible(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: isActive ? Colors.black : theme.text,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  /*──────── THEME TOGGLE ────────*/
  Widget _themeToggle(BrutalistTheme theme) {
    return GestureDetector(
      onTap: widget.onToggleTheme,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(color: theme.border, width: 2),
        ),
        alignment: Alignment.center,
        child: Text(
          "DAY / NIGHT",
          style: TextStyle(
            color: theme.text,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}