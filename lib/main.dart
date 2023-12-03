import 'package:flutter/material.dart';
import 'package:flutter_gallery/index_wise_image_upload.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        appBarTheme: const AppBarTheme(centerTitle: true),
      ),
      home: ImageTest(),
    );
  }
}
