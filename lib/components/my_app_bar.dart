import 'package:flutter/material.dart';
import '../data.dart';
import 'package:provider/provider.dart';
import '../theme/theme_model.dart';
import 'person_item.dart';

import '../service.dart';
import 'dart:convert';

import 'alarm_msg.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget{

  late ThemeModel themeNotifier;
  static final ValueNotifier<String> selectedNaviItem = ValueNotifier('login');
  
  late GestureTapCallback init;
  late GestureTapCallback logout;
  late GestureTapCallback loadUrl;

  MyAppBar({
  required this.init,
  required this.logout,
  required this.loadUrl,
  }) : super();
  
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
        
    margin: EdgeInsets.fromLTRB(15,5,5,5),//
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

  _showInfoDialog(BuildContext context)
  {
     var dlg = AlertDialog(
      content: Text(Data.token),
      contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      contentTextStyle: TextStyle(color: Data.black, fontSize: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      actions: <Widget>[
        TextButton(
          child: const Text(
            "ok",
            style: TextStyle(color: Colors.blue, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context, 1),
        ),
      ],
    );

    var ans = showDialog(
      context: context,
      builder: (context) => dlg,
    );

    return ans;
    return;
  
  }
  _showNoMsgDialog(BuildContext context)async
  {
    var dlg = AlertDialog(
      title:const Text('訊息'),
      content: const Text('無新訊息'),
      actions: <Widget>[
        TextButton(
          child: const Text(
            "OK",
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );

    var ans = showDialog(
      context: context,
      builder: (context) => dlg,
    );

  }
  _showAlarmDialog(BuildContext context,String str) async {

    print('_showAlarmDialog');

    if(str.isEmpty) 
    {
      _showNoMsgDialog(context);
      return;
    }
    Map<String,dynamic>  fromJsonMap = jsonDecode(str);
    List<String> items = [];
    List<String> sub_items = [];   
    List<String> nos = [];

    if( fromJsonMap["no_see"].length == 0) 
    {
       _showNoMsgDialog(context);
      return;
      /*
      items.add('abc');
      sub_items.add('def 1234T1234:1234');
      nos.add('1672646533958');
  */
    }  
    else 
    {
    final lists = fromJsonMap["no_see"];
    
    for(final list in lists)
    {
      final arr = list["name"];
      items.add(arr);
      final arr1 = list["posted_at"];
      sub_items.add(arr1);
      nos.add(list["no"]);
      
    }     
    }
 
    String len_str = items.length.toString();
    String  no_see = '${len_str}封未讀信件';
     // 建立App的操作畫面
   
  final dlg = AlarmMsg(no_see,items,sub_items,nos,loadUrl);

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
        
    margin: EdgeInsets.fromLTRB(15,5,5,5),
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
      
      child:Container(
      margin:EdgeInsets.fromLTRB(15,5,5,5),
      child:Image.asset(
      notify_str,
      fit: BoxFit.contain,
      height: 40,
      width: 40,
      alignment: Alignment.center,
    )));

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
   child:Container(
    margin:EdgeInsets.fromLTRB(15,5,5,5),
   child:Image.asset(
      'assets/images/${image}',
      fit: BoxFit.contain,
      height: 40,
      width: 40,
      alignment: Alignment.center,
    )));


    final person = Container(
      margin:EdgeInsets.only(left:15,right:5),
      child:PersonItem(logout:logout),
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
      onTap: () => {_showInfoDialog(context)},//_msg.value = '你按下選單按鈕',
    ),
    automaticallyImplyLeading: false,
  
    actions: right,

    backgroundColor:Data.white,

    );
    return widget;
  }
  
  goLogin()async
  {
    init();
    Data.update_status(Status.Login);
    Data.update_view_change();
  }
}

