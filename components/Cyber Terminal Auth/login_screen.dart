import 'package:flutter/material.dart';
import 'terminal_styles.dart';
import 'signup_screen.dart';
import 'recovery_screen.dart';

class TerminalLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TerminalColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: size.width < 600 ? 20 : size.width * 0.25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTopBar(),
              const SizedBox(height: 30),
              const NeonGlitchText(text: "SYSTEM ACCESS", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold, fontFamily: 'Courier')),
              const NeonGlitchText(text: "REQUIRED", style: TextStyle(color: TerminalColors.terminalGreen, fontSize: 28, fontWeight: FontWeight.bold, fontFamily: 'Courier')),
              const SizedBox(height: 20),
              _buildAuthBox(context),
              const SizedBox(height: 20),
              _buildSocialLogins(),
              const SizedBox(height: 30),
              _buildFooter(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Icon(Icons.terminal, color: TerminalColors.terminalGreen, size: 18),
        const Icon(Icons.security, color: TerminalColors.terminalGreen, size: 18),
      ],
    );
  }

  Widget _buildAuthBox(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: TerminalStyles.boxDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("--- AUTH_SESSION_ACTIVE", style: TerminalStyles.textStyle.copyWith(color: Colors.redAccent, fontSize: 10)),
          const SizedBox(height: 15),
          _buildInput("IDENT_STRING", "user@system:~\$ ", "ENTER_USERNAME"),
          const SizedBox(height: 20),
          const TerminalPasswordField(label: "KEY_SEQUENCE", prefix: "password: ", hint: "••••••••"),
          const SizedBox(height: 25),
          _buildActionButton("EXECUTE_LOGIN ➔"),
        ],
      ),
    );
  }

  Widget _buildSocialLogins() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("EXTERNAL_AUTH_METHODS:", style: TerminalStyles.textStyle.copyWith(fontSize: 10, color: Colors.white54)),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _socialIcon(Icons.mail, "MAIL"),
            _socialIcon(Icons.g_mobiledata, "GOOGLE"),
            _socialIcon(Icons.code, "GITHUB"),
          ],
        ),
      ],
    );
  }

  Widget _socialIcon(IconData icon, String label) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(border: Border.all(color: TerminalColors.terminalGreen.withOpacity(0.2))),
        child: Column(
          children: [
            Icon(icon, color: TerminalColors.terminalGreen, size: 20),
            Text(label, style: TerminalStyles.textStyle.copyWith(fontSize: 8)),
          ],
        ),
      ),
    );
  }

  Widget _buildInput(String label, String prefix, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TerminalStyles.textStyle.copyWith(fontSize: 10, color: Colors.white38)),
        TextField(
          style: TerminalStyles.textStyle,
          decoration: InputDecoration(
            prefixText: prefix,
            hintText: hint,
            hintStyle: TerminalStyles.textStyle.copyWith(color: Colors.white38),
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: TerminalColors.terminalGreen.withOpacity(0.2))),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(String label) {
    return Container(
      width: double.infinity, height: 45, color: TerminalColors.terminalGreen,
      child: Center(child: Text(label, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => TerminalRecoverScreen())),
            child: Text("RECOVER_KEY", style: TerminalStyles.textStyle.copyWith(fontSize: 10))),
        TextButton(
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => TerminalSignupScreen())),
          child: Text("CREATE_NODE", style: TerminalStyles.textStyle.copyWith(fontSize: 10)),
        ),
      ],
    );
  }
}