import 'package:flutter/material.dart';
import 'auth_styles.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _obscurePass = true;
  bool _obscureVerify = true;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isTab = width > 600;

    return Scaffold(
      backgroundColor: BauhausColors.offWhite,
      body: Stack(
        children: [
          const AnimatedGeometricBackground(),
          Center(
            child: Container(
              width: isTab ? 450 : width,
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 60),
                    _squareBtn(Icons.arrow_back, () => Navigator.pop(context)),
                    const SizedBox(height: 30),
                    const Text("GET IN", style: TextStyle(fontSize: 60, fontWeight: FontWeight.w900, height: 0.9)),
                    const SizedBox(height: 10),
                    Container(height: 5, width: 80, color: BauhausColors.black),
                    const SizedBox(height: 30),
                    Hero(tag: 'auth_card', child: Material(type: MaterialType.transparency, child: _buildSignupForm())),
                    const SizedBox(height: 30),
                    _buildSocialBlocks(),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignupForm() => Container(
    padding: const EdgeInsets.all(20),
    decoration: BauhausDecorations.card(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label("FULL NAME"),
        TextField(decoration: BauhausDecorations.field("NAME SURNAME")),
        const SizedBox(height: 15),
        _label("EMAIL ADDRESS"),
        TextField(decoration: BauhausDecorations.field("NAME@DOMAIN.COM")),
        const SizedBox(height: 15),
        _label("PASSWORD"),
        TextField(
          obscureText: _obscurePass,
          decoration: BauhausDecorations.field("********", suffix: IconButton(
            icon: Icon(_obscurePass ? Icons.visibility : Icons.visibility_off, color: BauhausColors.black),
            onPressed: () => setState(() => _obscurePass = !_obscurePass),
          )),
        ),
        const SizedBox(height: 15),
        _label("VERIFY PASSWORD"),
        TextField(
          obscureText: _obscureVerify,
          decoration: BauhausDecorations.field("********", suffix: IconButton(
            icon: Icon(_obscureVerify ? Icons.visibility : Icons.visibility_off, color: BauhausColors.black),
            onPressed: () => setState(() => _obscureVerify = !_obscureVerify),
          )),
        ),
        const SizedBox(height: 30),
        Container(
          width: double.infinity, height: 60, color: BauhausColors.primaryBlue,
          child: const Center(child: Text("CREATE ACCOUNT", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
        ),
      ],
    ),
  );

  Widget _label(String t) => Padding(
    padding: const EdgeInsets.only(bottom: 5),
    child: Text(t, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10, letterSpacing: 1)),
  );

  Widget _buildSocialBlocks() => Row(
    children: [
      Expanded(child: _socialItem("GOOGLE", Icons.star)),
      const SizedBox(width: 15),
      Expanded(child: _socialItem("APPLE", Icons.apple)),
    ],
  );

  Widget _socialItem(String label, IconData icon) => Container(
    height: 55,
    decoration: BoxDecoration(border: Border.all(color: BauhausColors.black, width: 2)),
    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(icon, size: 16),
      const SizedBox(width: 8),
      Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
    ]),
  );

  Widget _squareBtn(IconData i, VoidCallback onTap) => GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(border: Border.all(color: BauhausColors.black, width: 2)),
      child: Icon(i, size: 20),
    ),
  );
}