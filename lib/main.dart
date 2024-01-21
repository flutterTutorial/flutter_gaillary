import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gallery/notificationservice/local_notification_service.dart';
import 'package:flutter_gallery/provider/testprovider.dart';
import 'package:flutter_gallery/screen/homedemo.dart';
import 'package:flutter_gallery/screen/screen_stack.dart';
import 'package:provider/provider.dart';



// Future<void> backgroundHandler(RemoteMessage message) async {
//   print(message.data.toString());
//   print(message.notification!.title);
// }

void main()async {
   WidgetsFlutterBinding.ensureInitialized();
  
  Platform.isAndroid 
  ? await Firebase.initializeApp(
options:const FirebaseOptions(
  apiKey: "AIzaSyBOppttOC53lUbhX68aFK-1-jFCZCalVSI", 
  appId: "1:924808785618:android:f76728fa3f7f4cb96d470b",
   messagingSenderId: "924808785618", 
   projectId: "flutternotification-6733d")
  ):
    await Firebase.initializeApp();
    await NotificationService.initialize();
  runApp(
      MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OTPProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  AttendanceS(),
    );
  }
}
