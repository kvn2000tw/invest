import 'package:flutter/material.dart';
import 'my_home_page.dart';
import 'data.dart';
import 'package:provider/provider.dart';
import 'theme/theme_model.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
void main() {
  Data.init();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   return ChangeNotifierProvider(
      create: (_) => ThemeModel(),
      child: Consumer<ThemeModel>(
        builder: (context, ThemeModel themeNotifier, child) {
        return OverlaySupport(
          child: MaterialApp(
            title: 'Flutter Invest',
            theme: ThemeData(colorScheme: const ColorScheme.light()),
            darkTheme: ThemeData(colorScheme: const ColorScheme.dark()),
            themeMode: themeNotifier.themeMode,
            //theme: themeNotifier.isDark ? ThemeData.dark() : ThemeData.light(),
            debugShowCheckedModeBanner: false,
            initialRoute: '/loading',
            routes: {
              '/': (context) => MyHomePage(),
              '/loading': (context) =>Loading(),      
            },
          ));
        }
      )
    );
  }
}

class Loading extends StatelessWidget {

  void gotonext(BuildContext context) async{
    await Future.delayed(const Duration(seconds:3));
    
    MyHomePage.init();
    
    Navigator.pushNamed(context,"/");

  }
  void printWithTimestamp(String str){
    var now = DateTime.now();
    print('${now.minute}:${now.second} ${str}');
  }
  @override
  Widget build(BuildContext context) {
    // 建立AppBar
    final appBar = AppBar(
      title: const Text('Invest'),
    );
 
   var img = Image.asset(
      'assets/images/invest.png',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
    var text = const Text(
      'v1.0',
      style:TextStyle(
        color:Colors.white,
        fontSize:25),
    );
    var appBody = Container(
      child:Stack(
        children:<Widget>[img,
        Positioned(child:text,bottom:60)],
        alignment:Alignment.center,
      ),
      alignment:Alignment.topCenter,
    );
    // 結合AppBar和App操作畫面
    final appHomePage = Scaffold(
      appBar: null,
      body: appBody,
    );
   
    gotonext(context);
    return appHomePage;
  }
}
