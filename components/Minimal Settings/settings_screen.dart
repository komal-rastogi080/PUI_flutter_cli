import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  const SettingsScreen({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: theme.iconTheme.color, size: 18),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: Text("Settings", style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildProfileHeader(theme),
          const SizedBox(height: 30),
          _buildSectionTitle("Other settings", theme),
          const SizedBox(height: 10),
          _buildSettingsGroup([
            _SettingsTile(Icons.person_outline, "Profile details", onTap: () {}),
            _SettingsTile(Icons.lock_outline, "Password", onTap: () {}),
            _SettingsTile(Icons.notifications_none, "Notifications", onTap: () {}),
            _SettingsTile(
              Icons.dark_mode_outlined,
              "Dark mode",
              trailing: Switch(
                value: isDarkMode,
                onChanged: onThemeChanged,
                activeColor: Colors.blue,
              ),
            ),
          ], theme),
          const SizedBox(height: 20),
          _buildSettingsGroup([
            _SettingsTile(Icons.info_outline, "About application", onTap: () {}),
            _SettingsTile(Icons.help_outline, "Help/FAQ", onTap: () {}),
            _SettingsTile(Icons.delete_outline, "Deactivate my account",
              textColor: Colors.red,
              iconColor: Colors.red,
              onTap: () {},
            ),
          ], theme),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10)],
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage('https://static.vecteezy.com/system/resources/previews/014/194/216/non_2x/avatar-icon-human-a-person-s-badge-social-media-profile-symbol-the-symbol-of-a-person-vector.jpg'),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Alfred Daniel", style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                Text("Product/UI Designer", style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey)),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, ThemeData theme) {
    return Text(title, style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey, fontWeight: FontWeight.w500));
  }

  Widget _buildSettingsGroup(List<Widget> tiles, ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10)],
      ),
      child: Column(children: tiles),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget? trailing;
  final Color? textColor;
  final Color? iconColor;
  final VoidCallback? onTap;

  const _SettingsTile(this.icon, this.title, {this.trailing, this.textColor, this.iconColor, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    return ListTile(
      onTap: onTap,
      leading: Icon(
          icon,
          color: iconColor ?? (isDark ? Colors.white : Colors.black54),
          size: 22
      ),
      title: Text(
          title,
          style: TextStyle(
              color: textColor ?? (isDark ? Colors.white : Colors.black87),
              fontSize: 15,
              fontWeight: FontWeight.w500
          )
      ),
      trailing: trailing ?? Icon(
          Icons.arrow_forward_ios,
          size: 14,
          color: isDark ? Colors.white38 : Colors.grey
      ),
    );
  }
}