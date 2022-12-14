
import 'package:flutter/material.dart';
import 'custom_theme_state.dart';

class FlutterFlowTheme {
  FlutterFlowTheme();

  static CustomThemeState? state;

  static CustomThemeState of(BuildContext context){
    if(state == null){
      state = CustomThemeState();
    }

    return state!;
  }
}