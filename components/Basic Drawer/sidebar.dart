import 'package:flutter/material.dart';
import 'constants.dart';

class Sidebar extends StatelessWidget {
  final bool isExpanded;
  final bool isDarkMode;
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;
  final VoidCallback onThemeToggle;

  const Sidebar({
    super.key,
    required this.isExpanded,
    required this.isDarkMode,
    required this.selectedIndex,
    required this.onItemSelected,
    required this.onThemeToggle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      // curve: Curves.extraSharpLineThrough,
      width: isExpanded ? 270 : 85,
      decoration: BoxDecoration(
        color: theme.cardColor,
        border: Border(right: BorderSide(color: theme.dividerColor, width: 0.5)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 20),
          _buildLogo(isExpanded),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: AppConstants.navItems.length,
              itemBuilder: (context, index) {
                return _SidebarItem(
                  item: AppConstants.navItems[index],
                  isSelected: selectedIndex == index,
                  isExpanded: isExpanded,
                  onTap: () => onItemSelected(index),
                );
              },
            ),
          ),
          _SidebarFooter(
            isExpanded: isExpanded,
            isDarkMode: isDarkMode,
            onThemeToggle: onThemeToggle,
          ),
        ],
      ),
    );
  }

  Widget _buildLogo(bool expanded) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: expanded 
        ? const Text("PREVIEW UI", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))
        : const Icon(Icons.bolt, color: Colors.deepPurple),
    );
  }
}

class SidebarDrawer extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;
  final bool isDarkMode;
  final VoidCallback onThemeToggle;

  const SidebarDrawer({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
    required this.isDarkMode,
    required this.onThemeToggle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Drawer(
      backgroundColor: theme.scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
      ),
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: theme.colorScheme.primaryContainer.withOpacity(0.4)),
            accountName: const Text("Admin User", style: TextStyle(color: Colors.black)),
            accountEmail: const Text("admin@pui.com", style: TextStyle(color: Colors.black54)),
            currentAccountPicture: const CircleAvatar(backgroundColor: Colors.deepPurple, child: Icon(Icons.person, color: Colors.white)),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: AppConstants.navItems.length,
              itemBuilder: (context, index) {
                final item = AppConstants.navItems[index];
                return ListTile(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  leading: Icon(item.icon),
                  title: Text(item.label),
                  selected: selectedIndex == index,
                  selectedTileColor: theme.colorScheme.primary.withOpacity(0.1),
                  onTap: () {
                    onItemSelected(index);
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
          const Divider(),
          ListTile(
            leading: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
            title: Text(isDarkMode ? "Dark Mode" : "Light Mode"),
            trailing: Switch(value: isDarkMode, onChanged: (_) => onThemeToggle()),
          ),
        ],
      ),
    );
  }
}

// Custom Item with Hover Effects
class _SidebarItem extends StatefulWidget {
  final NavItem item;
  final bool isSelected;
  final bool isExpanded;
  final VoidCallback onTap;

  const _SidebarItem({
    required this.item,
    required this.isSelected,
    required this.isExpanded,
    required this.onTap,
  });

  @override
  State<_SidebarItem> createState() => _SidebarItemState();
}

class _SidebarItemState extends State<_SidebarItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          decoration: BoxDecoration(
            color: widget.isSelected 
                ? theme.colorScheme.primary.withOpacity(isDark ? 0.3 : 0.1) 
                : (_isHovered ? theme.hoverColor : Colors.transparent),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(
                widget.item.icon,
                color: widget.isSelected ? theme.colorScheme.primary : theme.iconTheme.color,
                size: 24,
              ),
              if (widget.isExpanded) ...[
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    widget.item.label,
                    style: TextStyle(
                      color: widget.isSelected ? theme.colorScheme.primary : theme.textTheme.bodyLarge?.color,
                      fontWeight: widget.isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}

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
    return Container(
      padding: const EdgeInsets.all(16),
      child: isExpanded
          ? OutlinedButton.icon(
              onPressed: onThemeToggle,
              icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
              label: Text(isDarkMode ? "Light Mode" : "Dark Mode"),
              style: OutlinedButton.styleFrom(minimumSize: const Size(double.infinity, 45)),
            )
          : IconButton(
              onPressed: onThemeToggle,
              icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            ),
    );
  }
}