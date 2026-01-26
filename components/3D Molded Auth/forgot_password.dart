import 'package:flutter/material.dart';
import 'custom_widgets.dart';

class CyberRecoverScreen extends StatelessWidget {
  const CyberRecoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Detect screen width for responsiveness exactly as requested
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isTablet = screenWidth > 600;

    // Cyan and Blue Accents
    const Color cyberCyan = Color(0xFF00E5FF);
    const Color returnBlue = Color(0xFF4D96FF);

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A), // Matching dark background
      body: SafeArea(
        child: Center(
          child: Container(
            // Responsiveness: Restrict width on tablets to keep fields from stretching
            width: isTablet ? 450 : screenWidth,
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back Button aligned within the same frame
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.03),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white10),
                      ),
                      child: const Icon(Icons.chevron_left, color: Colors.white30, size: 20),
                    ),
                  ),

                  const SizedBox(height: 40),

                  Center(
                    child: Column(
                      children: [
                        FlowingText(
                          text: "R E C O V E R",
                          highlightColor: cyberCyan,
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 5,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "PROTOCOL_INITIALIZED",
                          style: TextStyle(
                            color: Colors.white12,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 60),

                  // Your CyberField Component
                  const CyberField(
                    label: "Digital Identity",
                    hint: "user@domain.com",
                    icon: Icons.alternate_email_rounded,
                  ),

                  const SizedBox(height: 35),

                  // Your CyberButton Component
                  CyberButton(
                    text: "Request Reset Link",
                    color: cyberCyan.withOpacity(0.8),
                    onTap: () {
                      // Trigger recovery sequence
                    },
                  ),

                  const SizedBox(height: 50),

                  _buildStatusConsole(cyberCyan),

                  const SizedBox(height: 40),

                  // Terminate Link with Blue Accent
                  Center(
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: returnBlue.withOpacity(0.15)),
                        ),
                        child: Text(
                          "TERMINATE_AND_RETURN",
                          style: TextStyle(
                            color: returnBlue,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusConsole(Color accent) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: accent.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(width: 6, height: 6, decoration: BoxDecoration(color: accent, shape: BoxShape.circle)),
              const SizedBox(width: 8),
              Text("ENCRYPTION: ACTIVE", style: TextStyle(color: accent, fontSize: 9, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            "Instructions: Enter the email associated with your identity. A secure reset key will be transmitted to your terminal.",
            style: TextStyle(color: Colors.white24, fontSize: 10, height: 1.5),
          ),
        ],
      ),
    );
  }
}