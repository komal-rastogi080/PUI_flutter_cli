
# PUI Sidebar & Navigation Drawer Toolkit 🚀

A high-fidelity, interactive, and theme-aware navigation system for Flutter. This toolkit provides a seamless transition between desktop-first **Sidebars** and mobile-first **Drawers**, ensuring your application remains responsive across all device types.

---

## ✨ Features

* **Adaptive Navigation**: Includes a fixed `Sidebar` for desktop/web and a `SidebarDrawer` for mobile/tablet.
* **Animated Transitions**: Uses `AnimatedContainer` to transition smoothly between expanded (270px) and collapsed (85px) states.
* **Theme Synchronization**: Integrated support for toggling between Light and Dark modes with real-time UI updates.
* **Interactive Design**:
    * **Hover Effects**: Desktop-optimized background highlighting using `MouseRegion`.
    * **Motion UI**: Uses `AnimatedSwitcher` to transition between text labels and icons during state changes.
* **Modern Flutter Standards**: Leverages `ThemeData` and `colorScheme` for consistent styling across light and dark modes.

---

## 🚀 Getting Started

### 1. Requirements
* **Flutter SDK**: Any version supporting Flutter 3.x.
### 2. Inject the component
```bash
pui-inject Basic Drawer
```

### 2. Implementation
To use this toolkit, integrate it into your main `Scaffold`. You can use a `LayoutBuilder` to toggle between the Sidebar and the Drawer based on the screen width.



```dart
Scaffold(
  key: _scaffoldKey,
  // The Drawer is triggered on mobile layouts
  drawer: SidebarDrawer(
    selectedIndex: _currentIndex,
    isDarkMode: _isDark,
    onItemSelected: (index) => setState(() => _currentIndex = index),
    onThemeToggle: _handleThemeToggle,
  ),
  body: Row(
    children: [
      // The Sidebar is displayed on larger screens
      if (MediaQuery.of(context).size.width > 600)
        Sidebar(
          isExpanded: _isSidebarExpanded,
          isDarkMode: _isDark,
          selectedIndex: _currentIndex,
          onItemSelected: (index) => setState(() => _currentIndex = index),
          onThemeToggle: _handleThemeToggle,
        ),
      Expanded(
        child: Center(child: Text("Current Page Index: $_currentIndex")),
      ),
    ],
  ),
);
