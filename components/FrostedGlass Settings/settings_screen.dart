import 'dart:ui';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false;
  bool _faceId = true;
  double _storageValue = 0.65;
  String _userName = "Alex Designer";
  String _userBio = "Flutter Dev | UI Enthusiast";

  // Function to simulate clearing cache
  void _clearCache() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator(color: Colors.white)),
    );
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    Navigator.pop(context);
    setState(() => _storageValue = 0.05);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Cache Cleared!")),
    );
  }

  // Function to edit text fields via BottomSheet
  void _editField(String title, String currentVal, Function(String) onSave) {
    TextEditingController controller = TextEditingController(text: currentVal);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Edit $title", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 15),
              TextField(
                controller: controller,
                autofocus: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.black, foregroundColor: Colors.white),
                  onPressed: () {
                    onSave(controller.text);
                    Navigator.pop(context);
                  },
                  child: const Text("Update"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isDarkMode ? const Color(0xFF0F0F0F) : Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 700) {
            return Center(
              child: Container(
                width: 375,
                height: 812,
                margin: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 40)],
                  border: Border.all(color: Colors.white24, width: 2),
                ),
                child: ClipRRect(borderRadius: BorderRadius.circular(38), child: _buildBody()),
              ),
            );
          }
          return _buildBody();
        },
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: _isDarkMode
              ? [const Color(0xFF1A1A2E), const Color(0xFF16213E)]
              : [const Color(0xFFFF9A9E), const Color(0xFFFAD0C4), const Color(0xFFABC4FF)],
        ),
      ),
      child: SafeArea(
        top: false, // Allows SliverAppBar to sit at the top
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            _buildSliverAppBar(),
            SliverPadding(
              padding: const EdgeInsets.all(20.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _buildProfileCard(),
                  const SizedBox(height: 25),

                  _glassSection("Personal Info", Icons.badge_outlined, [
                    _settingTile("Name", subtitle: _userName, onTap: () {
                      _editField("Name", _userName, (v) => setState(() => _userName = v));
                    }),
                    _settingTile("Bio", subtitle: _userBio, onTap: () {
                      _editField("Bio", _userBio, (v) => setState(() => _userBio = v));
                    }),
                  ]),

                  const SizedBox(height: 20),

                  _glassSection("Security", Icons.shield_outlined, [
                    _switchTile("Dark Appearance", _isDarkMode, (v) => setState(() => _isDarkMode = v)),
                    _switchTile("Use Face ID", _faceId, (v) => setState(() => _faceId = v)),
                  ]),

                  const SizedBox(height: 20),

                  _glassSection("Maintenance", Icons.bolt_outlined, [
                    _storageIndicator(),
                    const SizedBox(height: 10),
                    _settingTile("Clear App Cache",
                      trailing: const Icon(Icons.cleaning_services_outlined, color: Colors.white70, size: 18),
                      onTap: _clearCache,
                    ),
                  ]),

                  const SizedBox(height: 40),
                  _buildLogoutButton(),
                  const SizedBox(height: 40),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      expandedHeight: 100,
      pinned: true,
      centerTitle: false,
      leading: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () {},
        ),
      ),
      flexibleSpace: const FlexibleSpaceBar(
        titlePadding: EdgeInsets.only(left: 65, bottom: 12), // Added horizontal gap here
        centerTitle: false,
        title: Text(
          "Settings",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: Row(
            children: [
              const CircleAvatar(radius: 30, backgroundColor: Colors.white30, child: Icon(Icons.person, color: Colors.white)),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_userName, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    const Text("Premium Member", style: TextStyle(color: Colors.white70, fontSize: 12)),
                  ],
                ),
              ),
              const Icon(Icons.verified, color: Colors.blueAccent, size: 18),
            ],
          ),
        ),
      ),
    );
  }

  Widget _glassSection(String title, IconData icon, List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Icon(icon, color: Colors.white, size: 16),
                  const SizedBox(width: 10),
                  Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ]),
                const Divider(color: Colors.white12, height: 25),
                ...children,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _settingTile(String title, {String? subtitle, Widget? trailing, VoidCallback? onTap}) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      title: Text(title, style: const TextStyle(color: Colors.white, fontSize: 14)),
      subtitle: subtitle != null ? Text(subtitle, style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 12)) : null,
      trailing: trailing ?? const Icon(Icons.arrow_forward_ios, color: Colors.white38, size: 12),
    );
  }

  Widget _switchTile(String title, bool val, Function(bool) onChanged) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title, style: const TextStyle(color: Colors.white, fontSize: 14)),
      trailing: Switch.adaptive(value: val, onChanged: onChanged, activeColor: Colors.white, activeTrackColor: Colors.white38),
    );
  }

  Widget _storageIndicator() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Disk Space", style: TextStyle(color: Colors.white, fontSize: 13)),
            Text("${(_storageValue * 100).toInt()}%", style: const TextStyle(color: Colors.white70, fontSize: 11)),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(value: _storageValue, backgroundColor: Colors.white12, color: Colors.white, minHeight: 4),
      ],
    );
  }

  Widget _buildLogoutButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          shape: const StadiumBorder(),
        ),
        child: const Text("Logout", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}