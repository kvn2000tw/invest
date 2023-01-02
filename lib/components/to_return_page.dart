
import 'package:flutter/material.dart';
import '../custom/custom_theme.dart';
import '../custom/custom_button.dart';
import '../custom/custom_button_options.dart';
import '../custom/custom_button_position.dart';
import '../custom/custom_radiobutton.dart';

import '../service.dart';
import '../data.dart';

class ToReturnPage extends StatelessWidget {

  TextEditingController textController = TextEditingController();

  String return_reason = '內容艱澀難以理解';
  
  late String title;
  late String msg ;
  ShowDialogWrap({String title='',String msg=''})
  {
    this.title = title;
    this.msg = msg;
  }
  _onChange(String val)
  {
    return_reason = val;
  }
  doCancel(BuildContext context)
  {
    Navigator.pop(context, '');
    Service.toReturn(
      return_reason:return_reason,
      other_reason:textController.text,
    );
  }

  pressReturn(BuildContext context)
  {
    Navigator.pop(context, '');
  }
@override
  Widget build(BuildContext context) {

    return Dialog(
     child:SingleChildScrollView(
      child:Column(
  mainAxisSize: MainAxisSize.min,
  children: [
    Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Align(
            alignment: AlignmentDirectional(0, -0.6),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
              child: Text(
                '退訂原因',
                style: FlutterFlowTheme.of(context).bodyText1.override(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: AlignmentDirectional(0.85, -0.6),
              child: Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: TextButton(
                          child: Text(
                            'X',
                            style: TextStyle(fontSize: 20, color: FlutterFlowTheme.of(context).customColor6),
                          ),
                          style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                          ),
                          onPressed: () => pressReturn(context),
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
    Padding(
      padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
        ),
        child: Text(
          '噢不！我們真的不希望您離開！如果可以，請協助填寫您取消訂閱的原因，作為未來我們持續優化服務的參考',
          style: FlutterFlowTheme.of(context).bodyText1.override(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
        ),
      ),
    ),
    Container(
      width: double.infinity,
      height: 360,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
      ),
      child: Align(
        alignment: AlignmentDirectional(-0.8, 0),
        child: FlutterFlowRadioButton(
          options: [
            '內容艱澀難以理解',
            '缺乏技術/籌碼面分析',
            '投資建議不夠明示',
            '暫時離開市場無投資需求',
            '定價過高無法負擔',
            '研究方向不符需求',
            '更換信用卡',
            '其他'
          ].toList(),
          textController:textController,
          onChanged: (val) => {_onChange(val)},
          optionHeight: 25,
          textStyle: FlutterFlowTheme.of(context).bodyText1.override(
                fontFamily: 'Poppins',
                color: Data.black,
              ),
          buttonPosition: RadioButtonPosition.left,
          direction: Axis.vertical,
          radioButtonColor: Colors.blue,
          inactiveRadioButtonColor: Color(0x8A000000),
          toggleable: false,
          horizontalAlignment: WrapAlignment.start,
          verticalAlignment: WrapCrossAlignment.start,
        ),
      ),
    ),
Align(
  alignment: AlignmentDirectional(0, 0),
  child: Padding(
    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Align(
            alignment: AlignmentDirectional(0.85, 0),
            child: Container(
              width: 200,
              height: 30,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  FFButtonWidget(
                    onPressed: () {
                       doCancel(context);
                    },
                    text: '確定取消',
                    options: FFButtonOptions(
                      width: 90,
                      height: 30,
                      color: FlutterFlowTheme.of(context).alternate,
                      textStyle:
                          FlutterFlowTheme.of(context).subtitle2.override(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                              ),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: FFButtonWidget(
                        onPressed: () {
                           pressReturn(context);
                        },
                        text: '繼續訂閱',
                        options: FFButtonOptions(
                          width: 90,
                          height: 30,
                          color: FlutterFlowTheme.of(context).primaryColor,
                          textStyle:
                              FlutterFlowTheme.of(context).subtitle2.override(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                  ),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  ),
),

  ],
)));

  }
}
