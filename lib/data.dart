import 'package:flutter/material.dart';

enum Status{
    Login(value: 0, label: "登入"),
    Register(value: 2, label: "Register"),
    Browser(value: 3, label: "browser"),
    Email(value: 4, label: "Email"),
    QAnalysis(value: 5, label: "quantitative_analysis"),
    Screener(value: 6, label: "screener"),
    Price(value: 7, label: "commodity_price"),
    User(value: 8, label: "user"),

    Logout(value: -1, label: "登出");
    
    final int value;
    final String label;
  
  const Status({
    required this.value,
    required this.label,
   
  });

 /// 解析从后台传来的值
  static Status parse(int i) {
    if (i == -1) return Status.Logout;
    return Status.values[i];
  }    
}

class Data {
 
  static init()
  {
    if(is_dark == false)
    {
      email = 'email_light.png';
      key = 'key_light.png';
      
      blue = Color(0xFF0074c3);
      orange = Color(0xFFecaf00);
        
      white = Colors.white;
    }
    else 
    {
      email = 'email_dark.png';
      key = 'key_dark.png';

      blue = Color(0xFF009cff);
      orange = Color(0xFFffc300);
      
      white = Colors.black;
    }

  }
  static String username = '';
  static String passwd = '';
  static final ValueNotifier<bool> remeber = ValueNotifier(false);

  static final ValueNotifier<Status> status = ValueNotifier(Status.Login);
  static final ValueNotifier<int> view_change = ValueNotifier(0);
  static final register_app_page = 'https://investanchors.com/user/register/new?view_source_from=app';
  static final register_page = "https://investanchors.com/user/register/new";
  static final forgot_page = "https://investanchors.com/api/users/forget_pass";
  static final login_page = "https://investanchors.com/api/users/login";
  static String user_token =  "";
  static String bell_notice_page = "https://investanchors.com/api/articles/bell_notice?";
  static String playplus = '54178192';
  static final  QAnalysis_page = 'https://investanchors.com/user/quantitative_analysis?coid=2330&view_source_from=app&user_token=';
  static final Screener_page = 'https://investanchors.com/screener';
  static final Price_page = 'https://investanchors.com/user/commodity_price';
  

  //static final String email = 'email_dark.png';
  static String email = 'email_light.png';
  static String key = 'email_dart.png';

  static Color blue = Colors.blue;
  static Color orange = Colors.orange;
  static Color white = Colors.white;

  static bool is_dark = true;
  static String url = '';
  static final dark_image = 'dark_mode.png';
  static final light_image = 'light_mode.png';

}