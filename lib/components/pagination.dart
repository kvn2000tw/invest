import 'package:flutter/material.dart';
import '../custom/custom_theme.dart';
import '../data.dart';
import 'pagination_item.dart';
import 'pagination_head.dart';
import '../service.dart';
class Pagination extends StatelessWidget {


  _prev_page()
  {
    print('prev_page');
    if(Data.cur_page > 1)
      Data.cur_page --;
    
    if(Data.cur_page < Data.start_page)
      Data.start_page = Data.cur_page;

    Service.process_articles();

  }
  _next_page()
  {
    print('next_page');

    if(Data.cur_page < Data.total_page)
      Data.cur_page ++;

    if(Data.cur_page > (Data.start_page+5))
      Data.start_page ++;

    Service.process_articles();

  }
  _select_page(int value)
  {
    print(value);

    Data.cur_page = value;
    Service.process_articles();
    
  }
  @override
  Widget build(BuildContext context) {
    print(Data.total_page);
    if(Data.total_page < 2)  return SizedBox(
      //color:Colors.white,
      height: 0.0,//_bottomNavBarHeight,
      child: null,
    );

    List<Widget> list = [];

    if((Data.start_page+8) < Data.cur_page)
    {
     
      Data.start_page = Data.cur_page-8;
      if(Data.start_page < 1)
        Data.start_page = 1;
    }

    late int end_page;

    if((Data.start_page+8) < Data.total_page)
    {
      
      end_page = Data.start_page+8;
      if(end_page > Data.total_page)
        end_page = Data.total_page;
    }
    else 
    {
     
      Data.start_page = Data.total_page-8;
      if(Data.start_page <= 0)
        Data.start_page = 1;

      end_page = Data.start_page+8;
      if(end_page > Data.total_page)
        end_page = Data.total_page;
    }
   
  
    if(Data.start_page > 1)
    {
      list.add( PaginationHead(text:'',next:false,onTap:()=>_prev_page()),);
    }
    for(int i=Data.start_page;i<=end_page;i++)
    {
      list.add(PaginationItem(text:i.toString(),width:32,select:i==Data.cur_page?true:false,onTap:()=>_select_page(i)),);
    }

    if(end_page < Data.total_page)
    {
      list.add(PaginationHead(text:'',next:true,onTap:()=>_next_page()),);
    }
    return  
  
      Container(
        alignment:Alignment.center,
                decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          border: Border.all(color: Colors.blueAccent)
        ),
        child:
      Container(
        alignment:Alignment.center,
        width: 35*list.length+35,
        height: 80,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          //border: Border.all(color: Colors.blueAccent)
        ),
        child: Row(
          //direction: Axis.horizontal,
          //spacing: 0,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: 
            list,
        ),
      
  ));
  }
}