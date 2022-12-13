import 'dart:ui';

import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;

class Login extends StatelessWidget {
  void login() async {
    var map = <String, String>{
      'email': 'playplus@com.tw',
      'password': 'p54178192',
    };
    final url = Uri.parse("https://investanchors.com:443/api/user_create");
    final responseOfFuture = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(map),
    );

    if (responseOfFuture.statusCode == 200) {
      print(responseOfFuture.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    final img = Image.asset(
      'assets/img_banner.png',
      fit: BoxFit.contain,
      //height: double.infinity,
      //width: double.infinity,
      alignment: Alignment.center,
    );
    final text = const Text(
      '會員登入',
      style: TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
    );

    final top_img = Stack(
      children: <Widget>[img, text],
      alignment: Alignment.center,
    );

    final email_title_icon = Image.asset(
      'assets/email_black.png',
      fit: BoxFit.contain,
      //height: double.infinity,
      //width: double.infinity,
      alignment: Alignment.center,
    );
    final email_title_str = const Text(
      '電子郵件*',
      style: TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
    );

    final emailController = TextEditingController();
    final email_input = TextField(
      controller: emailController,
      style: const TextStyle(fontSize: 20),
      decoration: const InputDecoration(
        //icon: email_title_icon,
        border: OutlineInputBorder(),
        //labelText: '輸入姓名',
        //labelStyle:TextStyle(fontSize:20),
      ),
    );
    final email_title_area = Row(
      children: <Widget>[email_title_icon, email_title_str],
    );

    final passwd_title_icon = Image.asset(
      'assets/key.png',
      fit: BoxFit.contain,
      //height: double.infinity,
      //width: double.infinity,
      alignment: Alignment.center,
    );
    final passwd_title_str = const Text(
      '密碼*',
      style: TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
    );

    final passwdController = TextEditingController();
    final passwd_input = TextField(
      controller: passwdController,
      style: const TextStyle(fontSize: 20),
      decoration: const InputDecoration(
        //icon: email_title_icon,
        border: OutlineInputBorder(),
        //labelText: '輸入姓名',
        //labelStyle:TextStyle(fontSize:20),
      ),
    );
    final passwd_title_area = Row(
      children: <Widget>[passwd_title_icon, passwd_title_str],
    );

    final remeber = Container(

      width:200,
      height:70,
      child:CheckboxListTile(
        title:Text('記住我',style:const TextStyle(fontSize:20)),
        value:true,
        controlAffinity:ListTileControlAffinity.leading,
       
        onChanged:(newValue){

      },
    ));
    
    final forgot = Text('忘記密碼？',style:const TextStyle(
      color:Colors.blue,
      fontSize:20
      ));

    final login_remeber = Container(
      child:Row(
        children:<Widget>[remeber,forgot],
        mainAxisSize: MainAxisSize.min,
      ),
      margin:const EdgeInsets.all(10) 
    );

    final btn = Container(
      child:ElevatedButton(
        child:Text('登入'),
        onPressed:(){}
      )
    );

    final info1 = Text('還不是會員？',style:const TextStyle(
      color:Colors.black,
      fontSize:20
      ));
    final info2 = Text('前往官網註冊',style:const TextStyle(
      color:Colors.blue,
      fontSize:20
      ));  
    final info3 = Text('為何要成為定錨產業簍記的僲員',style:const TextStyle(
      color:Colors.black,
      fontSize:20
      ));  

    final info4 = Text('產業深度分析：讓您的投資更前瞻',style:const TextStyle(
      color:Colors.black,
      fontSize:16
      ));  
      
    final info5 = Text('即時法說會簡評：讓您快速掌握公司經營動態！',style:const TextStyle(
      color:Colors.black,
      fontSize:16
      ));  
      
    final info6 = Text('內容含金量No.1：有效提升投資成績！',style:const TextStyle(
      color:Colors.black,
      fontSize:16
      ));  
      
      
    final appBody = Container(
      child: Column(
        children: <Widget>[
          top_img,
          email_title_area,
          email_input,
          passwd_title_area,
          passwd_input,
          login_remeber,
          btn,
          info1,
          info2,
          info3,info4,info5,info6

        ],
      ),
    );

    return appBody;
  }
}
