import 'package:flutter/material.dart';
import 'package:flutter_password_manager/ui/themes/light_theme.dart';
import '/ui/screens/dashboard_screen.dart';
import '../ui/themes/dark_theme.dart';

class PasswordManager extends StatefulWidget {
  const PasswordManager({super.key});

  @override
  State<PasswordManager> createState() => _PasswordManagerState();
}

class _PasswordManagerState extends State<PasswordManager> {
  ThemeMode _modoTema = ThemeMode.dark;

  void _alternarTema() {
    setState(() {
      _modoTema =
          _modoTema == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Password Manager",
      theme: lightThemeApp,
      darkTheme: darkThemeApp,
      themeMode: _modoTema,
      home: Dashboard(onTrocarTema: _alternarTema),
    );
  }
}
