import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TerminalCheckout extends StatefulWidget {
  const TerminalCheckout({super.key});

  @override
  State<TerminalCheckout> createState() => _TerminalCheckoutState();
}

class _TerminalCheckoutState extends State<TerminalCheckout> with SingleTickerProviderStateMixin {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cardController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  bool _isCvvVisible = false;
  final Color _neonGreen = const Color(0xFF33FF33);
  final Color _darkBg = const Color(0xFF0A0A0A);

  @override
  void dispose() {
    _nameController.dispose();
    _cardController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  // --- TERMINAL PROCESSING LOGIC ---
  Future<void> _processPayment() async {
    HapticFeedback.heavyImpact();

    // Show Terminal Log Dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => _TerminalLogDialog(neonGreen: _neonGreen, darkBg: _darkBg),
    );

    // Simulate Network Latency
    await Future.delayed(const Duration(seconds: 4));

    if (mounted) {
      Navigator.pop(context); // Close Log Dialog
      _showSuccessScreen();
    }
  }

  void _showSuccessScreen() {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, anim1, anim2) => Scaffold(
        backgroundColor: _darkBg,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle_outline, color: _neonGreen, size: 80),
              const SizedBox(height: 20),
              Text("TRANSACTION_SUCCESS",
                  style: TextStyle(color: _neonGreen, fontFamily: 'monospace', fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text("AUTH_CODE: ${math.Random().nextInt(999999)}",
                  style: const TextStyle(color: Colors.white30, fontFamily: 'monospace')),
              const SizedBox(height: 40),
              OutlinedButton(
                style: OutlinedButton.styleFrom(side: BorderSide(color: _neonGreen)),
                onPressed: () => Navigator.pop(context),
                child: Text("RETURN_TO_DASHBOARD", style: TextStyle(color: _neonGreen, fontFamily: 'monospace')),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _darkBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("TERMINAL_CHECKOUT_V2",
            style: TextStyle(color: Colors.white, fontFamily: 'monospace', fontSize: 16)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildCreditCardPreview(),
            const SizedBox(height: 30),
            _buildTerminalInput("CARDHOLDER NAME", _nameController, hint: "e.g. ALEXANDER MORGAN"),
            _buildTerminalInput("CARD NUMBER", _cardController, hint: "0000 0000 0000 0000", isNumber: true,
                formatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(16), CardNumberFormatter()]),
            Row(
              children: [
                Expanded(child: GestureDetector(onTap: () => _selectExpiryDate(context),
                    child: AbsorbPointer(child: _buildTerminalInput("EXPIRY DATE", _expiryController, hint: "MM/YY", suffixIcon: Icons.calendar_month)))),
                const SizedBox(width: 15),
                Expanded(child: _buildTerminalInput("CVV", _cvvController, hint: "***", isPassword: !_isCvvVisible, isNumber: true,
                    formatters: [LengthLimitingTextInputFormatter(3)],
                    suffixIcon: _isCvvVisible ? Icons.visibility : Icons.visibility_off,
                    onSuffixTap: () => setState(() => _isCvvVisible = !_isCvvVisible))),
              ],
            ),
            const SizedBox(height: 40),
            _buildConfirmButton(),
          ],
        ),
      ),
    );
  }

  // --- UI BUILDERS ---
  Widget _buildCreditCardPreview() {
    return ListenableBuilder(
        listenable: Listenable.merge([_nameController, _cardController, _expiryController]),
        builder: (context, _) {
          return Container(
            width: double.infinity,
            height: 200,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [_neonGreen.withValues(alpha: 0.2), Colors.black],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border.all(color: _neonGreen.withValues(alpha: 0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Icon(Icons.memory, color: Colors.amber, size: 40), Icon(Icons.contactless, color: Color(0xFF33FF33), size: 24)]),
                Text(_cardController.text.isEmpty ? "XXXX XXXX XXXX XXXX" : _cardController.text, style: const TextStyle(color: Colors.white, fontSize: 20, letterSpacing: 2, fontFamily: 'monospace')),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text("CARD HOLDER", style: TextStyle(color: Colors.white38, fontSize: 10)), Text(_nameController.text.toUpperCase(), style: const TextStyle(color: Colors.white, fontSize: 14))]),
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text("EXPIRES", style: TextStyle(color: Colors.white38, fontSize: 10)), Text(_expiryController.text.isEmpty ? "MM/YY" : _expiryController.text, style: const TextStyle(color: Colors.white, fontSize: 14))]),
                ]),
              ],
            ),
          );
        }
    );
  }

  Widget _buildTerminalInput(String label, TextEditingController controller, {String? hint, bool isPassword = false, bool isNumber = false, List<TextInputFormatter>? formatters, IconData? suffixIcon, VoidCallback? onSuffixTap}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label, style: TextStyle(color: _neonGreen, fontSize: 11, fontFamily: 'monospace')),
        const SizedBox(height: 8),
        TextField(controller: controller, obscureText: isPassword, keyboardType: isNumber ? TextInputType.number : TextInputType.text, inputFormatters: formatters, style: const TextStyle(color: Colors.white, fontFamily: 'monospace'),
            decoration: InputDecoration(hintText: hint, hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.1)), suffixIcon: suffixIcon != null ? IconButton(icon: Icon(suffixIcon, color: _neonGreen, size: 20), onPressed: onSuffixTap) : null, filled: true, fillColor: Colors.white.withValues(alpha: 0.05), enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: _neonGreen.withValues(alpha: 0.1))), focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: _neonGreen)))),
      ]),
    );
  }

  Widget _buildConfirmButton() {
    return SizedBox(
      width: double.infinity, height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: _neonGreen, foregroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
        onPressed: _processPayment,
        child: const Text("EXECUTE_PAYMENT", style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5)),
      ),
    );
  }

  Future<void> _selectExpiryDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime(2035),
        builder: (context, child) => Theme(data: Theme.of(context).copyWith(colorScheme: ColorScheme.dark(primary: _neonGreen, onPrimary: Colors.black, surface: _darkBg, onSurface: Colors.white)), child: child!));
    if (picked != null) setState(() => _expiryController.text = "${picked.month.toString().padLeft(2, '0')}/${picked.year.toString().substring(2)}");
  }
}

