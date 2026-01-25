import 'dart:ui';
import 'package:flutter/material.dart';

class AnimatedLegalSupportScreen extends StatefulWidget {
  final bool isDark;
  final ValueChanged<bool> onThemeToggle;

  const AnimatedLegalSupportScreen({
    super.key,
    required this.isDark,
    required this.onThemeToggle,
  });

  @override
  State<AnimatedLegalSupportScreen> createState() => _AnimatedLegalSupportScreenState();
}

class _AnimatedLegalSupportScreenState extends State<AnimatedLegalSupportScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _showInfo = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color outerBg = widget.isDark ? Colors.black : Colors.grey[300]!;
    final Color phoneBg = widget.isDark ? const Color(0xFF0F171E) : const Color(0xFFF5F7FA);
    final Color textColor = widget.isDark ? Colors.white : Colors.black87;

    double screenWidth = MediaQuery.of(context).size.width;
    bool isDesktop = screenWidth > 900;

    return Scaffold(
      backgroundColor: outerBg,
      body: Stack(
        children: [
          // MAIN UI
          Center(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              width: isDesktop ? 450 : screenWidth,
              margin: isDesktop ? const EdgeInsets.symmetric(vertical: 30) : EdgeInsets.zero,
              decoration: BoxDecoration(
                color: phoneBg,
                borderRadius: isDesktop ? BorderRadius.circular(32) : BorderRadius.zero,
                boxShadow: isDesktop ? [
                  BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 40, spreadRadius: 10)
                ] : [],
              ),
              child: ClipRRect(
                borderRadius: isDesktop ? BorderRadius.circular(32) : BorderRadius.zero,
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    _buildHeader(textColor),
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        children: [
                          _staggeredSlide(0, _buildThemeToggle(textColor)),
                          const SizedBox(height: 10),
                          _staggeredSlide(1, _buildSearchField(widget.isDark)),
                          const SizedBox(height: 30),
                          _staggeredSlide(2, _buildSectionTitle("SUPPORT", widget.isDark ? Colors.white60 : Colors.black54)),
                          _staggeredSlide(3, Row(
                            children: [
                              Expanded(child: _SupportCard(Icons.help_outline, "FAQs", Colors.blueAccent, widget.isDark, onTap: () => _showSnackBar("FAQs"))),
                              const SizedBox(width: 15),
                              Expanded(child: _SupportCard(Icons.headset_mic_outlined, "Contact Us", Colors.blueAccent, widget.isDark, onTap: () => _showSnackBar("Contact"))),
                            ],
                          )),
                          const SizedBox(height: 30),
                          _staggeredSlide(4, _buildSectionTitle("LEGAL INFORMATION", widget.isDark ? Colors.white60 : Colors.black54)),
                          _staggeredSlide(5, _buildSettingsGroup(widget.isDark, [
                            _LegalTile(Icons.description_outlined, "Terms of Service", textColor),
                            _LegalTile(Icons.shield_outlined, "Privacy Policy", textColor),
                            _LegalTile(Icons.code, "Open Source Licenses", textColor),
                            _LegalTile(Icons.cookie_outlined, "Cookie Policy", textColor, isLast: true),
                          ])),
                          const SizedBox(height: 30),
                          _staggeredSlide(6, _buildDangerZone(widget.isDark)),
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // BLUR OVERLAY & POPUP
          if (_showInfo) _buildInfoOverlay(phoneBg, textColor),
        ],
      ),
    );
  }

  // --- UI BUILDER METHODS ---

  Widget _buildHeader(Color textColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_ios_new, color: textColor, size: 20)),
          Text("Legal & Support", style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 18)),
          IconButton(
            onPressed: () => setState(() => _showInfo = true),
            icon: const Icon(Icons.info_outline, color: Colors.blueAccent, size: 24),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoOverlay(Color phoneBg, Color textColor) {
    return Positioned.fill(
      child: GestureDetector(
        onTap: () => setState(() => _showInfo = false),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            color: Colors.black.withOpacity(0.4),
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {}, // Prevent dismissal when clicking the card itself
              child: TweenAnimationBuilder(
                duration: const Duration(milliseconds: 300),
                tween: Tween<double>(begin: 0.8, end: 1.0),
                curve: Curves.easeOutBack,
                builder: (context, double value, child) {
                  return Transform.scale(scale: value, child: child);
                },
                child: Container(
                  width: 300,
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: widget.isDark ? const Color(0xFF1A262F) : Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: textColor.withOpacity(0.1)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.info_outline, color: Colors.blueAccent, size: 45),
                      const SizedBox(height: 15),
                      Text("About This App", style: TextStyle(color: textColor, fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Text(
                        "This is a premium responsive template. Background blur and glassmorphism elements are active.",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: textColor.withOpacity(0.7), fontSize: 14, height: 1.4),
                      ),
                      const SizedBox(height: 25),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: () => setState(() => _showInfo = false),
                        child: const Text("Got it!"),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildThemeToggle(Color textColor) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text("Change Theme", style: TextStyle(color: textColor, fontWeight: FontWeight.w600, fontSize: 16)),
      trailing: GlassThemeToggle(isDark: widget.isDark, onChanged: widget.onThemeToggle),
    );
  }

  Widget _buildSearchField(bool isDark) {
    return TextField(
      style: TextStyle(color: isDark ? Colors.white : Colors.black87),
      decoration: InputDecoration(
        filled: true,
        fillColor: isDark ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.05),
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        hintText: "How can we help?",
        hintStyle: const TextStyle(color: Colors.grey),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
      ),
    );
  }

  Widget _buildSectionTitle(String title, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(title, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
    );
  }

  Widget _buildSettingsGroup(bool isDark, List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withOpacity(0.05) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isDark ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.05)),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildDangerZone(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.red.withOpacity(0.1)),
      ),
      child: const Row(
        children: [
          Icon(Icons.person_remove_outlined, color: Colors.redAccent),
          SizedBox(width: 15),
          Text("Delete Account", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _staggeredSlide(int index, Widget child) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final curve = CurvedAnimation(
          parent: _controller,
          curve: Interval((index * 0.1), (0.1 * index + 0.5).clamp(0, 1.0), curve: Curves.easeOutCubic),
        );
        return Opacity(
          opacity: curve.value,
          child: Transform.translate(offset: Offset(0, 30 * (1 - curve.value)), child: child),
        );
      },
      child: child,
    );
  }

  void _showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Action: $text"), behavior: SnackBarBehavior.floating, width: 200),
    );
  }
}

