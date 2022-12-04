import 'package:flutter/material.dart';
 import 'package:webview_flutter/webview_flutter.dart';
 
import 'data.dart';

class MyHomePage extends StatelessWidget {

  final _drink = ['紅茶', '泡沫綠茶'];
  final ValueNotifier<int?> _selectedItem = ValueNotifier(Data.drinkItem);

  @override
  Widget build(BuildContext context) {
    // 建立AppBar
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
            /*boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey, offset: Offset.fromDirection(1, 20)),
            ]*/
            ),
        child: Text(
          '簡介',
          style: TextStyle(fontSize: 15.0,color:Colors.blue),
        ),

    );
 
    var logo = Image.asset(
      'assets/logo.png',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );

    final text1 = const Text('定錨產業筆記',
      style:TextStyle(fontSize:10,
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
        ),
        alignment:Alignment.topLeft,
      ),
      leading: InkWell(
        child: logo,
        onTap: () => {},//_msg.value = '你按下選單按鈕',
      ),
      automaticallyImplyLeading: false,
      actions: <Widget>[intro],
      backgroundColor:Colors.white,
    );
   
    var webview = WebView(
      initialUrl :'https://investanchors.com/',
      javascriptMode:JavascriptMode.unrestricted,
    );
    // 結合AppBar和App操作畫面
    final page = Scaffold(
      appBar: appBar,
      body: webview,
    );

    var willPopScope = WillPopScope(
      onWillPop: () => _backToHomePage(context),
      child: page,
    );

    return page;
  }

  Widget _drinkOptionBuilder(BuildContext context, int? selectedItem, Widget? child) {
    var radioItems = <RadioListTile>[];

    // 把選項加入radioItems
    for (var i = 0; i < _drink.length; i++) {
      radioItems.add(
          RadioListTile(
            value: i,
            groupValue: selectedItem,
            title: Text(_drink[i], style: const TextStyle(fontSize: 20),),
            onChanged: (value) => _selectedItem.value = value,
          )
      );
    }

    final wid = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: radioItems,
    );

    return wid;
  }

  _backToHomePage(BuildContext context) {
    Data.drinkItem = _selectedItem.value;
    String? drink = Data.drinkItem != null ?
    _drink[Data.drinkItem!] : null;
    Navigator.pop(context, drink);
  }
}