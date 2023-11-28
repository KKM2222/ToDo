import 'package:flutter/material.dart';

void main() {
  runApp(const DrawerApp());
}

class DrawerApp extends StatelessWidget {
  const DrawerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Scaffold(
        body: Center(
          child: DrawerMenu(),
        ),
      ),
    );
  }
}

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.pinkAccent,
            ),
            child: Text(
              'Settings',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: Text('다크 모드'),
            trailing: Switch(
              value: MyApp.themeNotifier.value == ThemeMode.dark,
              onChanged: (value) {
                setState(() {
                  _toggleTheme(value);
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  void _toggleTheme(bool isDarkMode) {
    MyApp.themeNotifier.value = isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }
}

class MyApp extends StatelessWidget {
  static final ValueNotifier<ThemeMode> themeNotifier =
  ValueNotifier(ThemeMode.light);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeNotifier.value,
      home: const Scaffold(
        body: Center(
          child: DrawerMenu(),
        ),
      ),
    );
  }
}
