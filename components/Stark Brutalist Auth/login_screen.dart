import 'package:flutter/material.dart';
import 'brutalist_style.dart';
import 'signup_screen.dart';
import 'forgot_screen.dart';

class BrutalistLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isMobile = size.width < 600;

    return Scaffold(
      backgroundColor: StarkColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false, // This removes the back button
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: Container(color: StarkColors.ink, height: 2.5),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 24 : size.width * 0.3,
            vertical: 40
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBadge(),
            const Text("ACCESS\nPORTAL", style: BrutalistStyles.headerStyle),
            const SizedBox(height: 40),
            const BrutalistInput(label: "Username / Email", hint: "USER_ID_01"),
            const SizedBox(height: 24),
            const BrutalistPasswordField(
              label: "Password",
              hint: "********",
            ),
            const SizedBox(height: 12),
            // Inside your Column in BrutalistLoginScreen
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BrutalistForgotScreen()),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: StarkColors.ink,
                  boxShadow: const [
                    BoxShadow(color: StarkColors.neonAccent, offset: Offset(6, 6)),
                  ],// Light yellow highlight
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      "FORGOT_CREDENTIALS [?]",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(Icons.help_outline, size: 14, color: StarkColors.ink),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            _buildLoginButton(),
            const SizedBox(height: 40),
            _buildSectionHeader("NEW_USER_REGISTRATION"),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text("CREATE ACCOUNT", style: TextStyle(fontWeight: FontWeight.bold, color: StarkColors.ink)),
              trailing: const Icon(Icons.chevron_right, color: StarkColors.ink),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => BrutalistSignupScreen())),
            ),
            const SizedBox(height: 20),
            _buildSectionHeader("ALTERNATIVE_METHODS"),
            const SizedBox(height: 16),
            _buildSocialRow(),
            const SizedBox(height: 60),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      margin: const EdgeInsets.only(bottom: 12),
      color: StarkColors.ink,
      child: const Text("IDENTITY_VERIFICATION",
          style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildLoginButton() {
    return Container(
      width: double.infinity,
      height: 70,
      decoration: BoxDecoration(
          color: StarkColors.neonAccent,
          boxShadow: const [
            BoxShadow(color: StarkColors.ink, offset: Offset(6, 6)),
          ],
          border: BrutalistStyles.border),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("LOGIN", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black)),
          SizedBox(width: 20),
          Icon(Icons.arrow_forward, size: 32, color: StarkColors.ink),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      children: [
        Container(width: 8, height: 8, color: StarkColors.ink),
        const SizedBox(width: 8),
        Text(title, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 12, color: StarkColors.greyText)),
      ],
    );
  }

  Widget _buildSocialRow() {
    return Row(
      children: [
        _socialBtn(Icons.g_mobiledata),
        const SizedBox(width: 12),
        _socialBtn(Icons.code),
        const SizedBox(width: 12),
        _socialBtn(Icons.email),
      ],
    );
  }

  Widget _socialBtn(IconData icon) {
    return Expanded(
      child: Container(
        height: 60,
        decoration: BoxDecoration(border: BrutalistStyles.border),
        child: Icon(icon, size: 30, color: Colors.black),
      ),
    );
  }

  Widget _buildFooter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text("STARK_SYSTEMS_OS\nCORE_VER_4.4.2\nSESSION_ENCRYPTED",
            style: TextStyle(color: StarkColors.greyText, fontSize: 10, height: 1.2)),
      ],
    );
  }
}