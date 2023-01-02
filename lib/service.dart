
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'data.dart';
import 'theme/theme_preference.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';
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

  static Future<String> seeAll() async {

    final String url_str = '${Data.see_all_cmd}user_token=${Data.user_token}&playplus=${Data.playplus}';
    
    final url = Uri.parse(url_str);

    final responseOfFuture = await http.get(
      url
    );
    print('see all');
    print(url_str);
    if (responseOfFuture.statusCode == 200) {
      print(responseOfFuture.body);
      //{"status":"success","user_token":"166745463414164","error":""}
      Map<String,dynamic> fromJsonMap = jsonDecode(responseOfFuture.body);
      //print(fromJsonMap["status"]);
      String json = '';
      if(fromJsonMap["status"].compareTo('success') == 0)
      {
        Data.is_alarm = false;
        Data.update_headbar_event();
      }
      
   
    }

    return '';
  }

    static Future<String> getArticles() async {

    final String url_str = '${Data.articles_page}user_token=${Data.user_token}&playplus=${Data.playplus}';
    
    final url = Uri.parse(url_str);

    final responseOfFuture = await http.get(
      url
    );
    print('getArticles');
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

    static Future<String> getUsers() async {

    final String url_str = '${Data.users_page}user_token=${Data.user_token}&playplus=${Data.playplus}';
    
    final url = Uri.parse(url_str);

    final responseOfFuture = await http.get(
      url
    );
    print('getUsers');
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

  static updateUser(String json)
  {
    print('updateUser');
    print(json);
    Data.userInfo = json;

    Data.update_status(Status.Member);
    Data.update_view_change();

  }

  static  updateUsers() async {
    final  ret = getUsers();

    ret.then((value)=>updateUser(value));
  }

  static goLogout() async
  {
    final cookieManager = WebviewCookieManager();

    final gotCookies = await cookieManager.getCookies(Data.home_page);
      for (var item in gotCookies) {
        print(item);
      }

    await cookieManager.clearCookies(); 
    Data.url = Data.home;
    //Data.goLogout();
   
  }

  static toReturn({required String return_reason,String other_reason=''})async
  {
      final map = <String, String>{
     
      'user_token': Data.user_token,
      'playplus': Data.playplus,
      'return_reason':return_reason,
      'other_reason':other_reason,
    };
  
    final url = Uri.parse(Data.to_return);
    final responseOfFuture = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(map),
    );
    print(responseOfFuture.statusCode);
    if (responseOfFuture.statusCode == 200) {
      print(responseOfFuture.body);
      //{"status":"success","user_token":"166745463414164","error":""}
      Map<String,dynamic> fromJsonMap = jsonDecode(responseOfFuture.body);
      //print(fromJsonMap["status"]);
      String json = '';
      if(fromJsonMap["status"].compareTo('success') == 0)
      {
        json = fromJsonMap['message'];
        
      }
      return json;
    }

    return '';

  }
}