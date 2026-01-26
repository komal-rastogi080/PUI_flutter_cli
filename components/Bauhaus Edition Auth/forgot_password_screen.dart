import 'package:flutter/material.dart';
import 'auth_styles.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 60),
                    _buildTopBar(context),
                    const SizedBox(height: 40),
                    const Text("RECOVER\nACCESS",
                        style: TextStyle(fontSize: 48, fontWeight: FontWeight.w900, height: 0.9)),
                    const SizedBox(height: 10),
                    Container(height: 4, width: 60, color: BauhausColors.solarYellow),
                    const SizedBox(height: 40),
                    Hero(tag: 'auth_card', child: Material(type: MaterialType.transparency, child: _buildRecoveryForm())),
                    const SizedBox(height: 30),
                    _buildReturnLink(context),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(border: Border.all(color: BauhausColors.black, width: 2)),
            child: const Icon(Icons.close, size: 20)
        ),
      ),
      const Text("BAUHAUS EDITION", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10, letterSpacing: 1.5)),
    ],
  );

  Widget _buildRecoveryForm() => Container(
    padding: const EdgeInsets.all(20),
    decoration: BauhausDecorations.card(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("REGISTERED EMAIL", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
        const SizedBox(height: 8),
        TextField(decoration: BauhausDecorations.field("NAME@DOMAIN.COM")),
        const SizedBox(height: 30),
        Container(
          width: double.infinity,
          height: 60,
          color: BauhausColors.primaryRed, // Red for urgent recovery action
          child: const Center(
              child: Text("RESET PASSWORD", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
          ),
        ),
      ],
    ),
  );

  Widget _buildReturnLink(BuildContext context) => Center(
    child: GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: BauhausColors.black, width: 2))),
        child: const Text("TERMINATE_AND_RETURN",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 1.5)),
      ),
    ),
  );
}