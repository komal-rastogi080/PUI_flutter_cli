# PUI Terminal Checkout Toolkit 📟

A premium, highly responsive, and feature-rich terminal-styled checkout component built with Flutter. This component is part of the **PUI (Pro UI)** toolkit, designed to provide a high-fidelity "hacker" aesthetic combined with modern interactive state management.

---

## ✨ Features

* **Real-time Card Reflecting**: The top credit card preview uses `Listenable.merge` to instantly reflect changes from Name, Card Number, and Expiry controllers.
* **Modern Flutter Standards**: Fully compliant with the latest Flutter API, using `.withValues()` for color transparency instead of the deprecated `.withOpacity()`.
* **Interactive Terminal Logs**: Features a simulated "Processing" sequence that prints network logs line-by-line in a custom dialog upon execution.
* **Advanced UX Controls**:
    * **Calendar Integration**: A dark-themed `showDatePicker` for selecting Expiry Dates.
    * **Privacy Toggle**: An eye-icon toggle to mask or reveal the CVV field.
    * **Smart Formatting**: Automated 4-4-4-4 spacing for card numbers via `TextInputFormatter`.
* **Adaptive Layout**: Includes a `LayoutBuilder` frame to maintain a mobile aspect ratio on Desktop/Web environments.

---

## 🚀 Getting Started

### 1. Inject the component
`pui-inject Card Checkout Form`
### 2. Project Setup
Add the `image_picker` dependency to your `pubspec.yaml` (required if using the related PUI Support forms):

```yaml
dependencies:
  image_picker: ^1.0.7
  ```
### 3. Main Entry Point (main.dart)
This file handles the application setup and ensures the terminal aesthetic is maintained across the system UI.

```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'terminal_checkout.dart'; 

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Ensure the status bar matches the terminal aesthetic
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
      title: 'PUI Terminal Checkout',
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
      backgroundColor: const Color(0xFF121212),
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
                  child: TerminalCheckout(),
                ),
              ),
            );
          }
          return const TerminalCheckout();
        },
      ),
    );
  }
}
```

🛠️ Configuration
Android
Update android/app/src/main/AndroidManifest.xml for hardware interactions:

XML
<uses-permission android:name="android:permission.VIBRATE"/>
iOS
Update ios/Runner/Info.plist for secure input handling:

XML
<key>NSFaceIDUsageDescription</key>
<string>Used for secure checkout authentication.</string>