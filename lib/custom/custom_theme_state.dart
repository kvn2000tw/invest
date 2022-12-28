
import 'package:flutter/material.dart';
import 'cutom_text_style.dart';
import '../data.dart';

class CustomThemeState {
  
  CustomThemeState(){
    bodyText1 = CustomTextStyle();
    bodyText2 = TextStyle();
    title3 = TextStyle();
    subtitle2 = CustomTextStyle();

    init();
  }

  void init()
  {
    if(Data.is_dark == false)
    {
      checkColor = Colors.blue;
      primaryColor = Colors.blue;
      secondaryBackground = Colors.white;
      customColor1 = Color(0xFFF6F6F6);
      customColor2 = Colors.white;
      customColor3 = Colors.black;
      customColor4 = Colors.blue;
      customColor5 = Colors.black;
      customColor6 = Colors.black;
      secondaryColor = Colors.blue;

    }
    else 
    {
      checkColor = Colors.black;
      primaryColor = Color(0xFF009cff);//Colors.blue;
      secondaryBackground = Color(0xFF4D4D4D);//Colors.black;
      customColor1 = Colors.black;//Color(0x303030);
      customColor2 = Colors.black;
      customColor3 = Colors.white;
      customColor4 = Colors.white;
      customColor5 = Colors.blue;
      customColor6 = Colors.white;    
      secondaryColor = Color(0xFF009cff);

    }

  }
  

  Color checkColor = Colors.blue;
  
  Color primaryColor = Colors.blue;
  Color secondaryBackground = Colors.white;
  Color customColor1 = Color(0xFFF6F6F6);
  Color customColor2 = Colors.white;
  Color customColor3 = Colors.black;
  Color customColor4 = Colors.blue;
  Color customColor5 = Colors.black;
  Color customColor6 = Colors.black;
  Color secondaryColor = Colors.blue;

  Color tertiaryColor = Colors.yellow;
  Color primaryBackground = Colors.blue;

  late CustomTextStyle bodyText1;
  late TextStyle bodyText2;
  late CustomTextStyle subtitle2;

  late TextStyle title3;
  
}