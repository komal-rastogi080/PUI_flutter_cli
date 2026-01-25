# 🟦 Sliding Indicator Navigation Bar

A modern, high-performance Flutter navigation bar featuring a top-aligned sliding indicator. This component is designed for dark-themed applications, offering a clean aesthetic with smooth motion and subtle glowing accents.

## ✨ Features
* **Sliding Top Indicator:** A smooth `AnimatedPositioned` bar that glides between tabs.
* **Icon Glow Effect:** Active icons feature a soft, circular glow to enhance focus.
* **Optimized for Dark Mode:** Deep navy and charcoal color palette tailored for modern UI.
* **Responsive Layout:** Automatically calculates spacing based on screen width.

---

## 🛠️ Installation

```bash
pui-inject Sliding Indicator Footer
```

## 🚀 Usage in main.dart

To use this component effectively, ensure your `MaterialApp` is configured with a dark theme to match the component's styling.

```dart
import 'package:flutter/material.dart';
import 'sliding_indicator_nav.dart'; // Import your file

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sliding Nav UI',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0A0C10),
      ),
      // Call the component as the home screen
      home: const SlidingIndicatorNav(),
    );
  }
}