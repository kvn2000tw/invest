import 'package:flutter/material.dart';

enum Status{
    Login(value: 0, label: "登入"),
    Register(value: 2, label: "Register"),
    Browser(value: 3, label: "browser"),
   
    Logout(value: -1, label: "登出");
    
    final int value;
    final String label;
  
  const Status({
    required this.value,
    required this.label,
   
  });

 /// 解析从后台传来的值
  static Status parse(int i) {
    if (i == -1) return Status.Logout;
    return Status.values[i];
  }    
}

class Data {
 
  static String username = '';
  static String passwd = '';
  static final ValueNotifier<bool> remeber = ValueNotifier(false);

  static final ValueNotifier<Status> status = ValueNotifier(Status.Login);

}