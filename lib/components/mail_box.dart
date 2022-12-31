import 'package:flutter/material.dart';
import 'mail_list.dart';
import 'pagination.dart';
import 'mail_head.dart';
import '../data.dart';
class MailBox extends StatelessWidget {

  @override
  Widget build(BuildContext context) {


  final head = MailHead();
  final tail = Pagination();

  List<Widget> list = <Widget>[];
  Data.mail_list.forEach((map)
  {
    
    list.add(MailList(text:map['name'],date:map['date']));
    //list.add(MailList(text:"1234567890123456789012345678901234567890",
    //date:map['date']));
  }
  );
  final list_wrap = Column(
    children:list
  );
  var items = <Widget>[head,list_wrap,tail];
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
