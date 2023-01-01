
import 'package:flutter/material.dart';

class ShowDialogWrap extends StatelessWidget {

  late String title;
  late String msg ;
  ShowDialogWrap({String title='',String msg=''})
  {
    this.title = title;
    this.msg = msg;
  }
@override
  Widget build(BuildContext context) {
     final dlg = AlertDialog(
      title:Text(title),
      content: Text(msg),
      contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
    
      actions: <Widget>[
        TextButton(
          child: const Text("確定",
            style: TextStyle(color: Colors.red, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context, ''),
        ),
     
      ],
    );



    return dlg;
  }
}