// --- SUB-WIDGETS ---

class GlassThemeToggle extends StatelessWidget {
  final bool isDark;
  final ValueChanged<bool> onChanged;

  const GlassThemeToggle({super.key, required this.isDark, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!isDark),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 60, height: 32,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isDark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.05),
          border: Border.all(color: isDark ? Colors.white24 : Colors.black12),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutBack,
          alignment: isDark ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 24, height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isDark ? Colors.cyanAccent : Colors.orangeAccent,
              boxShadow: [BoxShadow(color: (isDark ? Colors.cyanAccent : Colors.orangeAccent).withOpacity(0.4), blurRadius: 8)],
            ),
            child: Icon(isDark ? Icons.dark_mode : Icons.light_mode, size: 14, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class _SupportCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final Color color;
  final bool isDark;
  final VoidCallback onTap;

  const _SupportCard(this.icon, this.title, this.color, this.isDark, {required this.onTap});

  @override
  State<_SupportCard> createState() => _SupportCardState();
}

class _SupportCardState extends State<_SupportCard> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final baseColor = widget.isDark ? Colors.white.withOpacity(0.05) : Colors.white;
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          transform: Matrix4.identity()..scale(_isPressed ? 0.95 : 1.0),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: _isPressed ? widget.color.withOpacity(0.2) : (_isHovered ? widget.color.withOpacity(0.1) : baseColor),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: (_isPressed || _isHovered) ? widget.color : Colors.transparent, width: 1.5),
            boxShadow: (_isPressed || _isHovered) ? [BoxShadow(color: widget.color.withOpacity(0.2), blurRadius: 10)] : [],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(widget.icon, color: widget.color, size: 30),
              const SizedBox(height: 12),
              Text(widget.title, style: TextStyle(color: widget.isDark ? Colors.white : Colors.black87, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}

class _LegalTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color textColor;
  final bool isLast;
  const _LegalTile(this.icon, this.title, this.textColor, {this.isLast = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () {},
          leading: Icon(icon, color: textColor.withOpacity(0.6), size: 20),
          title: Text(title, style: TextStyle(color: textColor, fontSize: 14, fontWeight: FontWeight.w500)),
          trailing: const Icon(Icons.arrow_forward_ios, size: 12, color: Colors.grey),
        ),
        if (!isLast) Divider(height: 1, color: textColor.withOpacity(0.05), indent: 55),
      ],
    );
  }
}