// --- TERMINAL LOG DIALOG ---
class _TerminalLogDialog extends StatefulWidget {
  final Color neonGreen;
  final Color darkBg;
  const _TerminalLogDialog({required this.neonGreen, required this.darkBg});

  @override
  State<_TerminalLogDialog> createState() => _TerminalLogDialogState();
}

class _TerminalLogDialogState extends State<_TerminalLogDialog> {
  final List<String> _logs = [];
  final List<String> _rawLines = [
    "INITIALIZING_SECURE_TUNNEL...",
    "HANDSHAKE_PROTOCOL: SYN_SENT",
    "ENCRYPTING_PAYLOAD: AES_256",
    "ROUTING_THROUGH_GATEWAY_09...",
    "SENDING_DATA_PACKETS...",
    "AWAITING_BANK_RESPONSE...",
    "VALIDATING_SIGNATURE...",
    "TRANSACTION_FINALIZING..."
  ];

  @override
  void initState() {
    super.initState();
    _startLogSequence();
  }

  void _startLogSequence() async {
    for (var line in _rawLines) {
      if (!mounted) return;
      setState(() => _logs.add("> $line"));
      await Future.delayed(const Duration(milliseconds: 450));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: widget.darkBg,
      shape: RoundedRectangleBorder(side: BorderSide(color: widget.neonGreen), borderRadius: BorderRadius.circular(10)),
      title: Text("PROCESSING_TRANSACTION", style: TextStyle(color: widget.neonGreen, fontSize: 14, fontFamily: 'monospace')),
      content: SizedBox(
        width: double.maxFinite,
        height: 200,
        child: ListView.builder(
          itemCount: _logs.length,
          itemBuilder: (context, i) => Text(_logs[i], style: TextStyle(color: widget.neonGreen.withValues(alpha: 0.7), fontSize: 12, fontFamily: 'monospace')),
        ),
      ),
    );
  }
}

class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text.replaceAll(" ", "");
    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) buffer.write(' ');
    }
    var string = buffer.toString();
    return newValue.copyWith(text: string, selection: TextSelection.collapsed(offset: string.length));
  }
}