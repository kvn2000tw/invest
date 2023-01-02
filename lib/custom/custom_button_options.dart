import 'package:flutter/material.dart';

class FFButtonOptions{

  TextStyle? textStyle;
  Color? color;
  BorderRadiusGeometry? borderRadius;
  BorderSide? borderSide;
  FFButtonOptions(
    {
    double? width,
    double? height,
    this.color,
    this.textStyle,
    this.borderSide,                
    this.borderRadius,
  }
  )
  {

  }
}