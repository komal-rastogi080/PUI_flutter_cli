# ⚡ Cyber-Pill Floating Navigation Bar

A modern, "detached" floating navigation bar designed for dark-mode apps. It features a glowing neon aesthetic, a high-impact Floating Action Button (FAB), and smooth state-driven animations.

## ✨ Features
* **Floating Design:** A sleek pill-shaped bar that sits above the content.
* **Animated FAB:** Interactive scale-down and rotation effects on tap.
* **Neon Glow:** Real-time shadow rendering for that "Cyberpunk" look.
* **Smart Navigation:** Dynamic active state tracking with icon-specific glow.

---

## 🚀 Usage in main.dart

To integrate this into your project, wrap your `MaterialApp` around it. Because this component uses `extendBody: true`, your background content will flow beautifully behind the navigation bar.

```dart
import 'package:flutter/material.dart';
import 'cyber_footer.dart'; // Import your component file

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black, // Recommended for the glow effect
      ),
      home: const AnimatedCyberFooter(),
    );
  }
}