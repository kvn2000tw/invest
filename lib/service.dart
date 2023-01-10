
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
    
    if(Data.user_token.isEmpty)    return '';
    
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
         
         Data.update_alarm(fromJsonMap["no_see"].length > 0?true:false);
         Data.update_headbar_event();
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

    final String search_type = 'search_type = ${Data.search_type[Data.tag_index.value]}';
    final String lv = 'lv=${Data.selectHeadList[Data.selectHead]}';
    final String user_token = 'user_token=${Data.user_token}';
    final String playplus = 'playplus=${Data.playplus}';
    final String key = 'key=${Data.search_string}';
    final String page = 'page=${Data.cur_page}';
    final String url_str = '${Data.articles_page}${user_token}&${playplus}&${lv}&${search_type}&${key}&${page}';
    
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
  static process_articles()
  {
    final ret =  getArticles();
          
    ret.then((value)=>updateArticles(value));
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
  static updateArticles(String json)
  {
    Data.update_status(Status.Email);
    Data.update_view_change();

    if(json.isEmpty)
    {
      Data.mail_list = [];
      return;
    }
    List<Map<String,dynamic>> list = [];
    print('updateArticles');
    Map<String,dynamic> fromJsonMap = jsonDecode(json);
    print(fromJsonMap['article'].length);
    //print(fromJsonMap['article']);
    fromJsonMap['article'].forEach((value)
      {
        final date = value['posted_at'].split("T"); 
        //print('${value['name']} ${date[0]}');
        Map<String,dynamic> map = {"id":value['id'],
        "name":value['name'],
        "date":date[0],
        "no":value['no'],
        "favorite":value['favorite'],
        "has_open":value['has_open'],
        };
        list.add(map);
      }
    );

    print(fromJsonMap['page']['total_page']);
    Data.cur_page =  int.parse(fromJsonMap['page']['page']);
    Data.total_page = fromJsonMap['page']['total_page'];
    print(list);
    Data.mail_list = list;
  }
   
  static updateUser(String json)
  {
    print('updateUser');
    print(json);
    Data.userInfo = json;

    //Data.update_status(Status.Member);
    Data.update_headbar_event();
    Data.update_view_change();

  }

  static  updateUsers() async {
    
    final  ret = getUsers();

    ret.then((value)=>updateUser(value));
  }

  static goLogout() async
  {
    print('gologout');
    Data.userInfo = '';
    final cookieManager = WebviewCookieManager();

    final gotCookies = await cookieManager.getCookies(Data.home_page);
      for (var item in gotCookies) {
        //print(item);
      }

    await cookieManager.clearCookies(); 
    Data.url = Data.intro_page;
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