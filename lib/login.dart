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

    final email_title_icon = Container(
      child:Image.asset(
      'assets/email_black.png',
      fit: BoxFit.contain,

      //alignment: Alignment.center,
      ),
      height: 20.0,
      width: 25.0,
      margin: const EdgeInsets.only(top: 5.0),
     
    );
    
    final email_title_str = Container(
      child:Text(
      '電子郵件*',
      style: TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
      ),
      height: 28.0,
      width: 91.0,
      margin: const EdgeInsets.only(left:10,top: 2.0),
    );

    final emailController = TextEditingController();
    final email_input =  Expanded(
    child:Container(
      height:32.0,
      child:TextField(
      controller: emailController,
      style: const TextStyle(fontSize: 20),
      decoration: const InputDecoration(
        //icon: email_title_icon,
        border: OutlineInputBorder(),
        //labelText: '輸入姓名',
        //labelStyle:TextStyle(fontSize:20),
      ),
    )));
    final email_title_area = Expanded(
    child:Container(
       margin: const EdgeInsets.only(top:30.0,bottom:10.0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blueAccent)
      ),
      child:Row(
        children: <Widget>[email_title_icon, email_title_str],
    )));

    final passwd_title_icon = Container(
      child:Image.asset(
      'assets/key.png',
      fit: BoxFit.contain,

      //alignment: Alignment.center,
      ),
      height: 15.0,
      width: 27.5,
      margin: const EdgeInsets.only(top: 5.0),
     
    );

   
    final passwd_title_str = Container(
      child:Text(
      '密碼*',
      style: TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
      ),
      height: 28.0,
      width: 91.0,
      margin: const EdgeInsets.only(left:10,top: 2.0),
    );

    final passwdController = TextEditingController();
    final passwd_input =  Expanded(
    child:Container( 
      height:32.0,
      child:TextField(
      controller: passwdController,
      style: const TextStyle(fontSize: 20),
      decoration: const InputDecoration(
        //icon: email_title_icon,
        border: OutlineInputBorder(),
        //labelText: '輸入姓名',
        //labelStyle:TextStyle(fontSize:20),
      ),
    )));

    final passwd_title_area =  Expanded(
    child:Container(
       margin: const EdgeInsets.only(top:30.0,bottom:10.0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blueAccent)
      ),
      child:Row(
        children: <Widget>[passwd_title_icon, passwd_title_str],
    )));    

    final remeber = Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blueAccent)
      ),
      margin: const EdgeInsets.only(left:2),
      width:200,
      height:70,
      alignment:Alignment.center,
      child:CheckboxListTile(
        title:Text('記住我',style:const TextStyle(fontSize:20,
        fontWeight:FontWeight.bold,
        )),
        value:true,
        controlAffinity: ListTileControlAffinity.leading,

        onChanged:(newValue){

      },
    ));
    
    final forgot = Container(
            decoration: BoxDecoration(
          border: Border.all(color: Colors.blueAccent)
      ),
      margin: const EdgeInsets.only(right:2),
      child:Text('忘記密碼？',style:const TextStyle(
      color:Colors.blue,
      fontWeight:FontWeight.bold,
      fontSize:20
      )));

    final login_remeber =  Expanded(
    child:Container(
            decoration: BoxDecoration(
          border: Border.all(color: Colors.black)
      ),
      margin: const EdgeInsets.only(left:2,right:2,top:30.0,bottom:10.0),
      padding: const EdgeInsets.all(2),
      child:Row(
        children:<Widget>[remeber,forgot],
       
      ),
      
    ));

    final btn_login =  Text('登入',style:const TextStyle(
      color:Colors.white,
      fontWeight:FontWeight.bold,
      fontSize:16
      ));

    final btn =  Expanded(
    child:Container(
      margin: const EdgeInsets.only(top:30.0),
      child:ElevatedButton(
        child:btn_login,
        onPressed:(){}
      )
    ));

    final info1 =  Expanded(
    child:Text('還不是會員？',style:const TextStyle(
      color:Colors.black,
      fontWeight:FontWeight.bold,
      fontSize:16
      )));
    final info2 =  Expanded(
    child:Text('前往官網註冊',style:const TextStyle(
      color:Colors.blue,
      fontSize:16
      )));  
    final info3 = Expanded(
    child:Container(
      child:Text('為何要成為定錨產業筆記的會員？',style:const TextStyle(
        color:Colors.black,
        fontWeight:FontWeight.bold,
        fontSize:14,
      
        ),
      ),
      margin: const EdgeInsets.only(top: 5.0),
      ));  

    final info4 = Expanded(
    child:Container(
      child:Text('‧ 產業深度分析：讓您的投資更前瞻！',style:const TextStyle(
        color:Colors.black,
        fontWeight:FontWeight.normal,
        fontSize:12,
      
        ),
      ),
      margin: const EdgeInsets.only(top: 5.0),
      ));  

    final info5 = Expanded(
    child:Container(
      child:Text('‧ 即時法說會簡評：讓您快速掌握公司經營動態！',style:const TextStyle(
        color:Colors.black,
        fontWeight:FontWeight.normal,
        fontSize:12,
      
        ),
      ),
      margin: const EdgeInsets.only(top: 5.0),
      ));  

    final info6 = Expanded(
    child:Container(
      child:Text('‧ 內容含金量No.1：有效提升投資成績！',style:const TextStyle(
        color:Colors.black,
        fontWeight:FontWeight.normal,
        fontSize:12,
      
        ),
      ),
      margin: const EdgeInsets.only(top: 5.0),
      ));  

      
    final core_column = Container(
      child:Column(
      children:<Widget>[          
        email_title_area,
        email_input,
        passwd_title_area,
        passwd_input,
        login_remeber,
        btn,
        info1,
        info2,
        ],
      
      ),
      alignment:Alignment.center,
    );

    final core = Container(
        margin: const EdgeInsets.all(20.0),
        child:core_column,
        width:349,
        height:550,
        //margin: const EdgeInsets.only(top: 30.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blueAccent)
        ),
    );

    final tail_column = Container(
      child:Column(
      children:<Widget>[          
       info3,info4,info5,info6
        ],
      crossAxisAlignment:CrossAxisAlignment.start
      ),
      alignment:Alignment.center,
      
    );

    final tail = Expanded(
      child:Container(
      child:tail_column,
      width:262,
      height:86,
      margin: const EdgeInsets.only(top: 0.0),
    ));
    final appBody = Column(
     
      children: <Widget>[
        top_img,
        core,
        //tail,

      ],
     
    );

    /*
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
*/
    return appBody;
  }
}
