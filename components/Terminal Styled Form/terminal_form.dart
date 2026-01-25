import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class TerminalForm extends StatefulWidget {
  const TerminalForm({super.key});

  @override
  State<TerminalForm> createState() => _TerminalFormState();
}

class _TerminalFormState extends State<TerminalForm> {
  String _selectedDept = "BILLING";
  final List<XFile> _dumpFiles = [];
  final ImagePicker _picker = ImagePicker();

  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _logController = TextEditingController();

  final Color _neon = const Color(0xFF33FF33);
  final Color _bg = const Color(0xFF0D0D0D);
  final Color _dim = const Color(0xFF1A331A);

  @override
  void dispose() {
    _subjectController.dispose();
    _logController.dispose();
    super.dispose();
  }

  Future<void> _pickDump() async {
    HapticFeedback.mediumImpact();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) setState(() => _dumpFiles.add(image));
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isDesktop = constraints.maxWidth > 700;

        Widget content = Scaffold(
          backgroundColor: _bg,
          body: _buildMainContent(),
        );

        if (isDesktop) {
          return Container(
            color: const Color(0xFF121212), // Outer desk color
            child: Center(
              child: Container(
                width: 375,
                height: 812,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(color: _dim, width: 4),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 40)],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(36),
                  child: content,
                ),
              ),
            ),
          );
        }
        return content;
      },
    );
  }

  Widget _buildMainContent() {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        _buildStatusBar(),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              GlitchTitle(text: "INITIALIZE_SUPPORT_PROTOCOL", color: _neon),
              const SizedBox(height: 10),
              _buildMetadata(),
              const SizedBox(height: 30),

              _buildLabel("/ SELECT_DEPARTMENT /"),
              _buildDeptGrid(),

              const SizedBox(height: 30),
              _buildLabel("/ INPUT_SUBJECT /"),
              _buildValidatedInput(
                controller: _subjectController,
                hint: "SHORT_DESC_OF_ISSUE",
                maxChars: 50,
              ),

              const SizedBox(height: 30),
              _buildLabel("/ MESSAGE_LOG /"),
              _buildValidatedInput(
                controller: _logController,
                hint: "DESCRIBE_ERROR_LOG_IN_DETAIL...",
                maxLines: 5,
                maxChars: 500,
              ),

              const SizedBox(height: 30),
              _buildLabel("/ UPLOAD_CORE_DUMP /"),
              _buildImagePicker(),

              const SizedBox(height: 40),
              _buildExecutionBlock(),
              const SizedBox(height: 30),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusBar() => SliverAppBar(
    backgroundColor: _bg,
    pinned: true,
    centerTitle: false,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("SYS.ADM.V2.0", style: TextStyle(color: _neon, fontSize: 12, fontFamily: 'monospace')),
        const Text("[ STATUS: SECURE ]", style: TextStyle(color: Colors.red, fontSize: 10, fontFamily: 'monospace')),
      ],
    ),
  );

  Widget _buildMetadata() => Text(
    "USER: GUEST_${DateTime.now().millisecond}\nPROTO: SUPPORT_V2",
    style: TextStyle(color: _neon.withOpacity(0.4), fontSize: 11, fontFamily: 'monospace', height: 1.5),
  );

  Widget _buildLabel(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Text(text, style: TextStyle(color: _neon, fontSize: 13, fontFamily: 'monospace')),
  );

  Widget _buildDeptGrid() {
    final options = ["BILLING", "TECH", "ACCESS", "INFO"];
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 3.5,
      ),
      itemCount: options.length,
      itemBuilder: (context, i) {
        bool active = _selectedDept == options[i];
        return GestureDetector(
          onTap: () {
            HapticFeedback.selectionClick();
            setState(() => _selectedDept = options[i]);
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: active ? _neon : Colors.transparent,
              border: Border.all(color: _neon),
            ),
            child: Text(
              "[ ${options[i]} ]",
              style: TextStyle(
                color: active ? Colors.black : _neon.withOpacity(0.6),
                fontSize: 12,
                fontWeight: FontWeight.bold,
                fontFamily: 'monospace',
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildValidatedInput({
    required TextEditingController controller,
    required String hint,
    required int maxChars,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(border: Border.all(color: _dim)),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: TextField(
            controller: controller,
            maxLines: maxLines,
            maxLength: maxChars,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            onChanged: (v) => setState(() {}),
            style: TextStyle(color: _neon, fontFamily: 'monospace', fontSize: 14),
            decoration: InputDecoration(
              counterText: "",
              hintText: hint,
              hintStyle: TextStyle(color: _dim),
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "${controller.text.length} / $maxChars CHAR_LIMIT",
          style: TextStyle(color: _dim, fontSize: 10, fontFamily: 'monospace'),
        ),
      ],
    );
  }

  Widget _buildImagePicker() {
    return Row(
      children: [
        GestureDetector(
          onTap: _pickDump,
          child: Container(
            width: 75, height: 75,
            decoration: BoxDecoration(border: Border.all(color: _dim)),
            child: Icon(Icons.add_a_photo_outlined, color: _dim, size: 20),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: SizedBox(
            height: 75,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _dumpFiles.length,
              itemBuilder: (context, i) => Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 12),
                    width: 75, height: 75,
                    decoration: BoxDecoration(border: Border.all(color: _neon)),
                    child: Image.file(File(_dumpFiles[i].path), fit: BoxFit.cover),
                  ),
                  Positioned(
                    right: 15, top: 5,
                    child: GestureDetector(
                      onTap: () => setState(() => _dumpFiles.removeAt(i)),
                      child: Container(color: Colors.black, child: Icon(Icons.close, color: _neon, size: 14)),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildExecutionBlock() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "C:\\CMD\\SUPPORT> EXECUTE_$_selectedDept.EXE",
          style: TextStyle(color: _neon, fontFamily: 'monospace', fontSize: 12),
        ),
        const SizedBox(height: 15),
        SizedBox(
          width: double.infinity,
          height: 55,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: _neon, width: 2),
              shape: const RoundedRectangleBorder(),
            ),
            onPressed: () {
              HapticFeedback.heavyImpact();
              _showExecutionDialog();
            },
            child: Text(
              "[ EXECUTE ]",
              style: TextStyle(color: _neon, fontSize: 16, fontFamily: 'monospace', fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  void _showExecutionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: _bg,
        shape: Border.all(color: _neon),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("PROTOCOL_ACCEPTED", style: TextStyle(color: _neon, fontFamily: 'monospace', fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text("REPORT_ID: ${Random().nextInt(99999)}", style: TextStyle(color: _neon, fontSize: 12, fontFamily: 'monospace')),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("[ CLOSE ]", style: TextStyle(color: _neon, fontFamily: 'monospace')),
            )
          ],
        ),
      ),
    );
  }
}

// --- GLITCH TITLE WIDGET ---
class GlitchTitle extends StatefulWidget {
  final String text;
  final Color color;

  const GlitchTitle({super.key, required this.text, required this.color});

  @override
  State<GlitchTitle> createState() => _GlitchTitleState();
}

class _GlitchTitleState extends State<GlitchTitle> {
  Timer? _timer;
  double _xOffset = 0;
  double _isGlitching = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 400), (timer) {
      if (Random().nextInt(10) > 7) {
        setState(() {
          _isGlitching = 1;
          _xOffset = (Random().nextDouble() * 6) - 3;
        });
        Future.delayed(const Duration(milliseconds: 60), () {
          if (mounted) setState(() => _isGlitching = 0);
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (_isGlitching == 1)
          Transform.translate(
            offset: Offset(_xOffset, 0),
            child: Text(
              "> ${widget.text}",
              style: TextStyle(color: Colors.red.withOpacity(0.5), fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'monospace'),
            ),
          ),
        Text(
          "> ${widget.text}",
          style: TextStyle(
            color: widget.color,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'monospace',
            shadows: [Shadow(color: widget.color.withOpacity(0.5), blurRadius: 10)],
          ),
        ),
      ],
    );
  }
}