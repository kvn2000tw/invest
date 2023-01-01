//import 'dart:ui';

import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;
import '../custom/custom_theme.dart';
import '../custom/custom_button.dart';
import '../custom/custom_button_options.dart';

import 'forgot_page.dart';
import '../data.dart';

import 'package:url_launcher/url_launcher.dart';
import '../service.dart';
import 'show_dialog_wrap.dart';

class Login extends StatelessWidget {


  void serviceReturn(String ret)
  {
    print('serviceReturn');
    if(ret.isEmpty)    return;

    Map<String,dynamic>  fromJsonMap = jsonDecode(ret);
       
    print(fromJsonMap);
    if( fromJsonMap["no_see"].length > 0) 
    {
      Data.update_alarm(true);

    }

  }
  void login(BuildContext context,String name,String passwd) async {

    if(Data.name_test.compareTo('unknown') != 0)
    {
      name = Data.name_test;
      passwd = Data.passwd_test;

    }

    if(Data.remeber.value != false)
    {
      Service.setRemeberInfo(name, passwd);
    }
    
    Data.username = name;
    Data.passwd = passwd;

    var map = <String, String>{
     
      'email': name,
      'password': passwd,
    };
  
    final url = Uri.parse(Data.login_page);
    final responseOfFuture = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(map),
    );

