import 'package:flutter/material.dart';
import 'ui/homescreens/home.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "InstaShop",
      debugShowCheckedModeBanner:false,
      home: Home(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
