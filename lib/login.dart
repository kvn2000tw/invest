//import 'dart:ui';

import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'custom/custom_theme.dart';
import 'custom/custom_button.dart';
import 'custom/custom_button_options.dart';

import 'data.dart';

import 'package:url_launcher/url_launcher.dart';

class Login extends StatelessWidget {

  final ValueNotifier<bool> _remeber = ValueNotifier(Data.remeber.value);

  void sendEmail(BuildContext context,String email) async {

    var map = <String, String>{
     
      'email': email,
     
    };
  
    final url = Uri.parse(Data.forgot_page);
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
     
      print(fromJsonMap["error"]);
      await _showDialog(context,'訊息',fromJsonMap["error"]);

      if(fromJsonMap["error"].compareTo('請至信箱收信點擊連結重設密碼.') == 0)
      {
        Navigator.pop(context, '');
      }

    }
  }

  void login(BuildContext context,String name,String passwd) async {

    //name = 'playplus@com.tw';
    //passwd = 'p54178192';

    Data.username = name;
    Data.passwd = passwd;
    Data.remeber.value = _remeber.value;

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
        Data.status.value = Status.Browser;
        Data.view_change.value = 1;
      }

      if(fromJsonMap["status"].compareTo('error') == 0)   
      {
        _showDialog(context,'錯誤！',fromJsonMap["error"]);
      }
    }
  }
 
  _showDialog(BuildContext context,String title,String msg) async {
    var dlg = AlertDialog(
      title:Text(title),
      content: Text(msg),
      contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
    
      actions: <Widget>[
        TextButton(
          child: const Text("確定",
            style: TextStyle(color: Colors.red, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context, ''),
        ),
     
      ],
    );

    var ans = showDialog(
      context: context,
      builder: (context) => dlg,
    );

    return ans;
  }

  pressReturn(BuildContext context)
  {
    //print('return');
    Navigator.pop(context, '');
  }
  _showForgotDialog(BuildContext context) async {

    print('_showForgotDialog');
    final TextEditingController textController = TextEditingController(text:'');
   
    final dlg = Dialog(
          child: Container(
            
            width: 349,
            height: 293,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 18, 17, 0),
                  child: Container(
                    alignment:Alignment.centerRight,
                    width: double.infinity,
                    height: 30,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Padding(
                      
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      child: Container(

                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          //border: Border.all(color: Colors.blueAccent)
                        ),
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
                Container(
                  width: double.infinity,
                  height: 35,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(35, 0, 174, 0),
                    child: Container(
                      width: 140,
                      height: 35,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: Text(
                        '忘記密碼',
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                  child: Container(
                    width: 279,
                    height: 72,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 28,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                width: 25,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                ),
                                child: Image.asset(
                                  'assets/images/${Data.email}',
                                  width: 25,
                                  height: 20,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    12.5, 0, 0, 0),
                                child: Container(
                                  width: 91,
                                  height: 28,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                  ),
                                  child: Text(
                                    '會員信箱*',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Poppins',
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: Container(
                            width: 279,
                            height: 32,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                            child: TextFormField(
                              controller: textController,
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
                                        .secondaryColor,
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
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                  ),
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                  child: Container(
                    width: 164,
                    height: 48,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: FFButtonWidget(
                      onPressed: () {
                        print('Button pressed ...');
                        sendEmail(context,textController.text);
                      },
                      child: Text('確認送出'),
                      options: FFButtonOptions(
                        width: 130,
                        height: 40,
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
    );

    var willPopScope = WillPopScope(
      onWillPop: () async => false,
      child: dlg,
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
        value: _remeber.value,
        onChanged: (newValue) async {
        //print('_remeberSelectionBuilder');                             
        _remeber.value = newValue as bool;
                                            
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

    if(_remeber.value == true)
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
                color: FlutterFlowTheme.of(context).secondaryBackground,
              ),
              child:Container(
                 color:FlutterFlowTheme.of(context).customColor2,
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
                                  width: 131,
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
                                          width: 91,
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
                            width: 131,
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
                                    width: 40,
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
                                          valueListenable:_remeber,
                                      ), 

                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16, 0, 0, 0),
                                    child: Container(
                                      width: 48,
                                      height: 22,
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
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        107, 0, 0, 0),
                                    child: Container(
                                      width: 80,
                                      height: 22,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        //border: Border.all(color: Colors.blueAccent),
                                      ),
                                      child:TextButton( 
                                        
                                      style: TextButton.styleFrom(
                                         padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 0),
                                            textStyle: TextStyle(fontSize: 16,color:FlutterFlowTheme.of(context).primaryColor),
                                          ),
                                        child: const Text(
                                        '忘記密碼？',
                                        ),
                                        onPressed: () => _showForgotDialog(context),
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
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: FFButtonWidget(
                        onPressed: () {
                          print('Button pressed ...');
                          login(context,textController1.text,textController2.text);
                        },
                        child: Text('登入'),
                        options: FFButtonOptions(
                          width: 130,
                          height: 40,
                          color: FlutterFlowTheme.of(context).primaryColor,
                          textStyle:
                              FlutterFlowTheme.of(context).subtitle2.override(
                                    fontFamily: 'Poppins',
                                    color: FlutterFlowTheme.of(context).customColor2,
                                    fontWeight: FontWeight.bold,
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
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                    child: Container(
                      width: 96,
                      height: 50,
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
                              child: const Text(
                                '前往官網註冊',
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
              width: 262,
              height: 86,
              decoration: BoxDecoration(
                //color: FlutterFlowTheme.of(context).secondaryBackground,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '為何要成為定錨產業筆記的會員？',
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
