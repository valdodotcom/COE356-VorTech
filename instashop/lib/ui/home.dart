import 'dart:io';
import '../ui/new_account_page.dart';
import 'package:flutter/material.dart';
import '../ui/sign_in_page.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime _lastQuitTime = DateTime(0);

  Future<bool> _backTwice() async {
    if (_lastQuitTime == null ||
        DateTime.now().difference(_lastQuitTime).inSeconds > 1) {
      print('Press again Back Button exit');
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Press back button again to exit')));
      _lastQuitTime = DateTime.now();
      return false;
    } else {
      print('sign out');
      Navigator.of(context).pop(exit(0));
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _backTwice,
        child: new Scaffold(
            body: new Container(
                color: Color(0xff00eaff),
                alignment: Alignment.center,
                child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Icon(
                        Icons.shopping_cart_rounded,
                        size: 250.0,
                      ),
                      new Text(
                        "instaShop",
                        style: new TextStyle(
                          fontSize: 50.0,
                        ),
                      ),
                      new ElevatedButton(
                          child: new Text("Sign in"),
                          onPressed: () {
                            var router = new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    new SignInPage());

                            Navigator.of(context).push(router);
                          }),
                      new Padding(
                          padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0)),
                      new Text(
                        "New to instaShop?",
                        style: new TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                      new ElevatedButton(
                          child: new Text("Create new account"),
                          onPressed: () {
                            var router = new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    new NewAccountPage());

                            Navigator.of(context).push(router);
                          }),
                    ]))));
  }
}
