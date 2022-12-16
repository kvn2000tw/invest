import 'package:flutter/material.dart';
import 'Data.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget{

  static final ValueNotifier<String> selectedNaviItem = ValueNotifier('login');

  MyAppBar() : super();

  @override
  Size get preferredSize => const Size.fromHeight(56);

  final intro = Container(
    alignment: Alignment.center,
    height: 25.0,
    width:70,
        
    margin: EdgeInsets.all(5.0),
    decoration: BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(30)),
    color: Colors.white,
    border: Border.all(width: 5, color: Colors.blue),
          
    ),
    child: Text(
    '簡介',
    style: TextStyle(fontSize: 15.0,color:Colors.blue),
    ),

  );
  final read_all = Container(
    alignment: Alignment.center,
    height: 25.0,
    width:120,
        
    margin: EdgeInsets.all(5.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(30)),
      color: Colors.white,
      border: Border.all(width: 5, color: Colors.blue),
          
    ),
    child: Text(
      '全部已讀',
      style: TextStyle(fontSize: 15.0,color:Colors.blue),
    ),

  );

  final login = Container(
    alignment: Alignment.center,
    height: 25.0,
    width:120,
        
    margin: EdgeInsets.all(5.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(30)),
      color: Colors.white,
      border: Border.all(width: 5, color: Colors.blue),
          
    ),
    child: Text(
      '登入',
      style: TextStyle(fontSize: 15.0,color:Colors.blue),
    ),

  );

  var notify = Container(
    child:Image.asset(
      'assets/notifications.png',
     
    ),
    margin:const EdgeInsets.fromLTRB(10,10,10,10),
  );
 
 var person = Container(
    child:Image.asset(
      'assets/group_1.png',
     
    ),
    margin:const EdgeInsets.fromLTRB(10,10,10,10),
  );
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
  final text1 = const Text('定錨產業筆記',
    style:TextStyle(fontSize:20,
      color:Colors.orange,
    ),
    textAlign:TextAlign.left,
      
  );
  final text2 = const Text('科技產業趨勢領航者',
    style:TextStyle(fontSize:10,
      color:Colors.black,
    ),
    textAlign:TextAlign.left,
      
  );

  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder<Status>(
          builder: _topNavigationBarBuilder,
          valueListenable: Data.status,
        );
 
  }

  // 這個方法負責建立BottomNavigationBar
  Widget _topNavigationBarBuilder(BuildContext context, Status selectedButton, Widget? child) {
   
    var right = <Widget>[];

    if(Data.status.value == Status.Login)
    {
      right.add(intro);
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
      onTap: () => {},//_msg.value = '你按下選單按鈕',
    ),
    automaticallyImplyLeading: false,
    //actions: <Widget>[intro],
    //actions: <Widget>[notify],
    //actions: <Widget>[read_all],
    actions: right,

    backgroundColor:Colors.white,

    );
    return widget;
  }

}

