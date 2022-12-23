//import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'data.dart';
import 'theme/theme_preference.dart';
class Service {

  static ThemePreferences _preferences = ThemePreferences();
    
  static setRemeber(bool value) async {
    await _preferences.setRemeber(value);    
  }
  static setRemeberInfo(String user,String passwd) async {
    await _preferences.setRemeberInfo(user,passwd);    
  }

  static Future<bool> getRemeber() {
    return _preferences.getRemeber();
  }
  static Future<String> getUsername()  {
    return _preferences.getUsername();
  }
  static Future<String> getPasswd() {
    return _preferences.getPasswd();
    
  }

    static Future<String> getNotify() async {

    final String url_str = '${Data.bell_notice_page}user_token=${Data.user_token}&playplus=${Data.playplus}';
    
    final url = Uri.parse(url_str);

    final responseOfFuture = await http.get(
      url
    );
    print('getNotify');
    print(url_str);
    if (responseOfFuture.statusCode == 200) {
      print(responseOfFuture.body);
      //{"status":"success","user_token":"166745463414164","error":""}
      Map<String,dynamic> fromJsonMap = jsonDecode(responseOfFuture.body);
      //print(fromJsonMap["status"]);
      String json = '';
      if(fromJsonMap["status"].compareTo('success') == 0)
      {
        json = responseOfFuture.body;
      }
      return json;
   
    }

    return '';
  }

}