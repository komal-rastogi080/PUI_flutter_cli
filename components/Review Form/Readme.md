# PUI Interactive Review Form & Settings Toolkit 🚀

A premium, highly responsive, and feature-rich toolkit for Flutter. This repository contains a production-ready **Review Form** and a **Settings Screen** featuring a modern Glassmorphism aesthetic, interactive state management, and an adaptive Desktop-to-Mobile layout.

---

## ✨ Features

* **Responsive Framing**: Automatically wraps the UI in a centered "Phone Container" ($375 \times 812$) on Desktop/Web while remaining full-screen on Mobile and Tablet.
* **Zero-Overflow Design**: Utilizes `Wrap` widgets and `MainAxisSize.min` logic to ensure zero layout overflows on small devices.
* **Interactive Review Components**:
    * **Haptic Star Rating**: Custom star system with physical feedback on tap.
    * **Multi-Select Tags**: Logic-driven selection for feedback categories.
    * **Dynamic Image Picker**: Supports picking and previewing up to 3 photos with delete capability.
* **Modern Aesthetics**: 
    * **Glassmorphism**: Frosted glass effects using `BackdropFilter`.
    * **Sliver Headers**: Native-feel headers with optimized horizontal spacing.

---

## 🛠️ Project Setup

### 1. Inject the component
```bash
pui-inject Review Form
```
### 2. Dependencies
Add the following to your `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  image_picker: ^1.0.7
  ```

### 3. Platform Configuration
Android (AndroidManifest.xml):

XML
<uses-permission android:name="android:permission.READ_EXTERNAL_STORAGE"/>
<uses-permission android:name="android:permission.READ_MEDIA_IMAGES"/>
iOS (Info.plist):

XML
<key>NSPhotoLibraryUsageDescription</key>
<string>We need access to your gallery to upload review photos.</string>
 
## 💻 Code Implementation
```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'review_form.dart'; 

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
      title: 'PUI Review Form',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const ResponsiveFrame(),
    );
  }
}

class ResponsiveFrame extends StatelessWidget {
  const ResponsiveFrame({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            return Center(
              child: Container(
                width: 375,
                height: 812,
                margin: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 30)],
                  border: Border.all(color: Colors.white, width: 8),
                ),
                child: const ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: ReviewForm(),
                ),
              ),
            );
          }
          return const ReviewForm();
        },
      ),
    );
  }
}