# 🏁 Stark Systems: Brutalist Auth UI v2.0

A high-impact, high-contrast **Brutalist** authentication suite for Flutter. This component features a stark black-and-white aesthetic with neon accents, designed for modern web and mobile applications that require a bold visual identity.

---

## 🚀 Key Features
* **Adaptive Layout**: Smart responsiveness that switches to a split-screen design on Desktop/Tablets.
* **Neon Accents**: High-visibility yellow shadows and progress indicators.
* **Secure Input**: State-managed password fields with an integrated visibility toggle.
* **Social Integration**: Ready-to-use slots for Google, GitHub, and Mail sign-in methods.
* **Brutalist Aesthetic**: Heavy borders, bold typography, and a "raw" system feel.

---

## 🛠️ Installation Guide

### 1. Project Setup
Place the following files in your `lib/` directory:
* `brutalist_style.dart` — *Contains shared colors, typography, and reusable input widgets.*
* `brutalist_login_screen.dart` — *The primary login interface (Back button removed).*
* `brutalist_signup_screen.dart` — *The responsive registration interface.*

### 2. Configure `main.dart`
Initialize the app using the Stark Systems theme:

```dart
import 'package:flutter/material.dart';
import 'brutalist_login_screen.dart';

void main() => runApp(const StarkOS());

class StarkOS extends StatelessWidget {
  const StarkOS({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Courier', // Use a monospace font for the system look
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const BrutalistLoginScreen(),
    );
  }
}