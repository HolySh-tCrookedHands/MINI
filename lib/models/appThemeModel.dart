import 'package:flutter/material.dart';

// Модель для Режима Темы (Светлая / Темная)
enum AppThemeMode {
  light('Светлая', ThemeMode.light),
  dark('Темная', ThemeMode.dark);

  final String label;
  final ThemeMode mode;
  const AppThemeMode(this.label, this.mode);
}

// Модель для Основного Цвета (Seed Color)
enum AppSeedColor {
  purple('Фиолетовый', Colors.deepPurple),
  indigo('Индиго', Colors.indigo),
  blue('Синий', Colors.blue),
  teal('Бирюзовый', Colors.teal),
  green('Зеленый', Colors.green),
  amber('Янтарный', Colors.amber),
  orange('Оранжевый', Colors.orange),
  red('Красный', Colors.red);

  final String name;
  final Color color;
  const AppSeedColor(this.name, this.color);
}

