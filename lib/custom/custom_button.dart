import 'package:flutter/material.dart';
import 'custom_button_options.dart';

class FFButtonWidget extends StatelessWidget {

  VoidCallback? onPressed;
  String? text;
  FFButtonOptions? options;
  ButtonStyle? style;
  //ButtonStyle? style;
  FFButtonWidget({
    this.onPressed,
    required this.text,
    this.options,
    //borderRadius
    }
  ); 
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child:Text(text!,
        style:options?.textStyle,),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: options!.color,  // 按鈕背景色
        //padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius:options!.borderRadius!),
        elevation: 8,
      ),
    );
  }
}  
     
/*
class FFButtonWidget extends ElevatedButton{

  FFButtonWidget({
 super.key,
  required super.onPressed,
  super.onLongPress,
  super.onHover,
  super.onFocusChange,
  super.style,
  super.focusNode,
  super.autofocus = false,
  super.clipBehavior = Clip.none,
  required super.child,

  FFButtonOptions? options,

}) 
{
  //super.child = Text(text!);
}
}

*/