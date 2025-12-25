import 'package:flutter/material.dart';
import 'constants.dart';

/// ------------------------------------------------------------
/// PUBLIC SIDEBAR COMPONENT (DESKTOP / TABLET)
/// ------------------------------------------------------------
///
/// Usage:
/// Sidebar(
///   isExpanded: true,
///   isDarkMode: false,
///   selectedIndex: 0,
///   onItemSelected: (index) {},
///   onThemeToggle: () {},
/// )
///
class Sidebar extends StatelessWidget {
  final bool isExpanded;
  final bool isDarkMode;
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;
  final VoidCallback onThemeToggle;

  const Sidebar({
    Key? key,
    required this.isExpanded,
    required this.isDarkMode,
    required this.selectedIndex,
    required this.onItemSelected,
    required this.onThemeToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      width: isExpanded ? 260 : 80,
      child: NavigationRail(
        backgroundColor: theme.scaffoldBackgroundColor,
        extended: isExpanded,
        selectedIndex: selectedIndex,
        onDestinationSelected: onItemSelected,
        useIndicator: true,
        indicatorShape: const StadiumBorder(),
        indicatorColor: _indicatorColor(theme),
        selectedIconTheme: IconThemeData(color: _selectedIconColor(theme)),
        unselectedIconTheme: IconThemeData(color: _unselectedIconColor(theme)),
        destinations: _navItems
            .map(
              (item) => NavigationRailDestination(
                icon: Icon(item.icon),
                label: Text(item.label),
              ),
            )
            .toList(),
        trailing: _SidebarFooter(
          isExpanded: isExpanded,
          isDarkMode: isDarkMode,
          onThemeToggle: onThemeToggle,
        ),
      ),
    );
  }

  Color _indicatorColor(ThemeData theme) {
    if (isDarkMode) {
      return theme.colorScheme.primary.withOpacity(0.2);
    }
    return sidebarIndicatorLight;
  }

  Color _selectedIconColor(ThemeData theme) {
    return isDarkMode ? Colors.white : Colors.black;
  }

  Color _unselectedIconColor(ThemeData theme) {
    return isDarkMode ? Colors.grey[400]! : Colors.grey[700]!;
  }
}

/// ------------------------------------------------------------
/// MOBILE DRAWER VARIANT
/// ------------------------------------------------------------
///
/// Usage:
/// Scaffold(
///   drawer: SidebarDrawer(...)
/// )
///
class SidebarDrawer extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;
  final bool isDarkMode;
  final VoidCallback onThemeToggle;

  const SidebarDrawer({
    Key? key,
    required this.selectedIndex,
    required this.onItemSelected,
    required this.isDarkMode,
    required this.onThemeToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            _DrawerHeader(),
            Expanded(
              child: ListView.builder(
                itemCount: _navItems.length,
                itemBuilder: (context, index) {
                  final item = _navItems[index];
                  return ListTile(
                    leading: Icon(item.icon),
                    title: Text(item.label),
                    selected: index == selectedIndex,
                    onTap: () {
                      Navigator.pop(context);
                      onItemSelected(index);
                    },
                  );
                },
              ),
            ),
            const Divider(height: 1),
            _ThemeToggleTile(
              isDarkMode: isDarkMode,
              onToggle: onThemeToggle,
            ),
          ],
        ),
      ),
    );
  }
}

/// ------------------------------------------------------------
/// INTERNAL MODELS (NOT EXPORTED)
/// ------------------------------------------------------------

class _NavItem {
  final IconData icon;
  final String label;

  const _NavItem({
    required this.icon,
    required this.label,
  });
}

const List<_NavItem> _navItems = [
  _NavItem(icon: Icons.dashboard_rounded, label: 'Dashboard'),
  _NavItem(icon: Icons.article_rounded, label: 'Posts'),
  _NavItem(icon: Icons.perm_media_rounded, label: 'Media'),
  _NavItem(icon: Icons.pages_rounded, label: 'Pages'),
  _NavItem(icon: Icons.comment_rounded, label: 'Comments'),
  _NavItem(icon: Icons.palette_rounded, label: 'Appearance'),
  _NavItem(icon: Icons.extension_rounded, label: 'Plugins'),
  _NavItem(icon: Icons.people_rounded, label: 'Users'),
  _NavItem(icon: Icons.settings_rounded, label: 'Settings'),
  _NavItem(icon: Icons.build_rounded, label: 'Tools'),
];

/// ------------------------------------------------------------
/// INTERNAL WIDGETS
/// ------------------------------------------------------------

class _SidebarFooter extends StatelessWidget {
  final bool isExpanded;
  final bool isDarkMode;
  final VoidCallback onThemeToggle;

  const _SidebarFooter({
    required this.isExpanded,
    required this.isDarkMode,
    required this.onThemeToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(height: 1),
        if (isExpanded)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: SwitchListTile(
              value: isDarkMode,
              onChanged: (_) => onThemeToggle(),
              title: Text(isDarkMode ? 'Light Mode' : 'Dark Mode'),
            ),
          )
        else
          IconButton(
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: onThemeToggle,
          ),
      ],
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.all(16),
      child: Text(
        'Menu',
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }
}

class _ThemeToggleTile extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback onToggle;

  const _ThemeToggleTile({
    required this.isDarkMode,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: isDarkMode,
      onChanged: (_) => onToggle(),
      title: Text(isDarkMode ? 'Light Mode' : 'Dark Mode'),
      secondary: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
    );
  }
}
