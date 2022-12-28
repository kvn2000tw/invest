import 'package:flutter/material.dart';
import '../custom/custom_theme.dart';
class ButtonEle extends StatelessWidget {

 
  late double width;
  late double height;

  late String text;
  late double fontSize;
  late FontWeight fontWeight;

  ButtonEle({
  required double width,
  required double height,
  required String text,
 
  required double fontSize,
  FontWeight fontWeight=FontWeight.w400,
  })
  {
    this.width = width;
    this.height = height;
    this.text = text;
   
    this.fontSize = fontSize;
    this.fontWeight = fontWeight;
  }
  @override
  Widget build(BuildContext context) {
   
    return Container(
      width: this.width,
      height: this.height,
      decoration: BoxDecoration(
        color:
          FlutterFlowTheme.of(context).secondaryBackground,
      ),
      child: Align(
        alignment: AlignmentDirectional(0, 0),
          child: Text(
            this.text,
            style:
            FlutterFlowTheme.of(context).bodyText1.override(
              fontFamily: 'Poppins',
              fontSize: this.fontSize,
              fontWeight: this.fontWeight,
            ),
          ),
        ),
      );

  }
}