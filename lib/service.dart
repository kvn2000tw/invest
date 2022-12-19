//import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'data.dart';
class Service {
    static void getNotify() async {

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
      print(fromJsonMap["status"]);
      if(fromJsonMap["status"].compareTo('success') == 0)    
      {
       print('${fromJsonMap["no_see"].length}');
      }
    }
  }

}