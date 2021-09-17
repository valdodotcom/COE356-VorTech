import 'package:flutter/material.dart';
// import 'package:instashop/ui/sign_in_page.dart';
// import 'package:instashop/ui/loading_screen.dart';
import 'ui/home.dart';

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
      /*initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/second': (context) => SignInPage(),
      },*/
    );
  }
}
