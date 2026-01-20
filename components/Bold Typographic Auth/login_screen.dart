import 'package:flutter/material.dart';
import 'auth_styles.dart';
import 'auth_background.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isObscured = true; //

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double hPadding = screenWidth > 600 ? screenWidth * 0.22 : 30.0;

    return Scaffold(
      body: AuthBackground(
        bgText: "LOG\nIN.",
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
              const SizedBox(height: 25),
              const Text("PASSWORD", style: AuthStyles.labelStyle),
              const SizedBox(height: 8),
              BlurredInputField(
                hint: "********", isPassword: true, isObscured: _isObscured, //
                onToggle: () => setState(() => _isObscured = !_isObscured), //
              ),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => const ForgotPasswordModal(),
                    );
                  },
                  child: const Text(
                      "LOST_CREDENTIALS?",
                      style: TextStyle(
                          color: AuthColors.lightGrey,
                          fontSize: 10,
                          decoration: TextDecoration.underline
                      )
                  ),
                ),
              ),
              const SizedBox(height: 35),
              _buildMainButton("ENTER_SYSTEM"),
              const SizedBox(height: 40),
              _buildCreateIdentityBox(context),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildPhaseIndicator() {
    return Row(
      children: [
        Container(width: 40, height: 4, color: AuthColors.neonYellow),
        const SizedBox(width: 4),
        Container(width: 8, height: 4, color: AuthColors.neonYellow.withOpacity(0.3)),
        const SizedBox(width: 4),
        Container(width: 8, height: 4, color: AuthColors.neonYellow.withOpacity(0.3)),
        const SizedBox(width: 8),
        const Text("PHASE_01: ACCESS", style: AuthStyles.labelStyle),
      ],
    );
  }

  Widget _buildCreateIdentityBox(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SignupScreen())),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white.withOpacity(0.03), border: Border.all(color: Colors.white10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("NEW_USER?", style: TextStyle(color: AuthColors.lightGrey, fontSize: 9, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text("CREATE_NEW_IDENTITY", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13, letterSpacing: 1)),
              ],
            ),
            const Icon(Icons.chevron_right, color: AuthColors.neonYellow),
          ],
        ),
      ),
    );
  }

  Widget _buildMainButton(String label) {
    return Container(
      width: double.infinity, height: 60,
      decoration: BoxDecoration(color: AuthColors.neonYellow, borderRadius: BorderRadius.circular(4)),
      child: Center(child: Text(label, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w900, letterSpacing: 1.5))),
    );
  }
}