import 'package:flutter/material.dart';
import 'terminal_styles.dart';

class TerminalSignupScreen extends StatelessWidget {
  const TerminalSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isMobile = size.width < 600;

    return Scaffold(
      backgroundColor: TerminalColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          // Responsive padding: uses tablet/mobile constraints
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 20 : size.width * 0.25,
            vertical: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTopBar(context),
              const SizedBox(height: 30),
              const NeonGlitchText(
                text: "INITIALIZE",
                style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold, fontFamily: 'Courier'),
              ),
              const NeonGlitchText(
                text: "NEW_NODE",
                style: TextStyle(color: TerminalColors.terminalGreen, fontSize: 28, fontWeight: FontWeight.bold, fontFamily: 'Courier'),
              ),
              const SizedBox(height: 25),
              _buildSignupBox(context),
              const SizedBox(height: 30),
              _buildConsoleLogs(),
              const SizedBox(height: 20),
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
          icon: const Icon(Icons.arrow_back_ios, color: TerminalColors.terminalGreen, size: 16),
          onPressed: () => Navigator.pop(context),
        ),
        Text("NODE_CREATION_WIZARD_V1.2", style: TerminalStyles.textStyle.copyWith(fontSize: 10)),
        const Icon(Icons.settings_input_component, color: TerminalColors.terminalGreen, size: 18),
      ],
    );
  }

  Widget _buildSignupBox(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: TerminalStyles.boxDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("--- PROTOCOL: IDENTITY_ALLOCATION",
              style: TerminalStyles.textStyle.copyWith(color: Colors.blueAccent, fontSize: 10)),
          const SizedBox(height: 20),
          _buildField("ASSIGN_UID", "id:~\$ ", "USERNAME"),
          const SizedBox(height: 20),
          _buildField("COMMS_CHANNEL", "mail: ", "EMAIL_ADDRESS"),
          const SizedBox(height: 20),
          const TerminalPasswordField(label: "ACCESS_KEY", prefix: "key: ", hint: "PASSWORD"),
          const SizedBox(height: 20),
          const TerminalPasswordField(label: "VERIFY_KEY", prefix: "verify: ", hint: "CONFIRM_PASSWORD"),
          const SizedBox(height: 30),
          _buildActionButton("CREATE_IDENTITY ➔"),
        ],
      ),
    );
  }

  Widget _buildConsoleLogs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("CREATION_LOGS:", style: TerminalStyles.textStyle.copyWith(fontSize: 10, color: Colors.white54)),
        const SizedBox(height: 10),
        _logLine("VALIDATING_UID_AVAILABILITY...", "SCANNING"),
        _logLine("ENCRYPTING_ACCESS_KEY...", "SHA-256"),
        _logLine("ALLOCATING_NODE_SPACE...", "PENDING"),
      ],
    );
  }

  Widget _logLine(String task, String result) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("> $task", style: TerminalStyles.textStyle.copyWith(fontSize: 9, color: Colors.white24)),
          Text("[$result]", style: TerminalStyles.textStyle.copyWith(fontSize: 9, color: TerminalColors.terminalGreen)),
        ],
      ),
    );
  }

  Widget _buildField(String label, String prefix, String hint) {
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
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: TerminalColors.terminalGreen.withOpacity(0.2))
              ),
            ),
          ),
        ]
    );
  }

  Widget _buildActionButton(String label) {
    return Container(
        width: double.infinity,
        height: 45,
        color: TerminalColors.terminalGreen,
        child: Center(
            child: Text(label, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold))
        )
    );
  }
}