import 'dart:io';
import 'package:flutter/material.dart';


class BackTwice extends StatefulWidget {
  const BackTwice({Key? key}) : super(key: key);

  @override
  _BackTwiceState createState() => _BackTwiceState();
}

class _BackTwiceState extends State<BackTwice> {
   Future<bool> _backTwice() async {
     DateTime _lastQuitTime = DateTime(0);
     if (_lastQuitTime == null ||
          DateTime.now().difference(_lastQuitTime).inSeconds > 1) {
        print('Press again Back Button exit');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Press again Back Button exit')));
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
        child: Container(
          alignment: Alignment.center,
          child: Text('Click the back button to ask if you want to exit.'),
        ));
  }
}