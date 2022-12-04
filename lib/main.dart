import 'package:flutter/material.dart';
import 'package:invest/my_home_page.dart';

import 'data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/loading',
      routes: {
        '/': (context) => MyHomePage(),
        '/loading': (context) =>Loading(),
       
      },
    );
  }
}

class Loading extends StatelessWidget {

  void gotonext(BuildContext context) async{
    await Future.delayed(const Duration(seconds:3));
    printWithTimestamp('gotonext');
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
      title: const Text('點餐'),
    );

    var widget = Image.asset(
      'assets/invest.png',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
    // 結合AppBar和App操作畫面
    final appHomePage = Scaffold(
      appBar: null,
      body: widget,
    );
    printWithTimestamp('gotonext1');
    gotonext(context);
    return appHomePage;
  }
}
