import 'package:flutter/material.dart';
import '../custom/custom_theme.dart';

class FlutterFlowRadioButton extends StatelessWidget {

  final ValueNotifier<String> _select = ValueNotifier('');

  late TextEditingController textController;
  ValueChanged<dynamic?>? onChanged;

  late List<String> options;
  double? optionHeight;
  double? buttonPosition;      
  Color? radioButtonColor;
  Color? inactiveRadioButtonColor;
  bool toggleable;
  WrapAlignment? horizontalAlignment;
  WrapCrossAlignment? verticalAlignment;      
  Axis? direction;
  TextStyle? textStyle; 
     
  int index = 0;
  FlutterFlowRadioButton({
    required this.options,
    this.onChanged,
    this.optionHeight,
    this.buttonPosition,
    this.radioButtonColor,
    this.inactiveRadioButtonColor,
    required this.toggleable,
    this.horizontalAlignment,
    this.verticalAlignment,
    this.direction,
    this.textStyle,
    required this.textController,
    }
  )
  {
    _select.value = options[0];
  } 
  _onChange(dynamic value)
  {
    _select.value = value;
    onChanged!(value);
  }
  Widget _radioButtonBuilder(BuildContext context, String selectedItem, Widget? child) {
    var radioItems = <ListTile>[];

    // 把選項加入radioItems
    for (var i = 0; i < options.length-1; i++) {
      radioItems.add(
        ListTile(
          visualDensity: VisualDensity(vertical: -3),
          title: Transform.translate(
            offset: Offset(-16, 0),
            child:Text(options[i], style: textStyle,),
          ),
        
          leading: Radio<String>(
            value:options[i],
            groupValue: _select.value,
            onChanged:_onChange,
          ),
        ),
      );
    }

    final nameField =
Padding(
  padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
  child: Container(
    width: 200,
    height: 32,
    decoration: BoxDecoration(
      color: FlutterFlowTheme.of(context).secondaryBackground,
    ),
    child: Align(
      alignment: AlignmentDirectional(0, 0),
      child: TextFormField(
        controller: textController,
        obscureText: false,
        decoration: InputDecoration(
          contentPadding:  EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
          hintText: '填寫原因',
          hintStyle: FlutterFlowTheme.of(context).bodyText2,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: FlutterFlowTheme.of(context).customColor4,
              width: 1,
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4.0),
              topRight: Radius.circular(4.0),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: FlutterFlowTheme.of(context).customColor4,
              width: 1,
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4.0),
              topRight: Radius.circular(4.0),
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0x00000000),
              width: 1,
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4.0),
              topRight: Radius.circular(4.0),
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0x00000000),
              width: 1,
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4.0),
              topRight: Radius.circular(4.0),
            ),
          ),
        ),
        style: FlutterFlowTheme.of(context).bodyText1,
        textAlign: TextAlign.start,
      ),
    ),
  ),
);

    List<Widget> lists = <Widget>[Text(options[options.length-1], style: textStyle,),]; 

    if(_select.value.compareTo(options[options.length-1]) == 0)
    {
      lists.add(nameField);
    }

    final text = Row(
      children:
        lists,
    );
    final last = 
        ListTile(
          visualDensity: VisualDensity(vertical: -3),
          title: Transform.translate(
            offset: Offset(-16, 0),
            child: text,
          ),
          leading: Radio<String>(
            value:options[options.length-1],
            groupValue: _select.value,
            onChanged:_onChange,
          ),
        );
    
    final wid = 
   
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [...radioItems, last],
    );

    return wid;
  }  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ValueListenableBuilder<String>(
      builder: _radioButtonBuilder,
      valueListenable: _select,
      )
    );
  }
}  
   