import 'package:flutter/material.dart';
import 'brutalist_style.dart';

class BrutalistSignupScreen extends StatelessWidget {
  const BrutalistSignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isWide = size.width > 900; // Breakpoint for Desktop/Tablet

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: StarkColors.ink),
        title: const Text("RETURN_TO_BASE", style: TextStyle(color: StarkColors.ink, fontSize: 12, fontWeight: FontWeight.bold)),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: Container(color: StarkColors.ink, height: 2.5),
        ),
      ),
      body: Row(
        children: [
          // Left Side Decor (Visible only on wide screens)
          if (isWide)
            Expanded(
              flex: 1,
              child: Container(
                color: StarkColors.ink,
                child: Center(
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: Text(
                      "NEW_IDENTITY_SEQUENCE",
                      style: TextStyle(
                        color: StarkColors.neonAccent,
                        fontSize: 60,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -5,
                      ),
                    ),
                  ),
                ),
              ),
            ),

          // Main Form Area
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: isWide ? size.width * 0.1 : 24,
                vertical: 40,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProgressDots(),
                  const SizedBox(height: 20),
                  const Text("CREATE\nNODE", style: BrutalistStyles.headerStyle),
                  const SizedBox(height: 10),
                  Text("ESTABLISH YOUR CREDENTIALS WITHIN THE STARK_OS ECOSYSTEM.",
                      style: TextStyle(color: StarkColors.greyText, fontSize: 11, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 40),

                  const BrutalistInput(label: "Assign UID", hint: "STARK_USER_88"),
                  const SizedBox(height: 20),
                  const BrutalistInput(label: "Comms Channel", hint: "USER@STARK.SYSTEMS"),
                  const SizedBox(height: 20),
                  const BrutalistPasswordField(label: "Access Code", hint: "********"),
                  const SizedBox(height: 20),
                  const BrutalistPasswordField(label: "Verify Code", hint: "********"),

                  const SizedBox(height: 40),
                  _buildSubmitButton(),
                  const SizedBox(height: 20),
                  _buildTermsNotice(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressDots() {
    return Row(
      children: [
        Container(width: 40, height: 10, color: StarkColors.ink),
        const SizedBox(width: 5),
        Container(width: 10, height: 10, color: StarkColors.neonAccent),
        const SizedBox(width: 5),
        Container(width: 10, height: 10, color: StarkColors.ink.withOpacity(0.2)),
      ],
    );
  }

  // Widget _buildSubmitButton() {
  //   return MouseRegion(
  //     cursor: SystemMouseCursors.click,
  //     child: GestureDetector(
  //       onTap: () {},
  //       child: Container(
  //         width: double.infinity,
  //         height: 75,
  //         decoration: BoxDecoration(
  //           color: StarkColors.ink,
  //           border: BrutalistStyles.border,
  //           boxShadow: const [
  //             BoxShadow(color: StarkColors.neonAccent, offset: Offset(6, 6)),
  //           ],
  //         ),
  //         _build
  //       ),
  //     ),
  //   );
  // }

  Widget _buildSubmitButton() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          // Add your signup logic here
        },
        child: Container(
          width: double.infinity,
          height: 75,
          decoration: BoxDecoration(
            color: StarkColors.neonAccent, // Yellow background for high visibility
            border: BrutalistStyles.border,
            boxShadow: const [
              BoxShadow(color: StarkColors.ink, offset: Offset(6, 6)),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "INITIALIZE_ACCOUNT",
                style: TextStyle(
                  color: StarkColors.ink,
                  fontSize: 18,
                  fontWeight: FontWeight.bold, // Extra bold for Brutalist feel
                  letterSpacing: 0.8,
                ),
              ),
              SizedBox(width: 15),
              // "Hardware/Terminal" style icon
              Icon(
                Icons.settings_input_component_outlined,
                color: StarkColors.ink,
                size: 28,
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildTermsNotice() {
    return Center(
      child: Text(
        "BY INITIALIZING, YOU AGREE TO DATA_ENCRYPTION_PROTOCOLS.",
        textAlign: TextAlign.center,
        style: TextStyle(color: StarkColors.greyText, fontSize: 9, fontWeight: FontWeight.bold),
      ),
    );
  }
}