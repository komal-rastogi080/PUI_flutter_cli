# Sidebar (PUI)

A responsive sidebar component for Flutter apps.
Supports desktop sidebar and mobile drawer variants.

---

## Installation

```bash
pui-inject sidebar


//Desktop Usage
Row(
  children: [
    Sidebar(
      name: 'LanreB',
      subtitle: '70 Events',
      avatar: AssetImage('assets/avatar.jpg'),
      selectedIndex: 0,
      darkMode: true,
      onItemSelected: (index) {},
      onSignOut: () {},
    ),
    Expanded(child: YourContent()),
  ],
);

//Mobile Usage
Scaffold(
  drawer: SidebarDrawer(
    selectedIndex: 0,
    darkMode: true,
    onItemSelected: (index) {},
    onSignOut: () {},
  ),
);
