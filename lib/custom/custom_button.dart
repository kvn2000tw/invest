
import 'package:flutter/material.dart';
import 'custom_button_options.dart';

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

