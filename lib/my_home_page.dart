import 'package:flutter/material.dart';
import 'my_app_bar.dart';
import 'login.dart';
import 'dart:async';
import 'dart:convert';
import 'data.dart';

import 'package:webview_flutter/webview_flutter.dart';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'theme/theme_model.dart';
import 'custom/custom_theme.dart';
import 'service.dart';
//import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';

//import 'web_view.dart';

class MyHomePage extends StatelessWidget {

  late ThemeModel themeNotifier;

  final MENU_START = 5;
  final MAX_TIMER = 12;
  int timer = 0;
  MyHomePage()
  {
    //loop();
  }

  void loop() async{
    while(true){

      await Future.delayed(const Duration(seconds:5));
    
      if(timer == 0)
      {
        print('loop');
        timer = MAX_TIMER;
        print(Data.status);
        if(Data.status.value != Status.Login && Data.status.value != Status.Logout)
        {
          //getNotify();
        }
        
      }
      else 
      {
        --timer;
      }
    }
  }  
  final ValueNotifier<int> _selectedNaviItem = ValueNotifier(-1);

  final Completer<WebViewController> _controller =
    Completer<WebViewController>();

  static  final _naviItemIcon = [
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
  void process_url(String url) async
  {
    /*
    if(url.contains('user/vip_contents/investanchors_index'))
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
      //Data.status.value = Status.Browser;
      //_selectedNaviItem.value = 4;
    }
    
    else 
    {
      //MyAppBar.selectedNaviItem.value = 'login';
    }
*/
    if (url.compareTo('https://investanchors.com/') == 0) {
      //if (url.compareTo('https://tw.yahoo.com/') == 0) {
      final WebViewController controller = await _controller.future;
    
      final String result = await controller.runJavascriptReturningResult(
        """
        var msg = window.document.body.outerHTML; 
        var ret = 'logout'; 
        if(msg.indexOf('會員登出') !== -1) 
          ret = 'login'; 
        ret;
        """
      );
       
      print(result);
      if(result.compareTo('login') == 0)
      {
         _selectedNaviItem.value = 4;
      }
      else 
      {
        _selectedNaviItem.value = -1;

      }
    }
    else if (url.compareTo(Data.register_page) == 0) {
      //if (url.compareTo('https://tw.yahoo.com/') == 0) {
      print(url);
      if(Data.status.value != Status.Browser)    return;

      final WebViewController controller = await _controller.future;
    
        String name = Data.username;
        String passwd = Data.passwd;

        String script =
         """ 
          var  btn = document.getElementsByClassName("cbp-l-loadMore-link")[0]; 
          document.getElementsByName("user[email]")[0].value = '${name}';
          document.getElementsByName("user[password]")[0].value = '${passwd}';
          var form = document.querySelector("form[action='/user/register']");
          btn.click();
          """;

        print(script);
        await controller.runJavascript(script);
      }

  }
 
  void check_dark_mode(BuildContext context)
  {
    if(Theme.of(context).brightness == Brightness.dark)
    {
      Data.is_dark = true;
    }
    else 
    {
      Data.is_dark = false;
    }

    Data.init();
    FlutterFlowTheme.of(context).init();
  }
  @override
  Widget build(BuildContext context) {
    // 建立AppBar
    
    check_dark_mode(context);

    final appBar = MyAppBar();
   
    // 建立App的操作畫面
  
      ValueListenableBuilder<Status> bottomNavigationBar = ValueListenableBuilder<Status>(
        builder: _bottomNavigationBarBuilder,
        valueListenable: Data.status,
      );

      ValueListenableBuilder<int> tabview = ValueListenableBuilder<int>(
        builder: _tabviewBuilder,
        valueListenable: Data.view_change,
      );
      
      final page = DefaultTabController(
      length: 1,
      
      child: Scaffold(
        appBar: appBar,
        body: tabview,
        bottomNavigationBar: bottomNavigationBar,
        
      ),
    );
    return Consumer<ThemeModel>(
      builder: (context, ThemeModel themeNotifier, child) {
        this.themeNotifier = themeNotifier;
        return page;
      }
    );   
  
  }

  _backToHomePage(BuildContext context) {
   
  }
 
  // 這個方法負責建立BottomNavigationBar
  Widget _bottomNavigationBarBuilder(BuildContext context, Status selectedButton, Widget? child) {
    final bottomNaviBarItems = <BottomNavigationBarItem>[];

    final select_item = Data.status.value;
    print('_bottomNavigationBarBuilder');
    //print(selectedButton);
    //select_item = 0;
    if(select_item == Status.Login)
    {
    return SizedBox(
      //color:Colors.white,
      height: 0.0,//_bottomNavBarHeight,
      child: null,
    );

    }

    for (var i = 0; i < 4; i++) {
      
      var index = i;
      if(select_item.value == (i+MENU_START))
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
    
    
    if((select_item.value >= MENU_START) && (select_item.value < (MENU_START+4)))
    {
      currentIndex = select_item.value-5;
      selectedItemColor = Data.orange;
      
    }
    else 
    {
      currentIndex = 0;
      selectedItemColor = Data.blue;
     
    }

    final widget = BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: bottomNaviBarItems,
      showUnselectedLabels:true,
      showSelectedLabels:true,
      currentIndex: currentIndex,
      selectedLabelStyle: TextStyle(fontSize: 10),
      selectedItemColor: selectedItemColor,
      unselectedLabelStyle: TextStyle(fontSize: 10),
      unselectedItemColor: Data.blue,
      onTap: (index) => gotoItem(index),
    );

    return widget;
    
  }
  gotoItem(int value) async
  {
    final WebViewController controller = await _controller.future;

    print(value);

    if(value == 0)
    {
      Data.status.value = Status.Email;
    }

    else if(value == 1)
    {
      Data.status.value = Status.QAnalysis;
      String url = '${Data.QAnalysis_page}${Data.user_token}';
      Data.url = url;
      controller.loadUrl(url);
    }
    if(value == 2)
    {
      Data.status.value = Status.Screener;
      String url = '${Data.Screener_page}${Data.user_token}'; 
      Data.url = url;
      controller.loadUrl(url);      
    }

    else if(value == 3)
    {
      Data.status.value = Status.Price;
      
      String url = '${Data.Price_page}${Data.user_token}'; 
      Data.url = url;
      controller.loadUrl(url);

    }
  }
  // 這個方法負責建立BottomNavigationBar
  Widget _tabviewBuilder(BuildContext context, int selectedButton, Widget? child) {

    
    if(Data.status.value == Status.Login)
    {
      return Login();
      
    }
   
   print('_tabviewBuilder');
    timer = 0;

    final webview = WebView(
      //initialUrl :'https://investanchors.com/',
      initialUrl : Data.url,
      onWebViewCreated: (WebViewController controller) {
        _controller.complete(controller);
        //load_req(controller);

      },
      javascriptMode:JavascriptMode.unrestricted,    
     
      onPageStarted: (String url) {
        print('Page started loading: $url');
      },
      onPageFinished: (String url) {
        print('Page finished loading: $url');
         process_url(url);
          
        // In the final result page we check the url to make sure  it is the last page.
      },        
    );
          
      // 結合AppBar和App操作畫面
    final tabBarView = TabBarView(
        children: [
          webview
        ],
    );

    return tabBarView;
  }

}