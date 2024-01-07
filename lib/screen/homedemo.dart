import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreenDemo extends StatefulWidget {
  const HomeScreenDemo({super.key});

  @override
  State<HomeScreenDemo> createState() => _HomeScreenDemoState();
}

class _HomeScreenDemoState extends State<HomeScreenDemo> {
  void getInitialMessage() async {
    RemoteMessage? message =
        await FirebaseMessaging.instance.getInitialMessage();

    if (message != null) {
      print("1A");

      // if (message.data["page"] == "email") {
      //   Navigator.push(
      //       context, CupertinoPageRoute(builder: (context) => SignUpScreen()));
      // } else if (message.data["page"] == "phone") {
      //   Navigator.push(context,
      //       CupertinoPageRoute(builder: (context) => SignInWithPhone()));
      // } else {
      //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //     content: Text("Invalid Page!"),
      //     duration: Duration(seconds: 5),
      //     backgroundColor: Colors.red,
      //   ));
      // }
    }
  }

  @override
  void initState() {
    super.initState();

    getInitialMessage();

    FirebaseMessaging.onMessage.listen((message) {
      print("1AA");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message.data["myname"].toString()),
        duration: Duration(seconds: 10),
        backgroundColor: Colors.green,
      ));
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print("1AAA");
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   content: Text("App was opened by a notification"),
      //   duration: Duration(seconds: 10),
      //   backgroundColor: Colors.green,
      // ));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("data"),
      ),
    );
  }
}