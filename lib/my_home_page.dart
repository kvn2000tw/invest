import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:invest/my_app_bar.dart';

import 'data.dart';


class MyHomePage extends StatelessWidget {


  // 記錄BottomNavigationBar被點選的按鈕
  final ValueNotifier<int> _selectedNaviItem = ValueNotifier(0);

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



    final appBar = MyAppBar();
   
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