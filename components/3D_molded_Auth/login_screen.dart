import 'package:flutter/material.dart';
import 'custom_widgets.dart';
import 'signup_screen.dart';
import 'forgot_password.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      backgroundColor: const Color(0xFF222222),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: isTablet ? 80 : 30),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _roundIcon(Icons.fingerprint, Colors.orange.shade800),
                    _roundIcon(Icons.help_outline, Colors.white10),
                  ],
                ),
                const SizedBox(height: 50),
                const FlowingText(
                  text: "A C C E S S",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 5,
                  ),
                  baseColor: Colors.white,
                  highlightColor: Colors.orange, // Matches the Authenticate button
                ),
                const Text("Enter your digital identity", style: TextStyle(color: Colors.white24, fontSize: 13)),
                const SizedBox(height: 50),
                const CyberField(label: "Identity", hint: "email@domain.com"),
                const SizedBox(height: 25),
                const CyberField(label: "Secret Key", hint: "********", isPassword: true),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const CyberRecoverScreen()),
                        );
                      },
                      child: const Text("Forgot Password?", style: TextStyle(color: Colors.white38, fontSize: 11, decoration: TextDecoration.underline, letterSpacing: 1.0))
                  ),
                ),
                const SizedBox(height: 30),
                CyberButton(text: "Authenticate", color: const Color(0xFFEF7D00), onTap: () {}),
                const SizedBox(height: 40),
                const Text("CONNECT", style: TextStyle(fontSize: 10, color: Colors.white10, letterSpacing: 2, fontWeight: FontWeight.bold)),
                const SizedBox(height: 25),
                _socialRow(),
                const SizedBox(height: 50),
                _footer(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _roundIcon(IconData icon, Color color) => Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 5, offset: const Offset(2, 2))]
    ),
    child: Icon(icon, color: color, size: 20),
  );

  Widget _socialRow() => Row(mainAxisAlignment: MainAxisAlignment.center, children: [
    _roundIcon(Icons.stop, Colors.white10),
    const SizedBox(width: 20),
    _roundIcon(Icons.g_mobiledata, Colors.white10),
    const SizedBox(width: 20),
    _roundIcon(Icons.vpn_key, Colors.white10),
  ]);

  Widget _footer(BuildContext context) => Row(mainAxisAlignment: MainAxisAlignment.center, children: [
    const Text("Don't have an account? ", style: TextStyle(color: Colors.white24, fontSize: 12)),
    GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SignupScreen())),
      child: const Text("Sign Up", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 12)),
    ),
  ]);
}