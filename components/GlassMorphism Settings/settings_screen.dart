import 'dart:ui';
import 'package:flutter/material.dart';

class GlassSettingsScreen extends StatelessWidget {
  final bool isDark;
  final ValueChanged<bool> onThemeToggle;

  const GlassSettingsScreen({
    super.key,
    required this.isDark,
    required this.onThemeToggle,
  });

  @override
  Widget build(BuildContext context) {
    final Color mainColor = isDark ? Colors.white : Colors.black87;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          // Vibrant background makes the glass effect visible
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [const Color(0xFF0F2027), const Color(0xFF203A43)]
                : [const Color(0xFF83a4d4), const Color(0xFFb6fbff)],
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              const SizedBox(height: 20),
              _buildAppBar(mainColor),
              const SizedBox(height: 20),

              // Profile Glass Card
              _GlassContainer(
                child: _buildProfileHeader(mainColor),
              ),

              const SizedBox(height: 25),
              _buildSectionTitle("General", mainColor),

              // Settings Group 1: Mixed Toggles and Actions
              _GlassContainer(
                child: Column(
                  children: [
                    _SettingsTile(Icons.dark_mode, "Dark Mode", Colors.blueGrey,
                        trailing: Switch(
                          value: isDark,
                          onChanged: onThemeToggle,
                          activeColor: Colors.cyanAccent,
                        )),
                    _SettingsTile(Icons.person, "Edit Profile", Colors.orange, onTap: () {}),
                    _SettingsTile(Icons.vpn_key, "Change Password", Colors.blue, onTap: () {}),
                  ],
                ),
              ),

              const SizedBox(height: 25),
              _buildSectionTitle("Notifications", mainColor),

              // Settings Group 2: Notifications
              _GlassContainer(
                child: _SettingsTile(Icons.notifications, "Notifications", Colors.green,
                    trailing: Switch(value: true, onChanged: (v) {}, activeColor: Colors.cyanAccent)),
              ),

              const SizedBox(height: 25),
              _buildSectionTitle("Regional", mainColor),

              // Settings Group 3: App Info & Logout
              _GlassContainer(
                child: Column(
                  children: [
                    _SettingsTile(Icons.translate, "Language", Colors.indigo, onTap: () {}),
                    _SettingsTile(Icons.exit_to_app, "Logout", Colors.redAccent, isLast: true, onTap: () {}),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(Color color) {
    return Text(
      "Settings",
      style: TextStyle(color: color, fontSize: 32, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildSectionTitle(String title, Color color) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 10),
      child: Text(title, style: TextStyle(color: color.withValues(alpha: 0.7), fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildProfileHeader(Color color) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 35,
            backgroundImage: NetworkImage('https://www.shutterstock.com/image-vector/user-icon-male-avatar-business-260nw-709279021.jpg'),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Kapil Mohan", style: TextStyle(color: color, fontSize: 20, fontWeight: FontWeight.bold)),
                Text("Edit personal details", style: TextStyle(color: color.withValues(alpha: 0.6), fontSize: 13)),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, size: 18, color: color.withValues(alpha: 0.4)),
        ],
      ),
    );
  }
}

class _GlassContainer extends StatelessWidget {
  final Widget child;
  const _GlassContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withValues(alpha: 0.2), width: 1.5),
          ),
          child: child,
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color iconBgColor;
  final Widget? trailing;
  final bool isLast;
  final VoidCallback? onTap;

  const _SettingsTile(this.icon, this.title, this.iconBgColor, {this.trailing, this.isLast = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    final themeColor = Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black87;

    return Column(
      children: [
        ListTile(
          onTap: onTap,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconBgColor, // Colorful icon background
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          title: Text(title, style: TextStyle(color: themeColor, fontWeight: FontWeight.w600)),
          trailing: trailing ?? Icon(Icons.arrow_forward_ios, size: 16, color: themeColor.withValues(alpha: 0.3)),
        ),
        if (!isLast) Divider(color: themeColor.withValues(alpha: 0.1), indent: 70),
      ],
    );
  }
}