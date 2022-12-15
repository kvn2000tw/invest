
import 'package:flutter/material.dart';
import 'cutom_text_style.dart';

class CustomThemeState {
  
  CustomThemeState(){
    bodyText1 = CustomTextStyle();
    bodyText2 = TextStyle();
    subtitle2 = CustomTextStyle();
  }
  final Color primaryColor = Colors.blue;
  final Color secondaryBackground = Colors.white;
  final Color customColor2 = Colors.white;
  final Color customColor4 = Colors.blue;
  final Color secondaryColor = Colors.blue;


  late CustomTextStyle bodyText1;
  late TextStyle bodyText2;
  late CustomTextStyle subtitle2;
  
}