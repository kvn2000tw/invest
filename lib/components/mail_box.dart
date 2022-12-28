import 'package:flutter/material.dart';

import '../custom/custom_theme.dart';

import 'button_ele.dart';
import 'member_list.dart';

class MailBox extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final TextEditingController textController = TextEditingController(text:'');
    bool? checkboxListTileValue;

    final title1 = Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
      child: Container(
      width: 390,
      height: 51,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
            ButtonEle(
              width:60,
              height:41,
           
              text:'總覽',
              fontSize:15,
            ),
            ButtonEle(
              width:60,
              height:41,
             
              text:'週報',
              fontSize:15,
            ),
           ButtonEle(
              width:90,
              height:41,
            
              text:'產業報告',
              fontSize:15,
              fontWeight: FontWeight.w600,
            ),    
           ButtonEle(
              width:90,
              height:41,
            
              text:'個股報告',
              fontSize:15,
              fontWeight: FontWeight.w600,
            ),                             
            ],
          ),
        ),
      );

      final title2 = Container(
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
                    color:
                    FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: 21,
                        height: 21,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                        ),
                        child: Image.asset(
                          'assets/images/star.png',
                             
                            fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: 30,
                        height: 21,
                        decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                        ),
                        child: Text(
                          '最愛',
                          style: FlutterFlowTheme.of(context)
                            .bodyText1
                            .override(
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
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                      ),
                    ),
                    Container(
                      width: 64,
                      height: 30,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
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

    var items = <Widget>[title1,title2,MemberList(),
      MemberList(),MemberList(),MemberList(),MemberList(),
      MemberList(),MemberList(),MemberList(),MemberList(),
      MemberList(),MemberList(),MemberList(),MemberList(),
      MemberList(),MemberList(),MemberList(),MemberList(),
      MemberList(),MemberList(),MemberList(),MemberList(),
      MemberList(),MemberList(),MemberList(),MemberList()];
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
