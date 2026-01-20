import 'package:flutter/material.dart';
import 'custom_widgets.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Detect screen width for responsiveness
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isTablet = screenWidth > 600;

    return Scaffold(
      backgroundColor: const Color(0xFF222222), // Same background as Login
      body: Center(
        child: Container(
          // Responsiveness: Restrict width on tablets to keep fields "classy"
          width: isTablet ? 500 : double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  _roundNavIcon(Icons.arrow_back_ios_new, () => Navigator.pop(context)),
                  const SizedBox(height: 30),
                  const FlowingText(
                    text: "Join the Club",
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4
                    ),
                    baseColor: Colors.white,
                    highlightColor: Color(0xFFFF5F41), // Matches the Register button
                  ),
                  const Text("Create your 3D molded identity.",
                      style: TextStyle(color: Colors.white24, fontSize: 14)),
                  const SizedBox(height: 40),
                  const CyberField(
                      label: "Full Name",
                      hint: "John Doe",
                      icon: Icons.person_outline),
                  const SizedBox(height: 20),
                  const CyberField(
                      label: "Email Address",
                      hint: "email@example.com",
                      icon: Icons.email_outlined),
                  const SizedBox(height: 20),
                  const CyberField(
                      label: "Password",
                      hint: "********",
                      icon: Icons.lock_outline,
                      isPassword: true),
                  const SizedBox(height: 20),
                  const CyberField(
                      label: "Confirm Password",
                      hint: "********",
                      icon: Icons.lock_reset_outlined,
                      isPassword: true),
                  const SizedBox(height: 40),
                  CyberButton(
                      text: "Register",
                      color: const Color(0xFFFF5F41),
                      onTap: () {
                        // Registration logic
                      }),
                  const SizedBox(height: 30),
                  const Center(
                      child: Text("OR SIGN UP WITH",
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.white10,
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold))),
                  const SizedBox(height: 25),
                  _socialRow(),
                  const SizedBox(height: 40),
                  Center(
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: RichText(
                          text: const TextSpan(children: [
                            TextSpan(
                                text: "Already have an account? ",
                                style: TextStyle(color: Colors.white24, fontSize: 13)),
                            TextSpan(
                                text: "Log In",
                                style: TextStyle(
                                    color: Color(0xFFFF5F41),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13)),
                          ])),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _roundNavIcon(IconData icon, VoidCallback onTap) => GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
          color: Color(0xFF2A2A2A),
          shape: BoxShape.circle),
      child: Icon(icon, color: Colors.white38, size: 16),
    ),
  );

  Widget _socialRow() => Row(mainAxisAlignment: MainAxisAlignment.center, children: [
    _socialTile(Icons.apple),
    const SizedBox(width: 15),
    _socialTile(Icons.g_mobiledata),
    const SizedBox(width: 15),
    _socialTile(Icons.hub_outlined),
  ]);

  Widget _socialTile(IconData icon) => Container(
    height: 55,
    width: 65,
    decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(3, 3))
        ]),
    child: Icon(icon, color: Colors.white30, size: 28),
  );
}