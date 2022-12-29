import 'package:flutter/material.dart';

import '../custom/custom_theme.dart';

import '../data.dart';
import 'mail_list.dart';

class MailBox extends StatelessWidget {

var trans = ['TAG'];
  @override
  Widget build(BuildContext context) {
    final TextEditingController textController = TextEditingController(text:'');
    bool? checkboxListTileValue;

    final title1 =Padding(
  padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
  child: Container(
    width: 390,
    height: 51,
    decoration: BoxDecoration(
      color: FlutterFlowTheme.of(context).secondaryBackground,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(
          alignment: AlignmentDirectional(0, 0),
          child: Container(
            width: 60,
            height: 41,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
            ),
            child: Container(
              width: 30,
              height: 21,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                 border: Border(
           
                  bottom: BorderSide(width: 3.0, color: Data.borderColor),
          ),
              ),
              child: Align(
                alignment: AlignmentDirectional(0, 0),
                child: Text(
                  '總覽',
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        color:Data.blue,
                      ),
                ),
              ),
            ),
          ),
        ),
        Container(
          width: 60,
          height: 41,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
          ),
          child: Container(
            width: 30,
            height: 21,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
            ),
            child: Align(
              alignment: AlignmentDirectional(0, 0),
              child: Text(
                '週報',
                style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                ),
              ),
            ),
          ),
        ),
        Container(
          width: 90,
          height: 41,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
          ),
          child: Align(
            alignment: AlignmentDirectional(0, 0),
            child: Text(
              '產業報告',
              style: FlutterFlowTheme.of(context).bodyText1.override(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ),
        Container(
          width: 90,
          height: 41,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
          ),
          child: Align(
            alignment: AlignmentDirectional(0, 0),
            child: Text(
              '個股報告',
              style: FlutterFlowTheme.of(context).bodyText1.override(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ),
      ],
    ),
  ),
);


      final title2 =Container(
  width: 390,
  height: 50,
  decoration: BoxDecoration(
    color: FlutterFlowTheme.of(context).secondaryBackground,
  ),
  child: Row(
    mainAxisSize: MainAxisSize.max,
    children: [
      Padding(
        padding: EdgeInsetsDirectional.fromSTEB(41, 0, 0, 0),
        child: Container(
          width: 54,
          height: 21,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 21,
                height: 21,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: Image.asset(
                  'assets/images/star.png',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                width: 30,
                height: 21,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: Text(
                  '最愛',
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
      Padding(
        padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
        child: Container(
          width: 140,
          height: 30,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            //border: Border.all(color: Colors.blueAccent)
          ),
          child: Align(
  alignment: AlignmentDirectional(0, 0),
  child: TextFormField(
    controller: textController,
    obscureText: false,
    decoration: InputDecoration(
      hintText: '搜尋郵件',
      hintStyle: FlutterFlowTheme.of(context).bodyText2,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Data.black,
          width: 1,
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(4.0),
          topRight: Radius.circular(4.0),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Data.black,
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
      contentPadding: EdgeInsetsDirectional.fromSTEB(5, 5, 0, 0),
    ),
    style: FlutterFlowTheme.of(context).bodyText1,
    textAlign: TextAlign.start,
  ),
)
,
        ),
      ),
      Padding(
        padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
        child: Container(
          width: 64,
          height: 30,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
          ),
          child: DropdownButton(
      items: <DropdownMenuItem> [
        DropdownMenuItem(
          child: Text(trans[0], style: const TextStyle(fontSize: 14),),
          value: 0,
        ),
     
      ],
      onChanged: (dynamic value) => {},
      hint: const Text('TAG', style: TextStyle(fontSize: 14),),
      value: 0,//selectedItem < 0 ? null : selectedItem,
    ),
        ),
      ),
      Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
        ),
        child: Image.asset(
          'assets/images/search.png',
          width: 100,
          height: 100,
          fit: BoxFit.contain,
        ),
      ),
    ],
  ),
);


  final tail = Align(
  alignment: AlignmentDirectional(0, 0),
  child: Container(
    width: 390,
    height: 80,
    decoration: BoxDecoration(
      color: FlutterFlowTheme.of(context).secondaryBackground,
    ),
    child: Align(
      alignment: AlignmentDirectional(0, 0),
      child: Container(
        width: 159,
        height: 80,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: 40,
              height: 38,
              decoration: BoxDecoration(
                color: Data.blue,
              ),
              child: Align(
                alignment: AlignmentDirectional(0, 0),
                child: Text(
                  '1',
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.normal,
                      ),
                ),
              ),
            ),
            Container(
              width: 40,
              height: 38,
              decoration: BoxDecoration(
                color: Data.mail_white,
              ),
              child: Align(
                alignment: AlignmentDirectional(0, 0),
                child: Text(
                  '2',
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Poppins',
                        color: Colors.blue,
                        fontSize: 13,
                        fontWeight: FontWeight.normal,
                      ),
                ),
              ),
            ),
            Container(
              width: 79,
              height: 40,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    '下一頁',
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Poppins',
                          color: FlutterFlowTheme.of(context).primaryColor,
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                  Image.asset(
                    'assets/images/chevron_right.png',
                    width: 20,
                    height: 20,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  ),
);

    var items = <Widget>[title1,title2,MailList(),
      MailList(star:true),MailList(is_bg_white: true,),MailList(),MailList(),
     MailList(is_bg_white: true),MailList(star:true),MailList(is_bg_white: true),MailList(),
     MailList(),MailList(),MailList(star:true),MailList(),
      MailList(),MailList(),MailList(),MailList(star:true),
      MailList(),MailList(),MailList(star:true),MailList(),
      MailList(),MailList(),MailList(),MailList(),tail];
    final listView = ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: items.length,//listItems.length,
      itemBuilder: (context, index) =>
      InkWell(
      child:items[index],           
      onTap:()=>{print(index)},
      )
       
    );

    return 
      Column(
        mainAxisSize: MainAxisSize.max,
        children:[
          Expanded(child:
          listView
          )
        ],
      );
    }
}
