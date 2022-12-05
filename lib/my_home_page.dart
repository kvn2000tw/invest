import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
 
import 'data.dart';

class MyHomePage extends StatelessWidget {

  // BottomNavigationBar顯示的圖示和文字
  static  var _naviItemIcon = [
    Image.asset(
      'assets/mail.png',
    ),
    Image.asset(
      'assets/chart.png',
    ),
    Image.asset(
      'assets/tune.png',
    ),
    Image.asset(
      'assets/folder.png',
    ),    
  ];
  static const _naviItemText = [
    '電子報',
    '財務指標',
    '量化篩選',
    '產業資料庫'
  ];

  // 記錄BottomNavigationBar被點選的按鈕
  final ValueNotifier<int> _selectedNaviItem = ValueNotifier(0);


  @override
  Widget build(BuildContext context) {
    // 建立AppBar
    print('build');
    final btn = IconButton(
      icon: const Icon(Icons.phone_android, color: Colors.white,),
      color: Colors.blue,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      onPressed: () => {},//_msg.value = '你按下手機按鈕',
    );


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

    final appBar = AppBar(
      
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
   
    var webview = WebView(
      initialUrl :'https://investanchors.com/',
      javascriptMode:JavascriptMode.unrestricted,
      navigationDelegate: (request) {
        print(request.url);
        return NavigationDecision.navigate; // Default decision
      },
    );
    // 建立App的操作畫面
    final tabBarView = TabBarView(
        children: [
          webview
        ],
    );

    // 結合AppBar和App操作畫面
    final page1 = Scaffold(
      appBar: appBar,
      body: webview,
    );
/*
    var willPopScope = WillPopScope(
      onWillPop: () => _backToHomePage(context),
      child: page,
    );
*/
 
    // 結合AppBar和App操作畫面

    ValueListenableBuilder<int> bottomNavigationBar;

        bottomNavigationBar = ValueListenableBuilder<int>(
          builder: _bottomNavigationBarBuilder,
          valueListenable: _selectedNaviItem,
        );

    
    final page = DefaultTabController(
      length: tabBarView.children.length,
      child: Scaffold(
        appBar: appBar,
        body: tabBarView,
      
        bottomNavigationBar: bottomNavigationBar,
        
      ),
    );

    return page;
  }

  _backToHomePage(BuildContext context) {
   
  }

  // 這個方法負責建立BottomNavigationBar
  Widget _bottomNavigationBarBuilder(BuildContext context, int selectedButton, Widget? child) {
    final bottomNaviBarItems = <BottomNavigationBarItem>[];

    if(_selectedNaviItem.value < 0)
    {
    return SizedBox(
      height: 0.0,//_bottomNavBarHeight,
      child: null,
    );

    }
    for (var i = 0; i < _naviItemIcon.length; i++) {
      bottomNaviBarItems.add(
        BottomNavigationBarItem(
          icon: _naviItemIcon[i],
          label: _naviItemText[i]),
  
        );
    }

    final widget = BottomNavigationBar(
    
      items: bottomNaviBarItems,
      showUnselectedLabels:true,
      showSelectedLabels:true,
      currentIndex: _selectedNaviItem.value,
      selectedLabelStyle: TextStyle(fontSize: 10),
      selectedItemColor: Colors.red,
      unselectedLabelStyle: TextStyle(fontSize: 10),
      unselectedItemColor: Colors.black,
      onTap: (index) => _selectedNaviItem.value = index,
    );

    return widget;
  }

}