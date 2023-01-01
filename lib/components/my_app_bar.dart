import 'package:flutter/material.dart';
import '../data.dart';
import 'package:provider/provider.dart';
import '../theme/theme_model.dart';
import '../custom/custom_theme.dart';

import '../service.dart';
import 'dart:convert';
import '../my_home_page.dart';
import 'alarm_msg.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget{

  late ThemeModel themeNotifier;
  static final ValueNotifier<String> selectedNaviItem = ValueNotifier('login');
  late MyHomePage home_page;
  MyAppBar(MyHomePage home_page) : super()
  {
    this.home_page = home_page;
  }

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

    Navigator.pop(context, '');
  }

  _showInfoDialog()
  {
    return;
  
  }
  _showAlarmDialog(BuildContext context,String str) async {

    print('_showAlarmDialog');

    if(str.isEmpty)    return;

    Map<String,dynamic>  fromJsonMap = jsonDecode(str);

    if( fromJsonMap["no_see"].length == 0) return;
       
    print(fromJsonMap);
   
    final lists = fromJsonMap["no_see"];
    List<String> items = [];
    List<String> sub_items = [];
    
    for(final list in lists)
    {
      final arr = list["name"];
      items.add(arr);
      final arr1 = list["posted_at"];
      sub_items.add(arr1);
      
    }
    String len_str = lists.length.toString();
    String  no_see = '${len_str}封未讀信件';
     // 建立App的操作畫面
   
  final dlg = AlarmMsg(no_see,items,sub_items);

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

  final login =   InkWell(
    onTap: (){
      print("login clicked");
      goLogin(); 

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
            Service.updateUsers();
            break;
          case 2:
            goLogout();
         
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
    else if(Data.status.value == Status.Browser || Data.is_alarm)
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
  
    actions: right,

    backgroundColor:Data.white,

    );
    return widget;
  }
  goLogout() async
  {
    await Service.goLogout();
    home_page.goLogout();
  }
  goLogin()async
  {
    home_page.init_controll();
    Data.update_status(Status.Login);
    Data.update_view_change();
  }
}

