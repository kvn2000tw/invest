import 'package:flutter/material.dart';
import '../data.dart';
import 'package:provider/provider.dart';
import '../theme/theme_model.dart';
import '../custom/custom_theme.dart';

import '../service.dart';
import 'dart:convert';
import 'package:overlay_support/overlay_support.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget{

  late ThemeModel themeNotifier;
  static final ValueNotifier<String> selectedNaviItem = ValueNotifier('login');

  MyAppBar() : super();

  @override
  Size get preferredSize => const Size.fromHeight(56);

  final intro =  InkWell(
    onTap: (){
      print("intro clicked"); 
     
      Data.url = Data.intro_page;
    
      Data.update_status(Status.Introduce);
      Data.update_view_change();
    },
    child:Container(
    alignment: Alignment.center,
    height: 25.0,
    width:70,
        
    margin: EdgeInsets.all(5.0),
    decoration: BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(30)),
    color: Data.white,
    border: Border.all(width: 5, color: Data.blue),
          
    ),
    child: Text(
    '簡介',
    style: TextStyle(fontSize: 15.0,color:Data.blue),
    ),

  ));

  final read_all = Container(
    alignment: Alignment.center,
    height: 25.0,
    width:120,
        
    margin: EdgeInsets.all(5.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(30)),
      color: Data.white,
      border: Border.all(width: 5, color: Data.blue),
          
    ),
    child: Text(
      '全部已讀',
      style: TextStyle(fontSize: 15.0,color:Data.blue),
    ),

  );

  final login =   InkWell(
    onTap: (){
      print("login clicked"); 
      Data.update_view_change();
      
      Data.update_status(Status.Login);

    },
    child: Container(
    alignment: Alignment.center,
    height: 25.0,
    width:70,
        
    margin: EdgeInsets.all(5.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(30)),
      color: Data.white,
      border: Border.all(width: 5, color: Data.blue),
          
    ),
    child: Text(
      '登入',
      style: TextStyle(fontSize: 15.0,color:Data.blue),
    ),

  ));

 
  var navigate_before = Image.asset(
    'assets/navigate_before.png',
    fit: BoxFit.cover,
    height: double.infinity,
    width: double.infinity,
    alignment: Alignment.center,
  );

  var logo = Container(
    child:Image.asset(
      'assets/logo.png',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    ),
    margin:const EdgeInsets.fromLTRB(10,10,10,10),
  );
  final text1 =  Text('定錨產業筆記',
    style:TextStyle(fontSize:20,
      color:Data.orange,
    ),
    textAlign:TextAlign.left,
      
  );
  final text2 =  Text('科技產業趨勢領航者',
    style:TextStyle(fontSize:10,
      color:Data.black,
    ),
    textAlign:TextAlign.left,
      
  );

  @override
  Widget build(BuildContext context) {
    final myapp = ValueListenableBuilder<bool>(
            builder: _topNavigationBarBuilder,
            valueListenable: Data.headbar_event,
          );

    return Consumer<ThemeModel>(
        builder: (context, ThemeModel themeNotifier, child) {
          this.themeNotifier = themeNotifier;
          return myapp;
        } 
    );
  }
 
  getNotify(BuildContext context) async {
     var ret = Service.getNotify();
      ret.then((value)=>_showAlarmDialog(context,value));    
  }
    pressReturn(BuildContext context)
  {
    print('return');
    Navigator.pop(context, '');
  }

  _nonews(BuildContext context) async
  {
    print('no news');

    Data.is_alarm = false;
    Data.update_headbar_event();
    await pressReturn(context);
  }
  _readAll(BuildContext context) async
  {
    print('read all');
    Data.update_status(Status.Email);
    await pressReturn(context);
  }

  _showInfoDialog()
  {
    return;
    showSimpleNotification(

      Text(Data.token),
          //leading: NotificationBadge(totalNotifications: _totalNotifications),
          //subtitle: Text(_notificationInfo!.body!),
          background: Colors.cyan.shade700,
          duration: Duration(seconds: 20),
        );     
  }
  _showAlarmDialog(BuildContext context,String str) async {

    print('_showAlarmDialog');

    if(str.isEmpty)    return;

    Map<String,dynamic>  fromJsonMap = jsonDecode(str);

    if( fromJsonMap["no_see"].length == 0) return;
       
    print(fromJsonMap);
    var items = [];
    var sub_items = [];
    
    final lists = fromJsonMap["no_see"];
    for(final list in lists)
    {
      final arr = list["name"].split(' ');
      items.add(arr[0]);
      sub_items.add(arr[1]);
    }
    String len_str = lists.length.toString();
    String  no_see = '${len_str}封未讀信件';
     // 建立App的操作畫面
    const msg_icon = 'assets/images/msg.png';

    var listView = ListView.separated(
      itemCount: lists.length,
      itemBuilder: (context, index) =>
          ListTile(
            title: Text(items[index], style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            subtitle:Text(sub_items[index], style: const TextStyle(fontSize: 16),),
            onTap: () => {},//_selectedItem.value = '點選' + items[index],
            leading: Container(
              width:25,
              height:25,
              child: CircleAvatar(backgroundImage: AssetImage(msg_icon,),backgroundColor:Data.white),
              padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 1),
              ),
            //trailing: const Icon(Icons.keyboard_arrow_right,),
           
          ),
      separatorBuilder: (context, index) => const Divider(),
  );

    final dlg = Dialog(
      
      child:ColoredBox(
        color:Data.white,
          child: Column(
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
                    Expanded(
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Text(
                            no_see,
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Poppins',
                                      fontSize: 20,
                                      color:Data.blue,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
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
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 400,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: listView,
              ),
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: 100,
                      height: 50,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: Align(
                        alignment: AlignmentDirectional(0.15, 0),
                          child:TextButton(                    
                            style: TextButton.styleFrom(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0, 0, 0, 0),
                                textStyle: TextStyle(fontSize: 16,color:Colors.blue),
                            ),
                            child: Text(
                              '全部已讀',
                              style:TextStyle(fontSize: 20,color:Data.blue),
                              ),
                              onPressed: () => {_nonews(context)},
                          ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Align(
                          alignment: AlignmentDirectional(0.7, 0),
                          child:TextButton(                    
                            style: TextButton.styleFrom(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0, 0, 0, 0),
                                textStyle: TextStyle(fontSize: 16,color:Colors.blue),
                            ),
                            child: Text(
                              '查看全部',
                              style:TextStyle(fontSize: 20,color:Data.blue),
                              ),
                              onPressed: () => {_readAll(context)},
                          ),                        
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
    ));

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

  // 這個方法負責建立BottomNavigationBar
  Widget _topNavigationBarBuilder(BuildContext context, bool selectedButton, Widget? child) {
    print('_topNavigationBarBuilder');
    print(Data.status.value);
    var right = <Widget>[];

    String notify_str = 'assets/images/${Data.notify_image}';

    if(Data.is_alarm)
      notify_str = 'assets/images/${Data.notify_alarm_image}';

    final  notify = InkWell(
              onTap: (){
          print("alarm clicked");
          getNotify(context);
          
        },
      child:Image.asset(
      notify_str,
      fit: BoxFit.contain,
      height: 40,
      width: 40,
      alignment: Alignment.center,
    ));

    var image;

    if(Theme.of(context).colorScheme.brightness == Brightness.dark)
      image = Data.dark_image;
    else 
      image = Data.light_image;

  final dark = 
   InkWell(
        onTap: (){
          print("Dark clicked"); 
          if(Data.dark_setting == false)    return;
          int val = ThemeModel.enumConvertToConst(themeNotifier.themeMode);
          val ++;

          if(val >= 3)    val = 0;

          themeNotifier.setThemeMode(ThemeModel.constConvertToEnum(val));

        },
   child:Image.asset(
      'assets/images/${image}',
      fit: BoxFit.contain,
      height: 40,
      width: 40,
      alignment: Alignment.center,
    ));

    final person = PopupMenuButton(
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
            child: Image.asset(
              'assets/images/head.png',
              width: 33,
              height: 33,
              fit: BoxFit.contain,
            ),
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
            print('select');
            Service.updateUsers();
            break;
          case 2:

            Data.url = Data.home;
            Data.status.value = Status.Logout;
            Data.update_view_change();
            
            break;
        }
      }
    );

    right.add(dark);
    if(Data.status.value == Status.Login)
    {
      right.add(intro);
    }
    else if(Data.status.value == Status.Introduce)
    {
      right.add(login);
    }
    else if(Data.status.value == Status.Browser || Data.status.value == Status.Alarm)
    {
      right.addAll([notify,person]);
    }

    else if(Data.status.value == Status.Email)
    {
      right.addAll([notify,person]);
     
    }
    else if(Data.status.value == Status.QAnalysis)
    {
      right.addAll([notify,person]);
     
    }

    else if(Data.status.value == Status.Screener)
    {
      right.addAll([notify,person]);
     
    }
    else if(Data.status.value == Status.Price)
    {
      right.addAll([notify,person]);
     
    }
    else if(Data.status.value == Status.User)
    {
      right.addAll([notify,person]);
     
    }
    else if(Data.status.value == Status.Member)
    {
      right.addAll([notify,person]);
    } 
    else 
    {
      right.add(login);
    }

    final widget = AppBar(
      
      title:  Container(
         
      child:Column(
        children:<Widget>[text1,text2],
        mainAxisAlignment:MainAxisAlignment.start,
      ),
      alignment:Alignment.topLeft,
    ),
    centerTitle:false,
    leading: InkWell(
      child: logo,
      onTap: () => {_showInfoDialog()},//_msg.value = '你按下選單按鈕',
    ),
    automaticallyImplyLeading: false,
    //actions: <Widget>[intro],
    //actions: <Widget>[notify],
    //actions: <Widget>[read_all],
    actions: right,

    backgroundColor:Data.white,

    );
    return widget;
  }

}

