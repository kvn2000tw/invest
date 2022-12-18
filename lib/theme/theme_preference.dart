//Switching themes in the flutter apps - Flutterant
//theme_preference.dart
import 'package:shared_preferences/shared_preferences.dart';

class ThemePreferences {
  static const PREF_KEY = "dark_key";

  setTheme(int value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt(PREF_KEY, value);
  }

  getTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt(PREF_KEY) ?? 0;
  }
}
//Switching themes in the flutter apps - Flutterant