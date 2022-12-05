import 'package:flutter/material.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget{

  MyAppBar() : super();

  @override
  Size get preferredSize => const Size.fromHeight(56);


  @override
  _MyAppBarState createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  // BottomNavigationBar顯示的圖示和文字
    var intro_text = Center(
      child:Text(
        "簡介",
        style:TextStyle(fontSize:15,
                        color:Colors.blue,
                        fontWeight:FontWeight.bold),
      ),
    
    );

    final intro1 = Container(
        color: Colors.amberAccent,
        alignment: Alignment.center,
        child:  DecoratedBox(
            decoration: BoxDecoration(
                //gradient: LinearGradient(colors:[Colors.red,Colors.orange[700]]), //背景渐变
                borderRadius: BorderRadius.circular(3.0), //3像素圆角
                boxShadow: [ //阴影
                  BoxShadow(
                      color:Colors.black54,
                      offset: Offset(2.0,2.0),
                      blurRadius: 4.0
                  )
                ]
            ),
            child: Padding(padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 18.0),
              child: Text("Login", style: TextStyle(color: Colors.white),),
            )
        )
      );

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
          '登入/註冊',
          style: TextStyle(fontSize: 15.0,color:Colors.blue),
        ),

    );

     var notify = Image.asset(
      'assets/notifications.png',
    );


    var navigate_before = Image.asset(
      'assets/navigate_before.png',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );

    var logo = Image.asset(
      'assets/logo.png',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
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
    return AppBar(
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
      actions: <Widget>[login],

      backgroundColor:Colors.white,

    );
  }
}