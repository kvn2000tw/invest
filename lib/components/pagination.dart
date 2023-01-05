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
          children: [
            PaginationHead(text:'上一頁',next:false,onTap:()=>_prev_page()),
            PaginationItem(text:'1',width:40,select:true,onTap:()=>_select_page('1')),
            PaginationItem(text:'2',width:40,select:false,onTap:()=>_select_page('2')),
          
            PaginationHead(text:'下一頁',next:true,onTap:()=>_next_page()),
         
          ],
        ),
      ),
    ),
  );
  }
}