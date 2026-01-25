import 'dart:async';
import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SupportFeedbackForm extends StatefulWidget {
  const SupportFeedbackForm({super.key});

  @override
  State<SupportFeedbackForm> createState() => _SupportFeedbackFormState();
}

class _SupportFeedbackFormState extends State<SupportFeedbackForm> {
  int _selectedRating = 3;
  double _responseSpeed = 4.0;
  bool _resolved = true;
  final TextEditingController _feedbackController = TextEditingController();
  final int _charLimit = 140;
  bool _isSubmitted = false;

  final List<Map<String, dynamic>> _ratings = [
    {"label": "Terrible", "emoji": "😡", "color": Colors.redAccent},
    {"label": "Bad", "emoji": "😟", "color": Colors.orangeAccent},
    {"label": "Okay", "emoji": "😐", "color": Colors.amberAccent},
    {"label": "Good", "emoji": "🙂", "color": const Color(0xFF2ECC71)},
    {"label": "Amazing", "emoji": "🤩", "color": Colors.cyanAccent},
  ];

  void _submitFeedback() {
    if (_feedbackController.text.isEmpty) return;
    HapticFeedback.heavyImpact(); //
    setState(() => _isSubmitted = true);

    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) setState(() => _isSubmitted = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A120D),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left_rounded, color: Colors.white, size: 32),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("FEEDBACK_PORTAL",
            style: TextStyle(color: Colors.white24, fontSize: 10, fontFamily: 'monospace', letterSpacing: 2)),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 600),
            child: _isSubmitted ? _buildSuccessState() : _buildFormState(),
          ),
          if (_isSubmitted) const IgnorePointer(child: ConfettiOverlay()),
        ],
      ),
    );
  }

  Widget _buildFormState() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeroHeader(),
          const SizedBox(height: 32),
          _buildSectionTitle("RATE YOUR SUPPORT EXPERIENCE"),
          const SizedBox(height: 16),
          _buildResponsiveEmojiSelector(), // Updated for responsiveness
          const SizedBox(height: 32),
          _buildSectionTitle("RESPONSE SPEED"),
          Slider(
            value: _responseSpeed,
            min: 1, max: 5,
            divisions: 4,
            activeColor: const Color(0xFF2ECC71),
            onChanged: (v) => setState(() => _responseSpeed = v),
          ),
          const SizedBox(height: 24),
          _buildSectionTitle("WAS YOUR ISSUE RESOLVED?"),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(_resolved ? "YES_PROTOCOL_SOLVED" : "NO_STILL_PENDING",
                style: const TextStyle(color: Colors.white70, fontSize: 13, fontFamily: 'monospace')),
            value: _resolved,
            activeColor: const Color(0xFF2ECC71),
            onChanged: (v) => setState(() => _resolved = v),
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSectionTitle("TELL US MORE"),
              Text("${_charLimit - _feedbackController.text.length} CHRS",
                  style: const TextStyle(color: Colors.white24, fontSize: 10, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 16),
          _buildGlassInput(),
          const SizedBox(height: 40),
          _buildSubmitButton(),
        ],
      ),
    );
  }

  // --- RESPONSIVE EMOJI SECTION ---
  Widget _buildResponsiveEmojiSelector() {
    return Center(
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 12, // Horizontal space between chips
        runSpacing: 12, // Vertical space between lines
        children: List.generate(_ratings.length, (index) {
          bool isSelected = _selectedRating == index;
          Color accent = _ratings[index]["color"];
          return GestureDetector(
            onTap: () {
              HapticFeedback.selectionClick(); //
              setState(() => _selectedRating = index);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isSelected ? accent.withValues(alpha: 0.15) : Colors.white.withValues(alpha: 0.03), //
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: isSelected ? accent : Colors.transparent, width: 2),
                boxShadow: isSelected ? [BoxShadow(color: accent.withValues(alpha: 0.3), blurRadius: 15)] : [],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(_ratings[index]["emoji"], style: const TextStyle(fontSize: 24)),
                  const SizedBox(height: 4),
                  Text(_ratings[index]["label"],
                      style: TextStyle(color: isSelected ? Colors.white : Colors.white24, fontSize: 10, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildHeroHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF1B4D3E), Color(0xFF0F291E)]),
        borderRadius: BorderRadius.circular(32),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("How did we do?", style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text("Protocol improvement active.", style: TextStyle(color: Colors.white60, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(title, style: const TextStyle(color: Color(0xFF2ECC71), fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1.2));
  }

  Widget _buildGlassInput() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05), //
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: TextField(
        controller: _feedbackController,
        maxLines: 4,
        maxLength: _charLimit,
        style: const TextStyle(color: Colors.white, fontSize: 14),
        onChanged: (v) => setState(() {}),
        decoration: const InputDecoration(hintText: "Terminal input...", hintStyle: TextStyle(color: Colors.white24), border: InputBorder.none, counterText: ""),
      ),
    );
  }

  Widget _buildSuccessState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.verified_user_rounded, color: Color(0xFF2ECC71), size: 100),
          SizedBox(height: 24),
          Text("FEEDBACK_LOGGED", style: TextStyle(color: Color(0xFF2ECC71), fontSize: 20, letterSpacing: 3, fontFamily: 'monospace')),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: FloatingActionButton.extended(
        onPressed: _submitFeedback,
        backgroundColor: const Color(0xFF2ECC71),
        label: const Text("EXECUTE_SEND", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        icon: const Icon(Icons.send_rounded, color: Colors.black),
      ),
    );
  }
}

// --- CONFETTI UX EFFECT ---
class ConfettiOverlay extends StatefulWidget {
  const ConfettiOverlay({super.key});
  @override
  State<ConfettiOverlay> createState() => _ConfettiOverlayState();
}

class _ConfettiOverlayState extends State<ConfettiOverlay> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Particle> _particles = List.generate(40, (i) => Particle());

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 3))..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => CustomPaint(
        painter: ConfettiPainter(_particles, _controller.value),
        size: Size.infinite,
      ),
    );
  }
}

class Particle {
  double x = math.Random().nextDouble();
  double y = math.Random().nextDouble();
  Color color = [const Color(0xFF2ECC71), Colors.cyanAccent, Colors.white][math.Random().nextInt(3)];
}

class ConfettiPainter extends CustomPainter {
  final List<Particle> particles;
  final double progress;
  ConfettiPainter(this.particles, this.progress);
  @override
  void paint(Canvas canvas, Size size) {
    for (var p in particles) {
      final paint = Paint()..color = p.color.withValues(alpha: 1 - progress); //
      canvas.drawCircle(Offset(p.x * size.width, (p.y + progress) * size.height % size.height), 2, paint);
    }
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}