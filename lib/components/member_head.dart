import 'package:flutter/material.dart';
import '../custom/custom_button_options.dart';
import '../custom/custom_theme.dart';
import '../data.dart';
import '../service.dart';
import '../custom/custom_button.dart';
import 'show_dialog_wrap.dart';
import 'to_return_page.dart';
class MemberHead extends StatelessWidget {

  late Map<String,dynamic> user;
  late String pay_title;

  MemberHead(Map<String,dynamic> user,String pay_title)
  {
    this.user = user;
    this.pay_title = pay_title;
    
  }
  _showDialog(BuildContext context,String title,String msg) async {
    
    return showDialog(
      context: context,
      builder: (context) => ShowDialogWrap(title:title,msg:msg),
    );
  }

  _runToReturn(BuildContext context)async
  {
  
    var willPopScope = WillPopScope(
      onWillPop: () async => false,
      child: ToReturnPage(),
    );

    var ans = showDialog(
      context: context,
      builder: (context) => willPopScope,
    );

    return ans;  

  }
  goLogout()async
  {
    await Service.goLogout();
    Data.update_status(Status.Introduce);
    Data.update_view_change();
  }
  @override
  Widget build(BuildContext context) {
    final title1 =  Align(
                alignment: AlignmentDirectional(0, 0),
                child: Container(
                  width: double.infinity,
                  height: 141,
                  decoration: BoxDecoration(
                    color: Data.member_blue,
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: Container(
                          width: 350,
                          height: 87,
                          decoration: BoxDecoration(
                            color: Data.member_blue,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                child: Container(
                                  width: 350,
                                  height: 31,
                                  decoration: BoxDecoration(
                                    color:Data.member_blue,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            20, 0, 0, 0),
                                        child: Container(
                                          width: 18,
                                          height: 18,
                                          decoration: BoxDecoration(
                                            color: Data.member_blue,
                                          ),
                                          child: CircleAvatar(
                                            radius: 15,
                                            backgroundImage: NetworkImage(
                                            '${Data.home}${user['avator']['url']}'
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            8, 0, 0, 0),
                                        child: Text(
                                          user['plan']??'加值版會員',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Poppins',
                                                color:Data.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: 350,
                                height: 46,
                                decoration: BoxDecoration(
                                  color:
                                      Data.member_blue,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          20, 0, 0, 0),
                                      child: Container(
                                        width: 120,
                                        height: 46,
                                        decoration: BoxDecoration(
                                          color: Data.member_blue,
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Align(
                                              alignment:
                                                  AlignmentDirectional(-1, 0),
                                              child: Text(
                                                '姓名',
                                                textAlign: TextAlign.start,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          color: Data.white,
                                                          fontSize: 12,
                                                        ),
                                              ),
                                            ),
                                            Align(
                                              alignment:
                                                  AlignmentDirectional(-1, 0),
                                              child: Text(
                                                user['name'],
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          color:Data.white,
                                                          fontSize: 17,
                                                        ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional(0.05, 0),
                                      child: Container(
                                        width: 190,
                                        height: 46,
                                        decoration: BoxDecoration(
                                          color:Data.member_blue,
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Align(
                                              alignment:
                                                  AlignmentDirectional(-1, 0),
                                              child: Text(
                                                '暱稱（留言用）',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          color:Data.white,
                                                          fontSize: 12,
                                                        ),
                                              ),
                                            ),
                                            Align(
                                              alignment:
                                                  AlignmentDirectional(-1, 0),
                                              child: Text(
                                                user['nick_name'],
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          color: Data.white,
                                                          fontSize: 17,
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
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: Container(
                          width: 350,
                          height: 24,
                          decoration: BoxDecoration(
                            color: Data.member_blue,
                          ),
                          child: Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20, 0, 0, 0),
                                  child: Container(
                                    width: 87,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: Data.member_blue,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Container(
                                          width: 18,
                                          height: 18,
                                          decoration: BoxDecoration(
                                            color: Data.member_blue,
                                          ),
                                          child: Image.asset(
                                            'assets/images/key-w.png',
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  5, 0, 0, 0),
                                          child: Text(
                                            '修改密碼',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'Poppins',
                                                  color: Data.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20, 0, 0, 0),
                                  child: Container(
                                    width: 87,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: Data.member_blue,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Container(
                                          width: 18,
                                          height: 18,
                                          decoration: BoxDecoration(
                                            color: Data.member_blue,
                                          ),
                                          child: Image.asset(
                                            'assets/images/person.png',
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  5, 0, 0, 0),
                                          child: Text(
                                            '個人資料',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'Poppins',
                                                  color: Data.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20, 0, 0, 0),
                                  child: 
                                   InkWell(
                                  child:Container(
                                    width: 87,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: Data.member_blue,
                                    ),
                                    child: Align(
                                      alignment: AlignmentDirectional(-0.05, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Container(
                                            width: 18,
                                            height: 18,
                                            decoration: BoxDecoration(
                                              color:
                                                  Data.member_blue,
                                            ),
                                            child: Image.asset(
                                              'assets/images/logout.png',
                                              width: 100,
                                              height: 100,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                          Expanded(
                                            child: Align(
                                              alignment:
                                                  AlignmentDirectional(0, 0),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(5, 0, 0, 0),
                                                child: Text(
                                                  '會員登出',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: 'Poppins',
                                                        color: Data.white,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                 onTap: () => {goLogout()},//_msg.value = '你按下選單按鈕',
                                  ),),
                              ],
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
  height: 286,
  decoration: BoxDecoration(
    color: FlutterFlowTheme.of(context).memberBackgrondColor,
    
  ),
  child: Align(
    alignment: AlignmentDirectional(0, 0),
    child: Container(
      width: 350,
      height: 286,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Align(
            alignment: AlignmentDirectional(0, 0),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 15),
              child: Text(
                '付款資訊',
                style: FlutterFlowTheme.of(context).bodyText1.override(
                      fontFamily: 'Poppins',
                      fontSize: 25,
                    ),
              ),
            ),
          ),
          Container(
            width: 350,
            height: 172,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              border: Border(
           
              top: BorderSide(width: 1.0, color: Data.borderColor),
            ),
            ),
            child: Align(
              alignment: AlignmentDirectional(0, 0),
              child: Container(
                width: 290,
                height: 92,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Align(
                      alignment: AlignmentDirectional(-1, 0),
                      child: Container(
                        width: 243,
                        height: 31,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context)
                              .secondaryBackground,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: 63,
                              height: 29,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              child: Text(
                                '加值版',
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Poppins',
                                      fontSize: 21,
                                    ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                              child: Text(
                                'NT\$ 399.00 / 月',
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Poppins',
                                      fontSize: 22,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                      child: Container(
                        width: 290,
                        height: 41,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context)
                              .secondaryBackground,
                           border: Border(
           
                            top: BorderSide(width: 1.0, color: Data.grey),
                          ),    
                        ),
                        child: Align(
                          alignment: AlignmentDirectional(-1, 0),
                          child: Text(
                            pay_title,
                            style: FlutterFlowTheme.of(context)
                                .bodyText1
                                .override(
                                  color:Data.grey,
                                  fontFamily: 'Poppins',
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: AlignmentDirectional(0, 0.05),
              child: Container(
                width: 350,
                height: 49,
                decoration: BoxDecoration(
                  color: Data.yellow,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: FFButtonWidget(
                  onPressed: () {
                    _runToReturn(context);
                    print('Button pressed ...');
                  },
                text: '取消訂閱',
                options: FFButtonOptions(
                width: 130,
                height: 40,
                color: Data.yellow,
                  textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontSize: 18,
                ),
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
            ),

              ),
            ),
          ),
        ],
      ),
    ),
  ),
);
  return Column(
    children:[title1,title2],
  );
  
  }
}