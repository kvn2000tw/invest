//Switching themes in the flutter apps - Flutterant
//theme_preference.dart
import 'package:shared_preferences/shared_preferences.dart';

class ThemePreferences {
  static const PREF_KEY = "dark_key";
  static const USERNAME_KEY = "USERNAME_KEY";
  static const PASSWD_KEY = "PASSWD_KEY";
  static const REMEBER_KEY = "REMEBER_KEY";

  setTheme(int value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt(PREF_KEY, value);
  }

  getTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt(PREF_KEY) ?? 0;
  }

  setRemeberInfo(String username,String passwd) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(USERNAME_KEY, username);
    sharedPreferences.setString(PASSWD_KEY, passwd);
  }

  Future<String> getUsername() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(USERNAME_KEY) ?? "";
  }
  Future<String> getPasswd() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(PASSWD_KEY) ?? "";
  }

  Future<bool> getRemeber() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(REMEBER_KEY) ?? false;
  }
  
  setRemeber(bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(REMEBER_KEY, value);
  }

}
//Switching themes in the flutter apps - Flutterant