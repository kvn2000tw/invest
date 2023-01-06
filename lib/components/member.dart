import 'package:flutter/material.dart';

import 'log_info.dart';
import 'member_head.dart';
import '../data.dart';
import 'dart:convert';

class Member extends StatelessWidget {

  Map<String,dynamic> user = {};
  List<dynamic> user_payments = [];
  String pay_title = '';
  
  decodeInfo(String json)
  {
    if(json.isEmpty)    
    {
      user_payments = [];
      return;
    }
    Map<String,dynamic> fromJsonMap = jsonDecode(json);
    //print(json);
    pay_title = fromJsonMap['pay_title']+'：'+fromJsonMap['next_action_date'];
    //print(fromJsonMap["user"]);
    user = fromJsonMap["user"];
  
    user_payments = user["user_payments"] ?? [];

    //print(fromJsonMap["user_payments"]);

  }
  @override
  Widget build(BuildContext context) {
    print('Member');

    decodeInfo(Data.userInfo);
    final title1 = MemberHead(user,pay_title);
   
      List<Widget> list = <Widget>[];
      user_payments.forEach((map)
      {   
        list.add(LogInfo());
      } );
      
  final list_wrap = Column(
    children:list
  );
    var items = <Widget>[title1,list_wrap];
    
    final listView = ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: items.length,//listItems.length,
      itemBuilder: (context, index) =>
      InkWell(
      child:items[index],           
      onTap:()=>{print(index)},
      )
       
    );

    return 
      Column(
        mainAxisSize: MainAxisSize.max,
        children:[
          Expanded(child:
          listView
          )
        ],
      );
  }
}

