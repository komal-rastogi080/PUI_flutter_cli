# PUI Cyber-Terminal Auth System 🔐

A high-performance, brute-force aesthetic authentication system built with Flutter. This module features a "Terminal-Core" design language, utilizing neon accents, blurred glassmorphism inputs, and phase-based progress indicators.

---

## ✨ Features

* **Phase-Based UI**: Utilizes a "Phase Indicator" to signal system access levels (e.g., `PHASE_01: ACCESS`).
* **Blurred Input Engine**: Custom `BlurredInputField` components provide a frosted-glass effect with integrated password visibility toggles.
* **Identity Management**: Seamless transitions between Login and "Identity Creation" (Sign-up) via custom route handling.
* **Responsive Access**: Adaptive padding logic ensures the terminal remains centered and readable on both mobile devices and wide-screen desktop displays.
* **Credential Recovery**: Built-in modal trigger for `LOST_CREDENTIALS` recovery protocols.

---

## 🚀 Getting Started

### 1. Requirements
* **Flutter SDK**: Any version supporting Flutter 3.x.
### 2. Inject the component
```bash
pui-inject Bold Typographic Auth
```

### 3. Implementation Entry Point (`main.dart`)
This code initializes the application and launches directly into the Login phase.

```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Bold Typographic Auth/login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Ensure system overlays match the dark terminal aesthetic
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));
  runApp(const CyberAuthApp());
}

class CyberAuthApp extends StatelessWidget {
  const CyberAuthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PUI Cyber Terminal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0A0A0A),
        fontFamily: 'monospace', 
      ),
      home: const LoginScreen(),
    );
  }
}