import 'package:flutter/material.dart';

class DynamicTheme {
  
  ThemeData _themeLight = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.light,
    ),
  );

  ThemeData _themeDark = ThemeData(
    useMaterial3: false,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.dark,
    ),
  );

  
  ThemeData get appTheme => _themeLight;
  ThemeData get appThemeDark => _themeDark;

  set mainColor(Color color) {
    // 1. Собираем светлую тему
    _themeLight = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: color,
        brightness: Brightness.light,
      ),
    );

    _themeDark = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: color,
        brightness: Brightness.dark,
      ), 
    );
  }
}