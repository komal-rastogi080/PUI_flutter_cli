import 'package:flutter/material.dart';

class NavItem {
  final IconData icon;
  final String label;
  const NavItem({required this.icon, required this.label});
}

class AppConstants {
  static const List<NavItem> navItems = [
    NavItem(icon: Icons.dashboard_rounded, label: 'Dashboard'),
    NavItem(icon: Icons.article_rounded, label: 'Posts'),
    NavItem(icon: Icons.perm_media_rounded, label: 'Media'),
    NavItem(icon: Icons.pages_rounded, label: 'Pages'),
    NavItem(icon: Icons.comment_rounded, label: 'Comments'),
    NavItem(icon: Icons.palette_rounded, label: 'Appearance'),
    NavItem(icon: Icons.extension_rounded, label: 'Plugins'),
    NavItem(icon: Icons.people_rounded, label: 'Users'),
    NavItem(icon: Icons.settings_rounded, label: 'Settings'),
    NavItem(icon: Icons.build_rounded, label: 'Tools'),
  ];
}