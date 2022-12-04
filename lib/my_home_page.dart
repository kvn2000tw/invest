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

    final menu = PopupMenuButton(
      itemBuilder: (context) {
        return <PopupMenuEntry>[
          const PopupMenuItem(
            child: Text('第一項', style: TextStyle(fontSize: 20),
            ),
            value: 1,
          ),
          const PopupMenuDivider(),
          const PopupMenuItem(
            child: Text('第二項', style: TextStyle(fontSize: 20),),
            value: 2,
          ),
        ];
      },
      onSelected: (value) {
        switch (value) {
          case 1:
            //_msg.value = '第一項';
            break;
          case 2:
            //_msg.value = '第二項';
            break;
        }
      }
    );   
    final appBar = AppBar(
      title: const Text('AppBar範例'),
      leading: InkWell(
        child: const Icon(Icons.menu),
        onTap: () => {},//_msg.value = '你按下選單按鈕',
      ),
      automaticallyImplyLeading: false,
      actions: <Widget>[btn, menu],
    );
    final btn1 = ElevatedButton(
      child: const Text('確定'),
      onPressed: () => _backToHomePage(context),
    );

   
    webview = WebView(
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