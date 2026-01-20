import 'package:flutter/material.dart';
import 'terminal_styles.dart';

class TerminalRecoverScreen extends StatelessWidget {
  const TerminalRecoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isMobile = size.width < 600;

    return Scaffold(
      backgroundColor: TerminalColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 20 : size.width * 0.25,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTopBar(context),
              const SizedBox(height: 30),
              const NeonGlitchText(
                text: "KEY_RECOVERY",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Courier',
                ),
              ),
              const NeonGlitchText(
                text: "SEQUENCE",
                style: TextStyle(
                  color: TerminalColors.terminalGreen,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Courier',
                ),
              ),
              const SizedBox(height: 20),
              _buildRecoverBox(context),
              const SizedBox(height: 30),
              _buildStatusLogs(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: TerminalColors.terminalGreen, size: 16),
        ),
        Text("RECOVERY_PROTOCOL_INIT", style: TerminalStyles.textStyle.copyWith(fontSize: 10)),
        const Icon(Icons.history, color: TerminalColors.terminalGreen, size: 18),
      ],
    );
  }

  Widget _buildRecoverBox(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: TerminalStyles.boxDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("--- INITIATING_FALLBACK_AUTH",
              style: TerminalStyles.textStyle.copyWith(color: Colors.orangeAccent, fontSize: 10)),
          const SizedBox(height: 15),
          Text(
            "Enter the registered ID string to receive a one-time bypass sequence.",
            style: TerminalStyles.textStyle.copyWith(fontSize: 12, color: Colors.white70),
          ),
          const SizedBox(height: 25),
          _buildInput("REGISTERED_EMAIL", "sys_root@id: ", "ENTER_EMAIL_OR_ID"),
          const SizedBox(height: 30),
          _buildActionButton("GENERATE_BYPASS_LINK ➔"),
        ],
      ),
    );
  }

  Widget _buildStatusLogs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("RECOVERY_LOGS:", style: TerminalStyles.textStyle.copyWith(fontSize: 10, color: Colors.white54)),
        const SizedBox(height: 10),
        _logEntry("CHECKING_NODE_STATUS...", "OK"),
        _logEntry("DB_ENCRYPTION_LAYER...", "ACTIVE"),
        _logEntry("READY_FOR_INPUT...", "WAITING"),
      ],
    );
  }

  Widget _logEntry(String action, String status) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("> $action", style: TerminalStyles.textStyle.copyWith(fontSize: 9, color: Colors.white24)),
          Text("[$status]", style: TerminalStyles.textStyle.copyWith(fontSize: 9, color: TerminalColors.terminalGreen)),
        ],
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
            hintStyle: TerminalStyles.textStyle.copyWith(color: Colors.white12),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: TerminalColors.terminalGreen.withOpacity(0.2)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(String label) {
    return Container(
      width: double.infinity,
      height: 45,
      color: TerminalColors.terminalGreen,
      child: Center(
        child: Text(label, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
    );
  }
}