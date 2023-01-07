import 'package:flutter/material.dart';
import '../custom/custom_theme.dart';
import '../data.dart';

class PaginationItem extends StatelessWidget {

  late GestureTapCallback onTap;

  String text;
  double width;
  
  bool select;

  PaginationItem({ 
   required this.text,
   required this.width,
  
   this.select = false,
   required this.onTap,
   });
  
  @override
  Widget build(BuildContext context) {
    return 
        InkWell(
    onTap: onTap,
    child:Container(
      width: width,
      height: 38,
      decoration: BoxDecoration(
        color: select?Data.blue : Data.mail_white,
        //border: Border.all(color: Colors.blueAccent)
      ),
      child: Align(
        alignment: AlignmentDirectional(0, 0),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: FlutterFlowTheme.of(context).bodyText1.override(
            fontFamily: 'Poppins',
            color: select?Colors.white:Data.black,
            fontSize: 13,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    ));
  }
}