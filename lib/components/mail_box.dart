import 'package:flutter/material.dart';
import 'mail_list.dart';
import 'pagination.dart';
import 'mail_head.dart';
import '../data.dart';
class MailBox extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    print('MailBox build');
    final head = MailHead();
    final tail = Pagination();

    List<Widget> list = <Widget>[];
    Data.mail_list.forEach((map)
    {
    
      list.add(MailList(text:map['name'],date:map['date']));
   
    }
    );

    final list_wrap = Column(
      children:list
    );

    final items = <Widget>[head,list_wrap,tail];
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

    //return Text('test');

    return  Column(
        mainAxisSize: MainAxisSize.max,
        children:[
          Expanded(child:
          listView
          )
        ],
      );
    }
}
