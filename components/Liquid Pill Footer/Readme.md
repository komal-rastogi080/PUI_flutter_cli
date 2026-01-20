# 🌈 Dynamic Color Liquid Pill Navigation

A premium, responsive navigation bar for Flutter. The selection pill changes color dynamically as it slides, and the active label switches to a dark color for perfect contrast.

## ✨ Features
* **Dynamic Pill Coloring:** Every tab can have its own unique background color.
* **Auto-Contrast:** Text automatically turns **black** when selected to stay readable against the colored pill.
* **Smooth Liquid Motion:** Uses native `TabController` for high-performance sliding animations.
* **Responsive Design:** Automatically adapts to screen width and content length.

---

## 🚀 Quick Start

### 1. Create the File
Create a new file in your `lib/` directory named `dynamic_pill_nav.dart` and paste the component code into it.

### 2. Implementation in main.dart
Use the following simplified code to run the component:

```dart
import 'package:flutter/material.dart';
import 'dynamic_pill_nav.dart'; // Import your component file

void main() => runApp(const MaterialApp(
  debugShowCheckedModeBanner: false,
  home: DynamicColorPillNav(),
));