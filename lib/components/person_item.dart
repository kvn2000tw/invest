import 'package:flutter/material.dart';
import '../custom/custom_theme.dart';
import 'dart:convert';
import '../data.dart';
import '../service.dart';
import '../my_home_page.dart';
class PersonItem extends StatelessWidget {

  late MyHomePage home_page;
  late Map<String,dynamic> user;
  late GestureTapCallback logout;

  PersonItem({required this.logout});
  decodeInfo(String json)
  {
    if(json.isEmpty)    
    { 
      user = {};
      return;
    }
    Map<String,dynamic> fromJsonMap = jsonDecode(json);
    print(json);
  
    print(fromJsonMap["user"]);
    user = fromJsonMap["user"];

  }
  _goLogout() async
  {
    await Service.goLogout();
    logout();
  }
  @override
  Widget build(BuildContext context) {

    decodeInfo(Data.userInfo);
    Widget person = Image.asset(
      'assets/images/head.png',
      width: 33,
      height: 33,
      fit: BoxFit.contain,
    );

    if(user != null && user['avator'] != null  && 
      user['avator']['url'] != null)
    {
   
      person = CircleAvatar(
          radius: 15,
          backgroundImage: NetworkImage(
            '${Data.home_page}${user['avator']['url']}'
        ),
      );

    }
    return PopupMenuButton(
      constraints: BoxConstraints(
    minWidth: 56.0,
    maxWidth: 56.0,

  ),
      elevation: 0,
              shape: RoundedRectangleBorder(
                  //side: BorderSide(color: F.uiConfig.subColorA),
                  //borderRadius: BorderRadius.circular(10.w)
                  ),
              color: Colors.redAccent.withOpacity(0),//Data.member_blue,
              
      padding : const EdgeInsets.all(0.0),
      child: Container(
  width: 60,
  height: 30,
   padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 10),
  decoration: BoxDecoration(
    color: Data.white,
    //borderRadius: BorderRadius.circular(0),
    //border: Border.all(color: Colors.blueAccent)
  ),
  child: Container(
    width: 48,
    height: 30,
    decoration: BoxDecoration(
      color: Data.bar_icon_color,
      //color:Data.white,
      
      borderRadius: BorderRadius.circular(30),
      border: Border.all(
        color: Data.bar_icon_color,
      ),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: AlignmentDirectional(0, 0),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
            child: person,
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
          child: Image.asset(
            'assets/images/down.png',
            width: 12,
            height: 12,
            fit: BoxFit.cover,
          ),
        ),
      ],
    ),
  ),
),
      offset: Offset(0, 45),
      itemBuilder: (context) {
        return <PopupMenuEntry>[
           PopupMenuItem(
             padding : const EdgeInsets.only(bottom:0.0),
        
            child:Container(
  width: 62,
  height: 43,
  decoration: BoxDecoration(
    color:  FlutterFlowTheme.of(context).secondaryBackground,
    borderRadius: BorderRadius.circular(30),
    border: Border.all(
      color: FlutterFlowTheme.of(context).primaryColor,
    ),
  ),
  child: Align(
    alignment: AlignmentDirectional(0, 0),
    child: Text(
      '會員',
      style: FlutterFlowTheme.of(context).bodyText1.override(
            fontFamily: 'Poppins',
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color:Data.blue,
          ),
    ),
  ),
),
            value: 1,
          ),
          //const PopupMenuDivider(),
           PopupMenuItem(
             padding : const EdgeInsets.only(bottom:0.0),
            child: Container(
  width: 62,
  height: 43,
  decoration: BoxDecoration(
    color: FlutterFlowTheme.of(context).secondaryBackground,
    borderRadius: BorderRadius.circular(30),
    border: Border.all(
      color: FlutterFlowTheme.of(context).primaryColor,
    ),
  ),
  child: Align(
    alignment: AlignmentDirectional(0, 0),
    child: Text(
      '登出',
      style: FlutterFlowTheme.of(context).bodyText1.override(
            fontFamily: 'Poppins',
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color:Data.blue,
          ),
    ),
  ),
),

            value: 2,
          ),
        ];
      },
      onSelected: (value) {
        switch (value) {
          case 1:
            //Service.updateUsers();
            Data.update_status(Status.Member);
            Data.update_view_change();
            break;
          case 2:
            _goLogout();
         
            break;
        }
      }
    );
  }
}  