import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import './ui/home.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "InstaShop",
      home: DoubleBack(
        message: "Press back again to close",
        child: Home(),
      ), theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    );
  }
}

