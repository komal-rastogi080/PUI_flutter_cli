import 'package:flutter/material.dart';
import 'auth_styles.dart';
import 'auth_background.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _isObscured = true; //

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double hPadding = screenWidth > 600 ? screenWidth * 0.22 : 30.0;

    return Scaffold(
      body: AuthBackground(
        bgText: "SIGN\nUP.",
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: hPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              _buildPhaseIndicator(),
              const SizedBox(height: 120),
              const Text("EMAIL_ADDRESS", style: AuthStyles.labelStyle),
              const SizedBox(height: 8),
              const BlurredInputField(hint: "USER@DOMAIN.COM"),
              const SizedBox(height: 20),
              const Text("ACCESS_CODE", style: AuthStyles.labelStyle),
              const SizedBox(height: 8),
              BlurredInputField(
                hint: "CHOOSE PASSWORD", isPassword: true, isObscured: _isObscured, //
                onToggle: () => setState(() => _isObscured = !_isObscured), //
              ),
              const SizedBox(height: 20),
              const Text("VERIFY_CODE", style: AuthStyles.labelStyle),
              const SizedBox(height: 8),
              BlurredInputField(
                hint: "RE-ENTER PASSWORD", isPassword: true, isObscured: _isObscured,
                onToggle: () => setState(() => _isObscured = !_isObscured),
              ),
              const SizedBox(height: 40),
              _buildMainButton("INITIALIZE_IDENTITY"),
              const SizedBox(height: 25),
              _buildReturnBox(context),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPhaseIndicator() {
    return Row(
      children: [
        Container(width: 48, height: 4, color: AuthColors.neonYellow),
        const SizedBox(width: 4),
        Container(width: 8, height: 4, color: AuthColors.neonYellow.withOpacity(0.3)),
        const SizedBox(width: 4),
        const Text("PHASE_02: REGISTRATION", style: AuthStyles.labelStyle),
      ],
    );
  }

  Widget _buildReturnBox(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        width: double.infinity, height: 50,
        decoration: BoxDecoration(border: Border.all(color: AuthColors.neonYellow.withOpacity(0.5), width: 1.5)),
        child: const Center(child: Text("RETURN_TO_LOGIN", style: TextStyle(color: AuthColors.neonYellow, fontWeight: FontWeight.bold, fontSize: 11, letterSpacing: 2))),
      ),
    );
  }

  Widget _buildMainButton(String label) {
    return Container(
      width: double.infinity, height: 60,
      decoration: BoxDecoration(color: AuthColors.neonYellow, borderRadius: BorderRadius.circular(4),
          boxShadow: [BoxShadow(color: AuthColors.neonYellow.withOpacity(0.3), blurRadius: 15)]),
      child: Center(child: Text(label, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w900))),
    );
  }
}