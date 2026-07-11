import 'package:flutter/material.dart';
import 'package:mini/models/appSecurityType.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mini/models/appThemeModel.dart';

class SettingsProvider extends ChangeNotifier {
  static const String _keyTheme = 'app_theme';
  static const String _keyColor = 'app_color';
  static const String _keyWallpaper = 'app_wallpaper';
  static const String _keyServerUrl = 'app_server_url';

  // Дефолтные значения
  AppThemeMode _theme = AppThemeMode.light;
  AppSeedColor _color = AppSeedColor.purple;
  String? _wallpaperPath;
  String _serverUrl = "";
  bool _useVpnTunnel = true;
  AppSecurityType _securityType = AppSecurityType.e2ee;


  // Геттеры для UI
  AppThemeMode get theme => _theme;
  AppSeedColor get color => _color;
  String? get wallpaperPath => _wallpaperPath;
  String get serverUrl => _serverUrl;
  bool get useVpnTunnel => _useVpnTunnel;
  AppSecurityType get securityType => _securityType;

  // Загрузка настроек из базы при запуске приложения
  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    // Загружаем тему
    final themeIndex = prefs.getInt(_keyTheme);
    if (themeIndex != null) _theme = AppThemeMode.values[themeIndex];

    // Загружаем цвет
    final colorIndex = prefs.getInt(_keyColor);
    if (colorIndex != null) _color = AppSeedColor.values[colorIndex];

    _useVpnTunnel = prefs.getBool('use_vpn') ?? true;
    final secIndex = prefs.getInt('security_type');
    if (secIndex != null) _securityType = AppSecurityType.values[secIndex];

    // Загружаем обои и урл
    _wallpaperPath = prefs.getString(_keyWallpaper);
    _serverUrl = prefs.getString(_keyServerUrl) ?? "";

    notifyListeners(); // Обновляем все экраны после загрузки данных
  }

  // Сеттеры с автосохранением в БД
  Future<void> setTheme(AppThemeMode newTheme) async {
    _theme = newTheme;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyTheme, newTheme.index);
  }

  Future<void> setColor(AppSeedColor newColor) async {
    _color = newColor;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyColor, newColor.index);
  }


  Future<void> setWallpaper(String? path) async {
    _wallpaperPath = path;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    if (path != null) {
      await prefs.setString(_keyWallpaper, path);
    } else {
      await prefs.remove(_keyWallpaper);
    }
  }

  Future<void> setServerUrl(String url) async {
    _serverUrl = url;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyServerUrl, url);
  }

  Future<void> setUseVpnTunnel(bool value) async {
    _useVpnTunnel = value;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('use_vpn', value);
  }

  Future<void> setSecurityType(AppSecurityType type) async {
    _securityType = type;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('security_type', type.index);
  }
}
