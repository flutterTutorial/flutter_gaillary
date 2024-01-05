import 'package:flutter/material.dart';
import 'package:flutter_gallery/provider/testprovider.dart';
import 'package:flutter_gallery/screen/demo33.dart';
import 'package:provider/provider.dart';
void main() {
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
      home:  YourOtherPage(),
    );
  }
}
