import 'package:flutter/material.dart';
import '../custom/custom_theme.dart';
import '../data.dart';

class PaginationHead extends StatelessWidget {

  late GestureTapCallback onTap;
  final String image_next = 'chevron_right.png';
  final String image_prev = 'chevron_left.png';
  String text;
  bool next;
  PaginationHead({ 
   required this.text,
  this.next = false,
  required this.onTap,
   });
  
  @override
  Widget build(BuildContext context) {
    final  text_item = Text(
                          text,
                          style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Poppins',
                          color: FlutterFlowTheme.of(context).primaryColor,
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                        ),
                  );
               
    final icon = Image.asset(
                    next?'assets/images/${image_next}':'assets/images/${image_prev}',
                    width: 20,
                    height: 20,
                    fit: BoxFit.contain,
                  );
    var list = [icon,text_item,];
    if(next)
    {
      list = [text_item,icon];
    }
    return 
    InkWell(
    onTap: onTap,
    child:Container(
        margin: const EdgeInsets.only(left:10.0),
        width: 80,
        height: 40,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: list,
        ),
      ));
  }
}