import 'package:flutter/material.dart';
import 'mail_list.dart';
import 'pagination.dart';
import 'mail_head.dart';

class MailBox extends StatelessWidget {

  @override
  Widget build(BuildContext context) {


  final head = MailHead();
  final tail = Pagination();

    var items = <Widget>[head,
      MailList(star:true,text:'文章標題在這邊',date:'2022-11-04'),tail];
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
