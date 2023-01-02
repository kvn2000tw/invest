import 'package:flutter/material.dart';

enum Status{
    Login(value: 0, label: "登入"),
    Introduce(value: 1, label: "簡介"),
    Register(value: 2, label: "Register"),
    Browser(value: 3, label: "browser"),
    Alarm(value: 4, label: "alarm"),
    Email(value: 5, label: "Email"),
    QAnalysis(value: 6, label: "quantitative_analysis"),
    Screener(value: 7, label: "screener"),
    Price(value: 8, label: "commodity_price"),
    User(value: 9, label: "user"),
    Notify(value: 10, label: "notify"),
    Member(value: 11, label: "member"),

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
      
      borderColor = Color(0xFF89CAD5);
      yellow = Color(0xFFE3B205);
      blue = Color(0xFF0074c3);
      member_blue = Color(0xFF0472BD);
      orange = Color(0xFFecaf00);
      grey = Color(0xFFC4C4C4);
      white = Colors.white;
      black = Colors.black;

      mail_white = white;
      mail_grey = grey;
      infoBorderColor = Color(0xFFC4C4C4);
    }
    else 
    {
      email = 'email_dark.png';
      key = 'key_dark.png';

      borderColor = Color(0xFF89CAD5);
      yellow = Color(0xFFFAC508);
      blue = Color(0xFF009cff);
      orange = Color(0xFFffc300);
      member_blue = Color(0xFF0099FF);
      white = Color(0xFF161616);//Colors.black;
      black = Colors.white;
      grey = Colors.white;
      
      mail_white = Color(0xFF4D4D4D);
      mail_grey = Color(0xFFA1A1A1);

      infoBorderColor = Color(0xFFA1A1A1);
    }

    const String name_env = String.fromEnvironment('name',defaultValue: 'unknown');
    const String passwd_env = String.fromEnvironment('passwd',defaultValue: 'unknown');
    const String dark_config = String.fromEnvironment('dark_config',defaultValue: 'false');
   
    if(dark_config.compareTo('false') != 0)
      dark_setting = true;

    name_test = name_env;
    passwd_test = passwd_env;
  }
  static String username = '';
  static String passwd = '';
  static final ValueNotifier<bool> remeber = ValueNotifier(false);

  static final ValueNotifier<bool> headbar_event = ValueNotifier(false);
  static final ValueNotifier<Status> status = ValueNotifier(Status.Introduce);
  static final ValueNotifier<int> view_change = ValueNotifier(0);
  static final home_page = 'https://investanchors.com/';
  static final intro_page = 'https://investanchors.com/home/about?view_source_from=app';
  static final register_app_page = 'https://investanchors.com/user/register/new?view_source_from=app';
  static final register_page = "https://investanchors.com/user/register/new";
  static final forgot_page = "https://investanchors.com/api/users/forget_pass";
  static final login_page = "https://investanchors.com/api/users/login";
  static final articles_page = "https://investanchors.com/api/articles?";
  static final users_page = "https://investanchors.com/api/users?";
  static final see_all_cmd =  "https://investanchors.com/api/articles/see_all?";  
  static final to_return =  "https://investanchors.com/api/users/to_return";

  static String user_token =  "";
  static String bell_notice_page = "https://investanchors.com/api/articles/bell_notice?";
  static String playplus = '54178192';
  static final  QAnalysis_page = 'https://investanchors.com/user/quantitative_analysis?coid=2330&view_source_from=app&user_token=';
  static final Screener_page = 'https://investanchors.com/screener?view_source_from=app&user_token=';
  static final Price_page = 'https://investanchors.com/user/commodity_price/23DD24?view_source_from=app&user_token=';
  

  //static final String email = 'email_dark.png';
  static String email = 'email_light.png';
  static String key = 'email_dart.png';

  static Color bar_icon_color = Color(0xFF0472bd);
  static Color borderColor = Color(0xFF89CAD5);
  static Color infoBorderColor = Color(0xFFC4C4C4);
  static Color yellow = Colors.yellow;
  static Color blue = Colors.blue;
  static Color orange = Colors.orange;
  static Color white = Colors.white;
  static Color black = Colors.black;
  static late Color grey;
  static late Color member_blue;
  static late Color  mail_white;
  static late Color  mail_grey;

  //static Color member_white = Color();
  static bool is_dark = true;
  static String url = intro_page;
  static String home = home_page;
  static final dark_image = 'dark_mode.png';
  static final light_image = 'light_mode.png';

  static const notify_image = 'notifications.png';
  static const notify_alarm_image = 'notifications_alarm.png';

  static late String name_test;
  static late String passwd_test;
  static bool is_alarm = false;
  static bool dark_setting = false;
  
  static void update_status(Status s)
  {
    status.value = s;
    update_headbar_event();
  }

  static void update_headbar_event()
  {
    headbar_event.value = !headbar_event.value;
  }
  static void update_view_change()
  {
    view_change.value = view_change.value+1;
  }

  static String token = '';

  static const drawer_config = true;//String.fromEnvironment('drawer_config',defaultValue: 'false');
  static List<Map<String,dynamic>> mail_list = [];
  static List<Map<String,dynamic>> user_payments = [];
  static String userInfo = '';

  static update_alarm(bool alarm)
  {
    is_alarm = alarm;
    update_headbar_event();
  }
 
}