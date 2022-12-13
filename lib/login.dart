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

    final appBody = Container(
      child: Column(
        children: <Widget>[
          top_img,
          email_title_area,
          email_input,
          passwd_title_area,
          passwd_input
        ],
      ),
    );

    return appBody;
  }
}
