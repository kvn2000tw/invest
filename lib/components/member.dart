import 'package:flutter/material.dart';
import '../custom/custom_theme.dart';
import 'log_info.dart';
import 'pagination.dart';
import 'member_head.dart';
import '../data.dart';
class Member extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    print('Member');

    final title1 = MemberHead();
   
    var items = <Widget>[title1,
    LogInfo(), LogInfo(), LogInfo(), LogInfo(), LogInfo(),
    LogInfo(), LogInfo(), LogInfo(), LogInfo(), LogInfo(),
    ];
    
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

