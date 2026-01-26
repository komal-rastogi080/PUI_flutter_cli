# Cyber Authentication Suite V3.0 - Recover Access Component

A high-fidelity, Stark-themed Flutter authentication component featuring glassmorphism inputs, flowing text animations, and responsive tablet/mobile layouts.

## 🚀 Integration Guide

To use the **CyberRecoverScreen** in your project, follow these steps to configure your `main.dart`.

### 1. Inject the component
`pui-inject 3D Molded Auth`

### 2. Modify `main.dart`
Update your `MaterialApp` to point to the `LoginScreen`. Ensure you set a dark background theme to match the component's aesthetic.

```dart
import 'package:flutter/material.dart';
import 'login_screen.dart'; // Import your component file

void main() {
  runApp(const CyberAuthApp());
}

class CyberAuthApp extends StatelessWidget {
  const CyberAuthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cyber Auth V3.0',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF1A1A1A),
        fontFamily: 'Monospace', // Recommended for the Cyber aesthetic
      ),
      home: const LoginScreen(),
    );
  }
}