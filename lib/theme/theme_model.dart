//theme_model.dart 
import 'package:flutter/material.dart';
import 'theme_preference.dart';

class ThemeModel extends ChangeNotifier {

  static const modeSystem = 0; // 自动
  static const modeLight = 1; // 亮色
  static const modeDark = 2; // 暗色

  ThemeMode themeMode = ThemeMode.system;

  late ThemePreferences _preferences;


  ThemeModel() {
   
    _preferences = ThemePreferences();
    getPreferences();
  }
    setThemeMode(ThemeMode mode) {
    themeMode = mode;
    _preferences.setTheme(enumConvertToConst(mode));
    notifyListeners();
  }

  /// 枚举转常量
  static int enumConvertToConst(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.light:
        return modeLight;
      case ThemeMode.dark:
        return modeDark;
      default:
        return modeSystem;
    }
  }  

  /// 常量转枚举
  static ThemeMode constConvertToEnum(int mode) {
    switch (mode) {
      case modeLight:
        return ThemeMode.light;
      case modeDark:
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }  

  getPreferences() async {
    int mode = await _preferences.getTheme();

    themeMode = constConvertToEnum(mode);
    notifyListeners();
  }
}
//Switching themes in the flutter apps - Flutterant