import 'package:flutter/material.dart';
import 'package:instashop/ui/my_account.dart';
import 'package:instashop/widgets/customNavBar.dart';
import 'home.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // int _index = 2;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
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
                        color: Colors.grey.shade200,
                        padding: EdgeInsets.all(15.0),
                        child: new Row(
                          children: <Widget>[
                            new Icon(
                              Icons.person,
                              size: 40,
                              color: Colors.blue,
                            ),
                            new Text(
                              "\t\t\t My Account",
                              style: new TextStyle(
                                  fontSize: 20.0, color: Colors.blue.shade800),
                            ),
                          ],
                        ),
                      )),
                  new Padding(padding: EdgeInsets.all(10)),
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
                        color: Colors.grey.shade200,
                        padding: EdgeInsets.all(15.0),
                        child: new Row(
                          children: <Widget>[
                            new Icon(
                              Icons.library_books,
                              size: 40,
                              color: Colors.blue,
                            ),
                            new Text(
                              "\t\t\t Orders",
                              style: new TextStyle(
                                  fontSize: 20.0, color: Colors.blue.shade800),
                            ),
                          ],
                        )),
                  ),
                  new Padding(padding: EdgeInsets.all(10)),
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
                        color: Colors.grey.shade200,
                        padding: EdgeInsets.all(15.0),
                        child: new Row(
                          children: <Widget>[
                            new Icon(
                              Icons.app_settings_alt,
                              size: 40,
                              color: Colors.blue,
                            ),
                            new Text(
                              "\t\t\t Device Settings",
                              style: new TextStyle(
                                  fontSize: 20.0, color: Colors.blue.shade800),
                            ),
                          ],
                        )),
                  ),
                  new Padding(padding: EdgeInsets.all(10)),
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
                        color: Colors.grey.shade200,
                        padding: EdgeInsets.all(15.0),
                        child: new Row(
                          children: <Widget>[
                            new Icon(
                              Icons.info,
                              size: 40,
                              color: Colors.blue,
                            ),
                            new Text(
                              "\t\t\t Info",
                              style: new TextStyle(
                                  fontSize: 20.0, color: Colors.blue.shade800),
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
                      color: Colors.grey.shade200,
                      padding: EdgeInsets.all(15.0),
                      child: new Row(
                        children: <Widget>[
                          new Icon(
                            Icons.logout,
                            size: 40,
                            color: Colors.blue,
                          ),
                          new Text(
                            "\t\t\t Log Out",
                            style: new TextStyle(
                                fontSize: 20.0, color: Colors.blue.shade800),
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

