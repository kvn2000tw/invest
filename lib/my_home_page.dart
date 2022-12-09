import 'package:flutter/material.dart';
import 'my_app_bar.dart';

import 'package:webview_flutter/webview_flutter.dart';

//import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';

//import 'web_view.dart';

class MyHomePage extends StatelessWidget {

  late WebViewController _controller;
  final ValueNotifier<int> _selectedNaviItem = ValueNotifier(-1);

  static  var _naviItemIcon = [
    Image.asset(
      'assets/email_b.png',
    ),
    Image.asset(
      'assets/chart_b.png',
    ),
    Image.asset(
      'assets/tune_b.png',
    ),
    Image.asset(
      'assets/folder_b.png',
    ),    

    Image.asset(
      'assets/email_y.png',
    ),
    Image.asset(
      'assets/chart_y.png',
    ),
    Image.asset(
      'assets/tune_y.png',
    ),
    Image.asset(
      'assets/folder_y.png',
    ),        
  ];
  static const _naviItemText = [
    '電子報',
    '財務指標',
    '量化篩選',
    '產業資料庫'
  ];
  void process_url(String url)
  {
    if(url.contains('user/register/new'))
    {
      MyAppBar.selectedNaviItem.value = 'intro';
    }else if(url.contains('user/vip_contents/investanchors_index'))
    {
      MyAppBar.selectedNaviItem.value = 'email';
      _selectedNaviItem.value = 0;
    }
    
    else if(url.contains('quantitative_analysis?coid'))
    {
      MyAppBar.selectedNaviItem.value = 'quantitative_analysis';
      _selectedNaviItem.value = 1;
    }
    else if(url.contains('quantitative_analysis'))
    {
      MyAppBar.selectedNaviItem.value = 'quantitative_analysis';
      _selectedNaviItem.value = 4;
    }
    else if(url.contains('screener'))
    {
      MyAppBar.selectedNaviItem.value = 'screener';
      _selectedNaviItem.value = 2;
    }
    else if(url.contains('commodity_price'))
    {
      MyAppBar.selectedNaviItem.value = 'commodity_price';
      _selectedNaviItem.value = 3;
    }
    else if(url.compareTo('https://investanchors.com/user') == 0)
    {
      MyAppBar.selectedNaviItem.value = 'user';
      _selectedNaviItem.value = 4;
    }
    else 
    {
      //MyAppBar.selectedNaviItem.value = 'login';
    }
  }

  JavascriptChannel _extractDataJSChannel(BuildContext context) {
    return JavascriptChannel(
          name: 'Flutter',
          onMessageReceived: (JavascriptMessage message) {
                String pageBody = message.message;
                print('page body: $pageBody');
                if(pageBody.compareTo('login') == 0)
                {
                  MyAppBar.selectedNaviItem.value = 'login';
                  _selectedNaviItem.value = 4;
                }
                else 
                {
                  MyAppBar.selectedNaviItem.value = 'logout';
                  _selectedNaviItem.value = -1;
                }
          },
       );
    }

  @override
  Widget build(BuildContext context) {
    // 建立AppBar
    
   
    final appBar = MyAppBar();
   
   
    // 建立App的操作畫面
  

   
/*
    var willPopScope = WillPopScope(
      onWillPop: () => _backToHomePage(context),
      child: page,
    );
*/
    
    // 結合AppBar和App操作畫面
 final tabBarView = TabBarView(
        children: [
          WebView(
      initialUrl :'https://investanchors.com/',
      //initialUrl :'https://tw.yahoo.com/',
      javascriptMode:JavascriptMode.unrestricted,
     
   
      onWebViewCreated: (WebViewController webViewController) {
        // Get reference to WebView controller to access it globally
        _controller = webViewController;
      },
      javascriptChannels: <JavascriptChannel>[
        // Set Javascript Channel to WebView
        _extractDataJSChannel(context),
        ].toSet(),
      onPageStarted: (String url) {
        print('Page started loading: $url');
      },
      onPageFinished: (String url) {
        print('Page finished loading: $url');
         process_url(url);
        // In the final result page we check the url to make sure  it is the last page.
        if (url.compareTo('https://investanchors.com/') == 0) {
        //if (url.compareTo('https://tw.yahoo.com/') == 0) {
          _controller.evaluateJavascript(
            """(function(){ 
              var msg = window.document.body.outerHTML; 
              var ret = 'logout'; 
              if(msg.indexOf('會員登出') !== -1) 
                ret = 'login'; 
              Flutter.postMessage(ret)})();
            """
          );
        }
      },        
          )
          //Text('test'),
        ],
    );
    
        ValueListenableBuilder<int> bottomNavigationBar;

        bottomNavigationBar = ValueListenableBuilder<int>(
          builder: _bottomNavigationBarBuilder,
          valueListenable: _selectedNaviItem,
        );


      final page = DefaultTabController(
      length: 1,
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
    for (var i = 0; i < 4; i++) {
      var index = i;
      if(_selectedNaviItem.value == i)
      {
        index = i+4;
      }
      bottomNaviBarItems.add(
        BottomNavigationBarItem(
          icon: _naviItemIcon[index],
          label: _naviItemText[i]),
  
        );
    }

    var currentIndex;
    var selectedItemColor;

    if(_selectedNaviItem.value >= 4)
    {
      currentIndex = 0;
      selectedItemColor = Color(0xFF0472bd);
    }
    else 
    {
      currentIndex = _selectedNaviItem.value;
      selectedItemColor = Color(0xFFe3b205);
    }

    final widget = BottomNavigationBar(
    
      items: bottomNaviBarItems,
      showUnselectedLabels:true,
      showSelectedLabels:true,
      currentIndex: currentIndex,
      selectedLabelStyle: TextStyle(fontSize: 10),
      selectedItemColor: selectedItemColor,
      unselectedLabelStyle: TextStyle(fontSize: 10),
      unselectedItemColor: Color(0xFF0472bd),
      onTap: (index) => _selectedNaviItem.value = index,
    );

    return widget;
  }

}