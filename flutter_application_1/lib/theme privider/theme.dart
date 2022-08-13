import 'package:flutter/material.dart';

class Themeprovider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggletheme(bool ison) {
    themeMode = ison ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();

  }
}

class MyTheme {
  static final darktheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    colorScheme: const ColorScheme.dark(),
  );

  static final lighttheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(),
  );
}
