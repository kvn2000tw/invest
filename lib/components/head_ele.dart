import 'package:flutter/material.dart';
import '../custom/custom_theme.dart';
import '../data.dart';
class HeadEle extends StatelessWidget {
  
  late String text;
  late double width;
  late bool enable;
  GestureTapCallback? onTag;
  HeadEle(
  {
    required this.text,
     this.width = 60,
     this.enable=false,
     this.onTag,
  }
  );
  
  @override
  Widget build(BuildContext context) {
    
    return InkWell(
    onTap:onTag,
            child:Container(
              width: width,
              height: 41,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
              ),
              child: Container(
            
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  border: enable?Border(
           
                    bottom: BorderSide(width: 3.0, color: Data.borderColor),
                  ):null,
                ),
                child: Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: Text(
                    text,
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        color:enable?Data.blue:Data.black,
                    ),
                  ),
                ),
              ),
            
          ));
  }
}