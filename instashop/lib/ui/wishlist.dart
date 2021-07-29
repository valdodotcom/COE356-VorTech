import 'dart:io';

import 'package:flutter/material.dart';
import 'package:instashop/widgets/custom_nav_bar.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({Key? key}) : super(key: key);

  @override
  _WishlistPageState createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  DateTime _lastQuitTime = DateTime(0);

  Future<bool> _backTwice() async {
    if (_lastQuitTime == null ||
        DateTime.now().difference(_lastQuitTime).inSeconds > 1) {
      print('Press again Back Button exit');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Press back button again to exit')));
      _lastQuitTime = DateTime.now();
      return false;
    } else {
      print('sign out');
      Navigator.of(context).pop(exit(0));
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: _backTwice,
    child: new Scaffold(
        appBar: new AppBar(
          leading: new Container(),
          backgroundColor: Color(0xff00eaff),
          title: new Text("Wishlist"),
          // actions: <Widget>[
          //   new IconButton(
          //       onPressed: () => debugPrint("Search pressed"),
          //       icon: new Icon(Icons.search)),
          // ],
        ),

        bottomNavigationBar: new CustomNavBar(index: 1)),);
  }
}
