# PUI Terminal Support Protocol 📟

A retro-styled "Terminal" support form built with Flutter. Designed for the **PUI Toolkit**, this component combines 80s hardware aesthetics with modern interactivity and UX safety.

---

## 🛠 Features

- **Adaptive Desktop Framing**: Forces a centered 375x812 container on large screens to maintain the intended "Command Center" feel.
- **Glitch Engine**: Built-in `GlitchTitle` widget that triggers random horizontal shifts and chromatic aberration effects.
- **Input Guarding**: Real-time character counters for both Subject (50 chars) and Log (500 chars) fields.
- **Adaptive CLI**: The footer command line reacts dynamically to the user's Department selection (e.g., `EXECUTE_TECH.EXE`).
- **Hardware Simulation**: Uses `HapticFeedback` to mimic the tactile response of mechanical keyboards and old toggles.

---

## 🛠️ Project Setup

### 1. Inject the component
```bash
pui-inject Terminal Styled Form
```
### 2. Dependencies
Add the following to your `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  image_picker: ^1.0.7
  ```
Run "flutter pub get"
### 3. Platform Configuration
Android (AndroidManifest.xml):

XML
<uses-permission android:name="android:permission.READ_EXTERNAL_STORAGE"/>
<uses-permission android:name="android:permission.READ_MEDIA_IMAGES"/>
iOS (Info.plist):

XML
<key>NSPhotoLibraryUsageDescription</key>
<string>We need access to your gallery to upload review photos.</string>

---
```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Terminal Styled Form/terminal_form.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Makes the status bar transparent for a cleaner look
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PUI Review Component',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: const ResponsiveTester(),
    );
  }
}

class ResponsiveTester extends StatelessWidget {
  const ResponsiveTester({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0E0E0), // "Desk" background for Desktop
      body: LayoutBuilder(
        builder: (context, constraints) {
          // If the screen is wide (Desktop/Web), wrap in a phone frame
          if (constraints.maxWidth > 600) {
            return Center(
              child: Container(
                width: 375,
                height: 812,
                margin: const EdgeInsets.symmetric(vertical: 24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 30,
                      offset: const Offset(0, 10),
                    )
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: const TerminalForm(), // Calling your reusable component
                ),
              ),
            );
          }

          // On Mobile/Tablet, just show the form full screen
          return const TerminalForm();
        },
      ),
    );
  }
}
```
## 📄 License
Part of the PUI (Pro UI) Library.