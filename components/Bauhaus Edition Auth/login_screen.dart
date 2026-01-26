import 'package:flutter/material.dart';
import 'auth_styles.dart';
import 'signup_screen.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    // Responsive Logic: Locked to 450px on tablets, fluid on mobile
    final double width = MediaQuery.of(context).size.width;
    final bool isTablet = width > 600;

    return Scaffold(
      backgroundColor: BauhausColors.offWhite,
      body: Stack(
        children: [
          const AnimatedGeometricBackground(),
          Center(
            child: Container(
              width: isTablet ? 450 : width,
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Text("BAUHAUS EDITION", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
                    ),
                    const SizedBox(height: 60),
                    const Text("LOGIN", style: TextStyle(fontSize: 60, fontWeight: FontWeight.w900, letterSpacing: -2)),
                    const SizedBox(height: 40),
                    Hero(tag: 'auth_card', child: Material(type: MaterialType.transparency, child: _buildLoginForm())),
                    const SizedBox(height: 40),
                    _buildFooter(context),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginForm() => Container(
    padding: const EdgeInsets.all(20),
    decoration: BauhausDecorations.card(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label("EMAIL ADDRESS"),
        TextField(decoration: BauhausDecorations.field("NAME@DOMAIN.COM")),
        const SizedBox(height: 20),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          _label("PASSWORD"),
          GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => const ForgotPasswordScreen())),
            child: const Text("FORGOT?", style: TextStyle(color: BauhausColors.primaryBlue, fontWeight: FontWeight.bold, fontSize: 10)),
          ),
        ]),
        TextField(
          obscureText: _obscure,
          decoration: BauhausDecorations.field("********", suffix: IconButton(
            icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off, color: BauhausColors.black),
            onPressed: () => setState(() => _obscure = !_obscure),
          )),
        ),
        const SizedBox(height: 30),
        _actionBtn(),
      ],
    ),
  );

  Widget _label(String t) => Text(t, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11));

  Widget _actionBtn() => Container(
    width: double.infinity, height: 60, color: BauhausColors.primaryBlue,
    child: const Center(child: Text("LOGIN", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 2))),
  );

  Widget _buildFooter(BuildContext context) => GestureDetector(
    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => const SignupScreen())),
    child: Column(
      children: [
        const Text("NOT A MEMBER?", style: TextStyle(color: Colors.black38, fontSize: 12, fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        Container(
          decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.orange, width: 2))),
          child: const Text("JOIN THE MOVEMENT", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 14)),
        ),
      ],
    ),
  );
}