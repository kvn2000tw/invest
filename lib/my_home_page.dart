import 'package:flutter/material.dart';
import 'components/my_app_bar.dart';
import 'components/login.dart';
import 'components/mail_box.dart';
import 'components/member.dart';
import 'dart:async';
import 'data.dart';

import 'package:webview_flutter/webview_flutter.dart';
import 'package:provider/provider.dart';
import 'theme/theme_model.dart';
import 'custom/custom_theme.dart';
import 'service.dart';

// FlutterFire's Firebase Cloud Messaging plugin
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:overlay_support/overlay_support.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print('_firebaseMessagingBackgroundHandler');
  await Firebase.initializeApp();

  print("Handling a background message: ${message.notification?.title} ${message.notification?.body}");
  //Data.status.value = Status.Email;
}

class PushNotification {
  PushNotification({
    this.title,
    this.body,
  });
  String? title;
  String? body;
}
class MyHomePage extends StatelessWidget {
 
  late final FirebaseMessaging _messaging;
  PushNotification? _notificationInfo;


 checkForInitialMessage() async {
  await Firebase.initializeApp();
  RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();

  if (initialMessage != null) {
    PushNotification notification = PushNotification(
      title: initialMessage.notification?.title,
      body: initialMessage.notification?.body,
    );
  
  }
}

  void receivedMessage(RemoteMessage remoteMessage){
     print('onMessage.listen');
     print(remoteMessage.notification?.title);
     print(remoteMessage.notification?.body);
   
     PushNotification notification = PushNotification(
        title: remoteMessage.notification?.title,
        body: remoteMessage.notification?.body,
      );
      print('receivedMessage');
      Service.getNotify();
      _notificationInfo = notification;
        showSimpleNotification(
          Text(_notificationInfo!.title!),
          
          subtitle: Text(_notificationInfo!.body!),
          background: Colors.cyan.shade700,
          duration: Duration(seconds: 2),
        );     
}
    void registerNotification() async {

    print('registerNotification');
   
    // 1. Initialize the Firebase app
    await Firebase.initializeApp();

    // 2. Instantiate Firebase Messaging
    _messaging = FirebaseMessaging.instance;

    // 3. On iOS, this helps to take the user permissions
    NotificationSettings settings = await _messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
    );

    String? token = await _messaging.getToken();

