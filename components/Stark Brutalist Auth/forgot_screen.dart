import 'package:flutter/material.dart';
import 'brutalist_style.dart';

class BrutalistForgotScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isMobile = size.width < 600;

    return Scaffold(
      backgroundColor: StarkColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: StarkColors.ink),
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
            _buildBadge("IDENTITY_RECOVERY"),
            const Text("RECOVER\nACCESS", style: BrutalistStyles.headerStyle),
            const SizedBox(height: 16),
            const Text(
              "ENTER YOUR REGISTERED EMAIL TO RECEIVE A RECOVERY CODE.",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, height: 1.4),
            ),
            const SizedBox(height: 40),
            const BrutalistInput(label: "Email Address", hint: "USER@STARK_SYSTEMS.COM"),
            const SizedBox(height: 32),
            _buildActionButton("SEND_CODE"),
            const SizedBox(height: 40),
            _buildSectionHeader("HELP_RESOURCES"),
            const SizedBox(height: 12),
            _buildLinkItem("CONTACT_SYSTEM_ADMIN", Icons.support_agent),
            _buildLinkItem("SECURITY_PROTOCOL_FAQ", Icons.description),
            const SizedBox(height: 60),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildBadge(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      margin: const EdgeInsets.only(bottom: 12),
      color: StarkColors.ink,
      child: Text(label,
          style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildActionButton(String label) {
    return InkWell(
      onTap: () {
        // Handle recovery logic
      },
      child: Container(
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
            Text(label, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black)),
            const SizedBox(width: 20),
            const Icon(Icons.send, size: 28, color: StarkColors.ink),
          ],
        ),
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

  Widget _buildLinkItem(String title, IconData icon) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: StarkColors.ink),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: StarkColors.ink, fontSize: 14)),
      trailing: const Icon(Icons.open_in_new, size: 18, color: StarkColors.ink),
      onTap: () {},
    );
  }

  Widget _buildFooter() {
    return const Text(
      "STARK_SYSTEMS_OS\nRECOVERY_MODULE_V1\nENCRYPTED_CHANNEL_ACTIVE",
      style: TextStyle(color: StarkColors.greyText, fontSize: 10, height: 1.2),
    );
  }
}