# 📟 Neon Terminal Auth v5.0

A high-performance, responsive **Terminal-themed** authentication component for Flutter. This UI provides a "Matrix/Cyberpunk" aesthetic with built-in animations and secure input handling.

---

## 🚀 Key Features
* **CRT Glitch Header**: Animated titles that simulate hardware interference.
* **Typewriter Logging**: Dynamic "system logs" that type out character-by-character.
* **Secure Input**: Custom password fields with a "See Password" toggle icon.
* **Fully Responsive**: Works across Mobile, Tablet, and Web layouts.
* **Modular Styling**: Centralized theme management for easy branding.

---

## 🛠️ Quick Start

### 1. File Placement
Copy the following files into your `lib/` directory:
* `terminal_style.dart` — *Contains theme data and animation logic.*
* `terminal_login_screen.dart` — *The login UI.*
* `terminal_signup_screen.dart` — *The signup/registration UI.*

### 2. Update `main.dart`
Configure your app to start with the Terminal interface:

```dart
import 'package:flutter/material.dart';
import 'terminal_login_screen.dart';

void main() => runApp(const TerminalApp());

class TerminalApp extends StatelessWidget {
  const TerminalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark),
      home: TerminalLoginScreen(),
    );
  }
}