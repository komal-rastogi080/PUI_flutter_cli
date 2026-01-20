import 'dart:ui';
import 'package:flutter/material.dart';
import 'auth_styles.dart';

class AuthBackground extends StatelessWidget {
  final String bgText;
  final Widget child;

  const AuthBackground({super.key, required this.bgText, required this.child});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dynamicFontSize = screenWidth > 600 ? 220 : 160;

    return Stack(
      children: [
        Container(color: AuthColors.background),
        Positioned(
          left: -15, top: 140,
          child: Opacity(
            opacity: 0.35, // Dimmed background
            child: Text(
              bgText,
              style: TextStyle(
                color: AuthColors.neonYellow,
                fontSize: dynamicFontSize,
                fontWeight: FontWeight.w900,
                height: 0.85,
                letterSpacing: -8,
              ),
            ),
          ),
        ),
        SafeArea(child: child),
      ],
    );
  }
}

class BlurredInputField extends StatelessWidget {
  final String hint;
  final bool isPassword;
  final bool isObscured;
  final VoidCallback? onToggle;

  const BlurredInputField({
    super.key, required this.hint, this.isPassword = false,
    this.isObscured = false, this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Frosted effect
        child: Container(
          decoration: AuthStyles.glassDecoration,
          child: TextField(
            obscureText: isPassword ? isObscured : false,
            style: const TextStyle(color: Colors.white, fontFamily: 'monospace'),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.white.withOpacity(0.2), fontSize: 13),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              border: InputBorder.none,
              suffixIcon: isPassword
                  ? IconButton(
                icon: Icon(isObscured ? Icons.visibility : Icons.visibility_off,
                    color: AuthColors.neonYellow, size: 20),
                onPressed: onToggle,
              ) : null,
            ),
          ),
        ),
      ),
    );
  }
}
class ForgotPasswordModal extends StatelessWidget {
  const ForgotPasswordModal({super.key});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8), // Glassmorphism backdrop
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AuthColors.background.withOpacity(0.9),
            border: Border.all(color: Colors.white10),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPhaseIndicator(),
              const SizedBox(height: 24),
              const Text("RECOVER_ACCESS", style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -1
              )),
              const SizedBox(height: 8),
              const Text(
                "ENTER REGISTERED COMMS_CHANNEL TO RECEIVE RESET_KEY.",
                style: TextStyle(color: AuthColors.lightGrey, fontSize: 10, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              const Text("COMMS_CHANNEL", style: AuthStyles.labelStyle),
              const SizedBox(height: 8),
              const BlurredInputField(hint: "USER@DOMAIN.COM"),
              const SizedBox(height: 32),
              _buildModalButton("SEND_RECOVERY_KEY"),
              const SizedBox(height: 16),
              _buildCancelButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPhaseIndicator() {
    return Row(
      children: [
        Container(width: 20, height: 4, color: AuthColors.neonYellow),
        const SizedBox(width: 4),
        const Text("PHASE_03: RECOVERY", style: AuthStyles.labelStyle),
      ],
    );
  }

  Widget _buildModalButton(String label) {
    return Container(
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(
        color: AuthColors.neonYellow,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Text(label, style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w900,
            fontSize: 12
        )),
      ),
    );
  }

  Widget _buildCancelButton(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: const Center(
        child: Text("ABORT_RECOVERY", style: TextStyle(
            color: AuthColors.lightGrey,
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5
        )),
      ),
    );
  }
}