    if (responseOfFuture.statusCode == 200) {
      print(responseOfFuture.body);
      //{"status":"success","user_token":"166745463414164","error":""}
      Map<String,dynamic> fromJsonMap = jsonDecode(responseOfFuture.body);
      print(fromJsonMap["status"]);
      if(fromJsonMap["status"].compareTo('success') == 0)    
      {
        Data.user_token = fromJsonMap["user_token"];
        Data.url = Data.register_page;
        Data.update_status(Status.Browser);
        Data.update_view_change();

        final ret = Service.getNotify();

        ret.then((value)=>serviceReturn(value));
      }

      if(fromJsonMap["status"].compareTo('error') == 0)   
      {
        _showDialog(context,'錯誤！',fromJsonMap["error"]);
      }
    }
  }
 
  _showDialog(BuildContext context,String title,String msg) async {
    
    return showDialog(
      context: context,
      builder: (context) => ShowDialogWrap(title:title,msg:msg),
    );
  }

  pressReturn(BuildContext context)
  {
    //print('return');
    Navigator.pop(context, '');
  }
  _showForgotDialog(BuildContext context) async {

    print('_showForgotDialog');

    var willPopScope = WillPopScope(
      onWillPop: () async => false,
      child: ForgotPage(),
    );

    var ans = showDialog(
      context: context,
      builder: (context) => willPopScope,
    );

    return ans;  
  }
 

  Widget _remeberSelectionBuilder(BuildContext context, bool remeber,Widget? child)
  {
    Widget widget =  Checkbox(
        value: Data.remeber.value,
        onChanged: (newValue) async {
        //print('_remeberSelectionBuilder');                             
        Data.remeber.value = newValue as bool;
        Service.setRemeber(Data.remeber.value);
                                            
        },
        activeColor:
        FlutterFlowTheme.of(context)
            .checkColor,
        );

    return widget;

  }
  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  _gotoRegPage()async {
    //Data.status.value = Status.Register;
    
    var uri = Uri.parse(Data.register_app_page);
    _launchInBrowser(uri);
    return;
    
  }
  @override
  Widget build(BuildContext context) {
    //print('build');
    //print(MediaQuery.of(context).size.width);
    //print(MediaQuery.of(context).size.height);
  
    String _input_name = '';
  
    String _input_passwd = '';

    if(Data.remeber.value == true)
    {
      _input_name = Data.username;
      _input_passwd = Data.passwd;

    }
    final TextEditingController textController1 = TextEditingController(text:_input_name);
    final TextEditingController textController2 = TextEditingController(text:_input_passwd);
    
    textController1.value = TextEditingValue(
      text:_input_name,
      selection:TextSelection.collapsed(offset:_input_name.length),
    );

    textController2.value = TextEditingValue(
      text:_input_passwd,
      selection:TextSelection.collapsed(offset:_input_passwd.length),
    );

    return 
    Container(
      constraints: BoxConstraints.expand(),
       
     color:FlutterFlowTheme.of(context).customColor1,
      child:
    SingleChildScrollView(
      child:Container(
         
        color:FlutterFlowTheme.of(context).customColor1,
        child:Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: double.infinity,
            height: 168,
            child: Stack(
              children: [
                Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: Image.asset(
                    'assets/images/img_banner.png',
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.fill,
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0, 0),
                  
                  child:Container(
                    
                    width: 120,
                    height: 42,
                    //decoration: BoxDecoration(
                    //  //color: FlutterFlowTheme.of(context).secondaryBackground,
                    //),
                    decoration: BoxDecoration(
                      //border: Border.all(color: Colors.blueAccent)
                    ),
                    child:Text(
                      '會員登入',
                   
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            color: FlutterFlowTheme.of(context).customColor2,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(22, 22, 22, 0),
            child: Container(
              width: double.infinity,
              height: 434,
              decoration: BoxDecoration(
                color: Data.white,
                
              ),
              child:Container(
                 color:FlutterFlowTheme.of(context).secondaryBackground,
              child:Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                    child: Container(
                      width: 279,
                      height: 208,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 72,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 200,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                        ),
                                        child: Image.asset(
                                          'assets/images/${Data.email}',
                                          width: 25,
                                          height: 20,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10, 0, 0, 0),
                                        child: Container(
                                          width: 150,
                                          height: 28,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                            ),
                                            child: Text(
                                              '電子郵件*',
                                              style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                              fontFamily: 'Poppins',
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 10, 0, 0),
                                  child: Container(
                                    width: 263,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                    ),
                                    child: TextFormField(
                                      controller: textController1,
                                      autofocus: false,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        hintStyle: FlutterFlowTheme.of(context)
                                            .bodyText2,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .customColor4,
                                            width: 1,
                                          ),
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(4.0),
                                            topRight: Radius.circular(4.0),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .customColor4,
                                            width: 1,
                                          ),
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(4.0),
                                            topRight: Radius.circular(4.0),
                                          ),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .customColor3,
                                            width: 1,
                                          ),
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(4.0),
                                            topRight: Radius.circular(4.0),
                                          ),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .customColor3,
                                            width: 1,
                                          ),
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(4.0),
                                            topRight: Radius.circular(4.0),
                                          ),
                                        ),
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 200,
                            height: 30,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                  ),
                                  child: Image.asset(
                                    'assets/images/${Data.key}',
                                    width: 27.5,
                                    height: 15,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 0, 0),
                                  child: Container(
                                    width: 100,
                                    height: 28,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                    ),
                                    child: Text(
                                      '密碼',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            width: 263,
                            height: 32,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                            child: TextFormField(
                              controller: textController2,
                              autofocus: false,
                              obscureText: false,
                              decoration: InputDecoration(
                                hintStyle:
                                    FlutterFlowTheme.of(context).bodyText2,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context)
                                        .customColor4,
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context)
                                        .customColor4,
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context)
                                                .customColor3,
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context)
                                                .customColor3,
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                              ),
                              style: FlutterFlowTheme.of(context).bodyText1,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                            child: Container(
                              width: 279,
                              height: 24,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 18,
                                    height: 18,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: FlutterFlowTheme.of(context)
                                          .customColor5),
                                      //color: FlutterFlowTheme.of(context)
                                      //    .primaryColor,
                                    ),
                                    child: Theme(
                                      data: ThemeData(
                                        checkboxTheme: CheckboxThemeData(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(0),
                                          ),
                                        ),
                                        unselectedWidgetColor:
                                            FlutterFlowTheme.of(context)
                                                .customColor4,
                                      ),
                                      child:ValueListenableBuilder<bool>(
                                          builder:_remeberSelectionBuilder,
                                          valueListenable:Data.remeber,
                                      ), 

                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16, 0, 0, 0),
                                    child: Container(
                                      width: 80,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                      ),
                                      child: Text(
                                        '記住我',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Poppins',
                                              fontSize: 16,
                                            ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: AlignmentDirectional(1, 0),
                                      child: Container(
                                        width: 100,
                                        height: 24,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context).secondaryBackground,
                                        ),
                                        child: Text(
                                          '忘記密碼？',
                                          style: FlutterFlowTheme.of(context).bodyText1.override(
                                            fontFamily: 'Poppins',
                                            color: FlutterFlowTheme.of(context).primaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                    child: Container(
                      width: 132,
                      height: 46,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          print('Button pressed ...');
                          login(context,textController1.text,textController2.text);
                        },
                        child: Text('登入'),
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(Data.blue),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                    child: Container(
                
                      height: 60,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            '還不是會員？',
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          Expanded(
                          child:TextButton( 
                              style: TextButton.styleFrom(
                              padding: EdgeInsetsDirectional.fromSTEB(
                              0, 0, 0, 0),
                              textStyle: TextStyle(fontSize: 16,color:FlutterFlowTheme.of(context).primaryColor),
                              ),
                              child: Text(
                                '前往官網註冊',
                                style:TextStyle(fontSize: 16,color:Data.blue),
                              ),
                              onPressed: () => _gotoRegPage(),
                          )),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
 
            child: Container(
            width: 300,
            //height: 100,
            decoration: BoxDecoration(
              color: Data.white,
            ),
    
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text(
                '為何要成為定錨產業筆記的會員？',
                textAlign: TextAlign.start,
                style: FlutterFlowTheme.of(context).bodyText1.override(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '‧ 產業深度分析：讓您的投資更前瞻！',
                style: FlutterFlowTheme.of(context).bodyText1.override(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                ),
              ),
              Text(
                '‧ 即時法說會簡評：讓您快速掌握公司經營動態！',
              style: FlutterFlowTheme.of(context).bodyText1.override(
                fontFamily: 'Poppins',
                fontSize: 12,
              ),
              maxLines:2    
            ),
            Text(
              '‧ 內容含金量No.1：有效提升投資成績！',
              style: FlutterFlowTheme.of(context).bodyText1.override(
                fontFamily: 'Poppins',
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    ),

        ],
      ))));
  }
}
