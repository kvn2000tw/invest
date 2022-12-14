
import 'package:flutter/material.dart';

class CustomTextStyle extends TextStyle{
  
  CustomTextStyle():super();
  late TextStyle textStyle;
  TextStyle override({String? fontFamily,Color? color,double? fontSize,FontWeight? fontWeight})
  {
    return copyWith(
        fontFamily: fontFamily,
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
    );
  
  }

}