    Data.token = token!;
    print('token ${token}');

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
      // TODO: handle the received notifications
      // For handling the received notifications
  
      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
      FirebaseMessaging.onMessage.listen(receivedMessage);
      FirebaseMessaging.onMessageOpenedApp.listen((message) {
     
        print('routeFromMessage');
       
    });

    } else {
      print('User declined or has not accepted permission');
    }
  }

  late ThemeModel themeNotifier;

  final MENU_START = 5;
  
  int timer = 0;
  
  MyHomePage()
  {
    //loop();
    print('MyHomePage');
    registerNotification();
     
  }

  static init()
  {
  }
 
  final ValueNotifier<int> _selectedNaviItem = ValueNotifier(-1);

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
  final _naviItemText = [
    '電子報',
    '財務指標',
    '量化篩選',
    '產業資料庫'
  ];
  run_login()async
  {
    if(Data.status.value != Status.Login )    return;

    final WebViewController controller = await _controller.future;

    String script =
        """ 
          var  btn = document.getElementsByClassName("cbp-l-loadMore-link")[0]; 
          document.getElementsByName("user[email]")[0].value = '${Data.username}';
          document.getElementsByName("user[password]")[0].value = '${Data.passwd}';
          btn.click();
          html = btn.innerHTML;
        """;

    //print(script);
    await controller.runJavascript(script);

     final String result = await controller.runJavascriptReturningResult(script);
     Data.btn_str = result;
    print('result  ${result}');
    _getArticles();
  }
  
  _getArticles()
  {
    Data.cur_page = 1;
 
    Data.selectHead = 0;
    Data.tag_index.value = 0;
    Service.process_articles();
  }
 
  void process_url(String url) async
  {
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
       
      print('status '+result);
      if(result.compareTo('login') == 0)
      {
         _selectedNaviItem.value = 4;
      }
      else 
      {
        _selectedNaviItem.value = -1;

      }
    }
    else if (url.indexOf(Data.register_app_page) == 0) {
      //if (url.compareTo('https://tw.yahoo.com/') == 0) {
      print('${url} ${Data.status.value}');
      await run_login();

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
    var remeberRet = Service.getRemeber();
    remeberRet.then((value) => Data.remeber.value = value);

    var usernameRet = Service.getUsername();
    usernameRet.then((value) => Data.username = value);

    var passwdRet = Service.getPasswd();
    passwdRet.then((value) => Data.passwd = value);

    check_dark_mode(context);

    final appBar = MyAppBar(
      init:(){init_controll();},
      logout:(){goLogout();},
      loadUrl:(){loadUrlAlarm();},
    );

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
        //drawer:Data.drawer_config? drawer : null,
      ),
    );
    return Consumer<ThemeModel>(
      builder: (context, ThemeModel themeNotifier, child) {
        this.themeNotifier = themeNotifier;
        return page;
      }
    );   
  
  }
 
  // 這個方法負責建立BottomNavigationBar
  Widget _bottomNavigationBarBuilder(BuildContext context, Status selectedButton, Widget? child){
    final bottomNaviBarItems = <BottomNavigationBarItem>[];

    final select_item = Data.status.value;
    print('_bottomNavigationBarBuilder');
    //print(selectedButton);
    //select_item = 0;

    if(select_item == Status.Login || select_item == Status.Introduce || select_item == Status.Logout)
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
    print(value);

    if(value == 0)
    {
      _getArticles();
    
    }

    else if(value == 1)
    {
      Data.update_status(Status.QAnalysis);
    
      Data.url = '${Data.QAnalysis_page}${Data.user_token}';
     
    }
    if(value == 2)
    {
    
      Data.update_status(Status.Screener);
    
      Data.url = '${Data.Screener_page}${Data.user_token}'; 
       
    }

    else if(value == 3)
    {
      Data.update_status(Status.Price);
      
      Data.url = '${Data.Price_page}${Data.user_token}'; 

    }
    loadUrl();
   
    Data.update_view_change();
  }
  init_controll()
  {
    _controller = Completer<WebViewController>();
  }
  auto_login() async
  {
    final WebViewController controller = await _controller.future;

    print('auto_login load url ${Data.url}');
    controller.loadUrl(Data.register_app_page);   
  }
  late WebView webView;
  Completer<WebViewController> _controller =
    Completer<WebViewController>();
  init_webview()
  {
    webView = WebView(
    //initialUrl :'https://investanchors.com/',
    initialUrl : Data.url,
    onWebViewCreated: (WebViewController controller) {
      print('_controller.complete(controller)');
      if(!_controller.isCompleted)
        _controller.complete(controller);
     
    },
    javascriptMode:JavascriptMode.unrestricted,    
     
    onPageStarted: (String url) {
      print('Page started loading: $url');
    },
    onPageFinished: (String url) {
      print('Page finished loading: $url ${Data.status.value}');
      process_url(url);
          
      // In the final result page we check the url to make sure  it is the last page.
    },        
  );

  }
  loadUrl() async
  {
     print('load url 1 ${Data.url}');
    if(_controller.isCompleted == false)  
    {
      return;
    }
    final WebViewController controller = await _controller.future;

    print('load url ${Data.url}');
    controller.loadUrl(Data.url);   
 
  }
  loadUrlAlarm() async
  {
     print('loadUrlAlarm url 1 ${Data.url}');
    if(_controller.isCompleted == false)  
    {
      Data.update_status(Status.Browser);
      Data.update_view_change();
      return;
    }
    final WebViewController controller = await _controller.future;

    print('load url ${Data.url}');
    controller.loadUrl(Data.url);   
    Data.update_status(Status.Browser);
    Data.update_view_change();
 
  }
   
  goLogout() async
  {
     print('goLogout url 1 ${Data.url}');
    init_controll();
    Data.update_status(Status.Login);
    Data.update_view_change();
    return ;  
    if(_controller.isCompleted == false)  
    {
      Data.update_status(Status.Login);
      Data.update_view_change();
 
      return;
    }

    final WebViewController controller = await _controller.future;

    print('goLogout url ${Data.url}');
    controller.loadUrl(Data.url);   
    // await  controller.reload(); 
    Data.update_status(Status.Login);
    Data.update_view_change();
 
  }
  login_widget()
  {
    Data.url = Data.intro_page;
    init_webview();
    final fake_webview = SizedBox(
      width:0.1,
      height: 0.1,//_bottomNavBarHeight,
      child: webView,
    );

    return Login(widget:fake_webview,auto_login:auto_login);
   
  }
  // 這個方法負責建立BottomNavigationBar
  Widget _tabviewBuilder(BuildContext context, int selectedButton, Widget? child) {

    if(Data.status.value == Status.Login)
    {
        return login_widget();
    }  

    if(Data.status.value == Status.Email ||
      Data.status.value == Status.Member)
    {
      init_controll();
    
      if(Data.status.value == Status.Email)
      { 
        return MailBox();
      }
      else 
      {
        return Member();
      }
      
    }
   
    print('_tabviewBuilder');
    print(Data.status.value);
    print(Data.view_change.value);
    timer = 0;

    init_webview();
    
    // 結合AppBar和App操作畫面
    final tabBarView = TabBarView(
        children: [
          webView
        ],
    );

    return tabBarView;
  }

}