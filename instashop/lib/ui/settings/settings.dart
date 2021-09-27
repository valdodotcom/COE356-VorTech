import 'dart:io';
import 'package:flutter/material.dart';
import 'package:instashop/ui/settings/info.dart';
import 'package:instashop/ui/settings/my_account.dart';
import 'package:instashop/widgets/box_decoration.dart';
import 'package:instashop/widgets/custom_nav_bar.dart';
import '../home.dart';
import 'order_history.dart';
// import 'package:instashop/config/back_twice_to_close_app.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
    return WillPopScope(
      onWillPop: _backTwice,
      child: new Scaffold(
          appBar: new AppBar(
            leading: new Container(),
            backgroundColor: Color(0xff00eaff),
            title: new Text("Settings"),
          ),
          body: new ListView(
            padding: EdgeInsets.all(15.0),
            children: <Widget>[
              new Column(
                children: <Widget>[
                  new InkWell(
                      onTap: () {
                        var router = new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                new MyAccountPage());

                        Navigator.of(context).push(router);
                      },
                      child: new Container(
                        decoration: tempBoxDecoration(),

                        padding: EdgeInsets.all(15.0),
                        child: new Row(
                          children: <Widget>[
                            new Icon(
                              Icons.person,
                              size: 40,
                              color: Colors.blue,
                            ),
                            new Text(
                              "    My Account",
                              style: tempStyle ()
                            ),
                          ],
                        ),
                      )),
                  new Padding(padding: EdgeInsets.all(10)),
                  new InkWell(
                    onTap: () {
                      // return debugPrint("Button pressed");
                      var router = new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new OrderHistory());

                      Navigator.of(context).push(router);
                    },
                    child: new Container(
                        decoration: tempBoxDecoration(),

                        padding: EdgeInsets.all(15.0),
                        child: new Row(
                          children: <Widget>[
                            new Icon(
                              Icons.library_books,
                              size: 40,
                              color: Colors.blue,
                            ),
                            new Text(
                              "    Order History",
                              style: tempStyle ()
                            ),
                          ],
                        )),
                  ),
                  new Padding(padding: EdgeInsets.all(10)),
/*
                  new InkWell(
                    onTap: () {
                      return debugPrint("Button pressed");

                      // var router = new MaterialPageRoute(
                      //     builder: (BuildContext context) =>
                      //         new ItemInCategory());
                      //
                      // Navigator.of(context).push(router);
                    },
                    child: new Container(
                        decoration: tempBoxDecoration(),

                        padding: EdgeInsets.all(15.0),
                        child: new Row(
                          children: <Widget>[
                            new Icon(
                              Icons.app_settings_alt,
                              size: 40,
                              color: Colors.blue,
                            ),
                            new Text(
                              "    Device Settings",
                              style: tempStyle ()
                            ),
                          ],
                        )),
                  ),
*/
                  // new Padding(padding: EdgeInsets.all(10)),
                  new InkWell(
                    onTap: () {


                      var router = new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new InfoPage());

                      Navigator.of(context).push(router);
                    },
                    child: new Container(
                        decoration: tempBoxDecoration(),

                        padding: EdgeInsets.all(15.0),
                        child: new Row(
                          children: <Widget>[
                            new Icon(
                              Icons.info,
                              size: 40,
                              color: Colors.blue,
                            ),
                            new Text(
                              "    Info",
                              style: tempStyle ()
                            ),
                          ],
                        )),
                  ),
                  new Padding(padding: EdgeInsets.all(10)),
                  new InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return new AlertDialog(
                              title: new Text("Log Out"),
                              content:
                                  new Text("Are you sure you want to log out?"),
                              actions: <Widget>[
                                ElevatedButton(
                                    onPressed: () {
                                      var router = new MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              new Home());
                                      Navigator.of(context).push(router);
                                    },
                                    child: new Text("Yes, I'm sure"))
                              ],
                            );
                          });
                    },
                    child: new Container(
                      decoration: tempBoxDecoration(),
                      padding: EdgeInsets.all(15.0),
                      child: new Row(
                        children: <Widget>[
                          new Icon(
                            Icons.logout,
                            size: 40,
                            color: Colors.blue,
                          ),
                          new Text(
                            "    Log Out",
                            style: tempStyle ()
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          bottomNavigationBar:  new CustomNavBar(index: 2),
    ));
  }
}

TextStyle tempStyle () {
  return new TextStyle(
    color: Colors.blue.shade800,
    fontSize: 20.0,
  );
}