import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({Key? key}) : super(key: key);

  @override
  _MyAccountPageState createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  var _emailController = TextEditingController();
  var _phoneNumberController = TextEditingController();
  var _firstNameController = TextEditingController();
  var _lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        leading: new Container(),
        backgroundColor: Color(0xff00eaff),
        title: new Text("Settings"),
      ),
      body: new ListView(
        padding: EdgeInsets.all(40.0),
        children: <Widget>[
          new Column(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              //   mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Padding(padding: EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0)),
                new Text(
                  "Account Details",
                  style: new TextStyle(fontSize: 20),
                ),
                new TextButton(
                    onPressed: () => debugPrint("Edit clicked"),
                    child: new Text("Edit")),
                new TextField(
                  controller: _firstNameController,
                  decoration: new InputDecoration(
                    labelText: "First Name",
                  ),
                ),
                new TextField(
                  controller: _lastNameController,
                  decoration: new InputDecoration(
                    labelText: "Last Name",
                  ),
                ),
                new TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  decoration: new InputDecoration(
                    labelText: "Email",
                  ),
                ),
                new TextField(
                  keyboardType: TextInputType.numberWithOptions(),
                  controller: _phoneNumberController,
                  decoration: new InputDecoration(
                    labelText: "Phone number",
                  ),
                ),
                new Padding(padding: EdgeInsets.all(12)),
                new TextButton(
                    onPressed: () => debugPrint("Change password pressed"),
                    child: new Text("Tap here to change password")),
              ])
        ],
      ),
    );
  }
}
