import 'package:flutter/material.dart';
import '../custom/custom_theme.dart';
import '../data.dart';
import 'pagination_item.dart';
import 'pagination_head.dart';
class Pagination extends StatelessWidget {


  _prev_page()
  {
    print('prev_page');
  }
  _next_page()
  {
    print('next_page');
  }
  _select_page(String value)
  {
    print(value);
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

    if(Data.cur_page >(Data.start_page+5))
      Data.start_page = Data.start_page+1;


    late int end_page;
    if((Data.start_page+8) > Data.total_page)
    {
      end_page = Data.start_page+8;
    }
    else 
    {
      end_page = Data.total_page-Data.start_page;
    }
 
    if(Data.start_page > 0)
    {
      list.add( PaginationHead(text:'上一頁',next:false,onTap:()=>_prev_page()),);
    }
    for(int i=Data.start_page;i<end_page;i++)
    {
      list.add(PaginationItem(text:i.toString(),width:40,select:i==Data.cur_page?true:false,onTap:()=>_select_page(i.toString())),);
    }

    if(Data.end_page < Data.total_page)
    {
      list.add(PaginationHead(text:'下一頁',next:true,onTap:()=>_next_page()),);
    }
    return  Align(
  alignment: AlignmentDirectional(0, 0),
  child: Align(
      alignment: AlignmentDirectional(0, 0),
      child: Container(
        //width: 300,
        height: 80,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          border: Border.all(color: Colors.blueAccent)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: 
            list,
        ),
      ),
    ),
  );
  }
}