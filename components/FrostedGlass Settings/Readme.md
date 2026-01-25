# PUI Glassmorphism Settings Component 🚀

A premium, highly customizable, and responsive Flutter Settings UI component. It features a modern **Glassmorphism** aesthetic, dynamic **Light/Dark mode** switching, and a **Desktop-to-Mobile** adaptive layout.

---

## ✨ Features

* **Glassmorphism UI**: Frosted glass effect using `BackdropFilter` and `ImageFilter`.
* **Adaptive Layout**: Automatically renders as a centered "iPhone" frame on Desktop/Web and as a full-screen app on Mobile/Tablet.
* **Interactive Fields**:
    * **Dynamic Profile**: Editable Name and Bio via modal bottom sheets.
    * **System Maintenance**: Working "Clear Cache" simulation that updates a storage progress indicator.
    * **Theme Toggle**: Fully functional Dark/Light mode transition within the component.
* **Native-feel Scrolling**: Uses `SliverAppBar` for a shrinking header effect with optimized horizontal spacing.
* **Responsive Gradients**: Backgrounds that shift based on the active theme.

---

## 📸 Component Structure



**`settings_screen.dart`**: The core reusable UI component.

---

## 🛠️ Installation & Setup

1.  Ensure you have Flutter installed on your machine.
2.  Inject the component:

    ```bash
    pui-inject FrostedGlass Settings
    ```
3.  Replace the contents of `lib/main.dart` with the code provided below.

---

## 💻 Source Code

### **1. main.dart**
This file handles the high-level app configuration and system UI overlays.

```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'settings_screen.dart'; 

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PUI Settings Component',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      home: const SettingsScreen(),
    );
  }
}