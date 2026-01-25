# PUI Support Feedback Portal 🌲

A high-fidelity, interactive, and mobile-responsive feedback component designed for the **PUI (Pro UI)** toolkit. This portal features a deep forest-green aesthetic, glassmorphism effects, and terminal-inspired typography.

---

## ✨ Features

* **Responsive Emoji Grid**: Implements a `Wrap` widget instead of a standard `Row` to ensure the sentiment selection section is fully mobile-responsive and avoids horizontal overflows.
* **Sentiment-Specific Containers**: Each emoji is housed in an `AnimatedContainer` that glows with a unique color based on the sentiment when selected.
* **Modern API Standards**: Fully compliant with the latest Flutter standards, utilizing the `.withValues(alpha: ...)` API for all transparency logic to prevent precision loss and deprecation warnings.
* **UX & Visual Feedback**:
    * **Confetti Celebration**: Uses a `CustomPainter` to trigger a particle overlay upon successful submission.
    * **Tactile Haptics**: Integrated `HapticFeedback` for selection clicks and heavy-impact execution commands.
    * **Character Constraints**: A strictly enforced 140-character limit with a real-time counter.
* **Navigation**: Includes a prominent `chevron_left_rounded` icon in the AppBar for standard mobile navigation patterns.

---

## 🚀 Getting Started

### 1. Requirements
* **Flutter SDK**: >= 3.22.0 (for `.withValues`)

### 2. Inject the component
```bash
pui-inject Feedback Form
```

## 💻 Code Implementation

### **main.dart**
This entry point handles the app configuration and provides a responsive frame for desktop testing.

```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Feedback Form/form.dart'; 

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PUI Feedback Portal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      home: const ResponsiveFrame(),
    );
  }
}

class ResponsiveFrame extends StatelessWidget {
  const ResponsiveFrame({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050A07),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 900) {
            return Center(
              child: Container(
                width: 375,
                height: 812,
                margin: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 30)],
                  border: Border.all(color: Colors.white10, width: 4),
                ),
                child: const ClipRRect(
                  borderRadius: BorderRadius.circular(36),
                  child: SupportFeedbackForm(),
                ),
              ),
            );
          }
          return const SupportFeedbackForm();
        },
      ),
    );
  }
}