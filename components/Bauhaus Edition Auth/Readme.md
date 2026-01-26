# 📐 Bauhaus Movement Auth Suite

A strictly responsive (Mobile & Tablet) authentication system inspired by the Bauhaus art movement. This suite features geometric transitions, bold typography, and a "Join the Movement" design philosophy.

## 🛠️ Project Structure
Ensure your `lib` folder contains the following four files for the system to function correctly:

1.  **`auth_styles.dart`**: The core design system. Contains the `AnimatedGeometricBackground` with **Overflow Protection (ClipRect)** and shared geometric decorations.
2.  **`login_screen.dart`**: The entry gate. Features the "LOGIN" system access and routing to Signup/Forgot Password.
3.  **`signup_screen.dart`**: The "GET IN" registration page. Includes **Full Name**, **Verify Password**, and dual "See Password" visibility toggles.
4.  **`forgot_password_screen.dart`**: The recovery module with Solar Yellow accents and geometric consistency.

## 🚀 Implementation (main.dart)
```bash
pui-inject Bauhus Edition Auth
```
Replace the contents of your `lib/main.dart` with the code below to initialize the suite.

```dart
import 'package:flutter/material.dart';
import 'login_screen.dart'; // Directly loads Login after splash removal

void main() {
  runApp(const BauhausApp());
}

class BauhausApp extends StatelessWidget {
  const BauhausApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bauhaus Movement UI',
      debugShowCheckedModeBanner: false,
      
      // Global Theme Configuration
      theme: ThemeData(
        brightness: Brightness.light,
        fontFamily: 'Courier', // Matches the geometric retro-look
        primaryColor: const Color(0xFF0000FF), // Bauhaus Electric Blue
      ),

      // Entry Screen
      home: const LoginScreen(),
    );
  }
}