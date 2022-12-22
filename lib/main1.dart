import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:overlay_support/overlay_support.dart';

class PushNotification {
  PushNotification({
    this.title,
    this.body,
  });
  String? title;
  String? body;
}
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
      OverlaySupport(
      child:MaterialApp(
      title: 'Notify',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ));
  }
}

Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State {
  late int _totalNotifications;
  late final FirebaseMessaging _messaging;

  PushNotification? _notificationInfo;

  @override
  void initState() {
    _totalNotifications = 0;
    registerNotification();
    checkForInitialMessage();
    super.initState();
  }
// For handling notification when the app is in terminated state
checkForInitialMessage() async {
  await Firebase.initializeApp();
  RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();

  if (initialMessage != null) {
    PushNotification notification = PushNotification(
      title: initialMessage.notification?.title,
      body: initialMessage.notification?.body,
    );
    setState(() {
      _notificationInfo = notification;
      _totalNotifications++;
    });
  }
}

void registerNotification() async {
  // 1. Initialize the Firebase app
  await Firebase.initializeApp();

  // 2. Instantiate Firebase Messaging
  _messaging = FirebaseMessaging.instance;

  // Add the following line
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // 3. On iOS, this helps to take the user permissions
  NotificationSettings settings = await _messaging.requestPermission(
    alert: true,
    badge: true,
    provisional: false,
    sound: true,
  );


  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('aaaa');
      // ...
      if (_notificationInfo != null) {
        // For displaying the notification as an overlay
        showSimpleNotification(
          Text(_notificationInfo!.title!),
          leading: NotificationBadge(totalNotifications: _totalNotifications),
          subtitle: Text(_notificationInfo!.body!),
          background: Colors.cyan.shade700,
          duration: Duration(seconds: 2),
        );
      }
    });
  } else {
    print('User declined or has not accepted permission');
  }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notify'),
        brightness: Brightness.dark,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _notificationInfo != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'TITLE: ${_notificationInfo!.title}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'BODY: ${_notificationInfo!.body}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}

class NotificationBadge extends StatelessWidget {
  final int totalNotifications;

  const NotificationBadge({required this.totalNotifications});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.0,
      height: 40.0,
      decoration: new BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '$totalNotifications',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}

