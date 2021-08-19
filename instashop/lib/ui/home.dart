import 'dart:io';

import 'package:flutter/material.dart';
import '../ui/shop_page.dart';



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

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();

  String _userEmail = '';
  String _password = '';

  void _trySubmitForm() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      print('Everything looks good!');
      print(_userEmail);
      print(_password);

      var router = new MaterialPageRoute(
          builder: (BuildContext context) =>
          new ShopPage());
      Navigator.of(context).push(router);



      /*
      Continue processing the provided information with your own logic
      such us sending HTTP requests, saving to SQLite database, etc.
      */
    }
  }

  @override
  Widget build(BuildContext context) {
    var _emailController = TextEditingController();
    var _passwordController = TextEditingController();
    return new Scaffold(
      backgroundColor: Color(0xff00eaff),
      body: new ListView(
        padding: EdgeInsets.all(40.0),
        children: <Widget>[
          new Column(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              //   mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Padding(padding: EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0)),
                new Icon(Icons.shopping_cart_rounded, size: 140.0),
                new Text(
                  "Welcome back!",
                  style: new TextStyle(fontSize: 30),
                ),
                new Text("Please sign in to continue"),
                new Form(key: _formKey, child: Column(children: <Widget>[
                new TextFormField(
                keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  decoration: new InputDecoration(
                    labelText: "Email",
                  ),
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Please enter your email address';
                    }
                    // Check if the entered email has the right format
                    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    // Return null if the entered email is valid
                    return null;
                  },
                  onChanged: (value) => _userEmail = value,
                ),

                  new TextFormField(
                    controller: _passwordController,
                    decoration: new InputDecoration(
                      labelText: "Password",
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'This field is required';
                      }
                      if (value.trim().length < 6) {
                        return 'Password must be at least 6 characters in length';
                      }
                      // Return null if the entered password is valid
                      return null;
                    },
                    onChanged: (value) => _password = value,
                  ),

                  new ElevatedButton(
                      child: new Text("Sign in"),
                      onPressed: _trySubmitForm),


                ],),),

                new TextButton(
                    onPressed: () => debugPrint("Forgot password pressed"),
                    child: new Text("Forgot your password?")),

                new TextButton(
                  onPressed: () {
                    var router = new MaterialPageRoute(
                        builder: (BuildContext context) =>
                            new NewAccountPage());
                    Navigator.of(context).push(router);
                  },
                  child: new Text("Don't have an account? Sign up"),
                ),
              ])
        ],
      ),
    );
  }
}








class NewAccountPage extends StatefulWidget {
  const NewAccountPage({Key? key}) : super(key: key);

  @override
  _NewAccountPageState createState() => _NewAccountPageState();
}

class _NewAccountPageState extends State<NewAccountPage> {
  // key to access the form
  final _formKey = GlobalKey<FormState>();

  String _userEmail = '';
  String _userName = '';
  String _password = '';
  String _confirmPassword = '';

  // function triggered when user presses sign up
  void _trySubmitForm() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      print('Everything looks good!');
      print(_userEmail);
      print(_userName);
      print(_password);
      print(_confirmPassword);

      var router = new MaterialPageRoute(
          builder: (BuildContext context) =>
          new ShopPage());
      Navigator.of(context).push(router);



      /*
      Continue processing the provided information with your own logic
      such us sending HTTP requests, saving to SQLite database, etc.
      */
    }
  }

  @override
  Widget build(BuildContext context) {
    var _emailController = TextEditingController();
    var _passwordController = TextEditingController();
    var _secondPasswordController = TextEditingController();
    var _firstNameController = TextEditingController();
    var _lastNameController = TextEditingController();

    return new Scaffold(
      backgroundColor: Color(0xff00eaff),
      body: new ListView(
        padding: EdgeInsets.all(40.0),
        children: <Widget>[
          new Column(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              //   mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Padding(padding: EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0)),
                new Icon(Icons.shopping_cart_rounded, size: 140.0),
                new Text(
                  "Welcome!",
                  style: new TextStyle(fontSize: 30),
                ),
                new Text("Fill in with your details to create account"),
                new Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        new TextFormField(
                          controller: _firstNameController,
                          decoration: new InputDecoration(
                            labelText: "First Name",
                          ),
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return 'This field is required';
                            }
                            if (value.trim().length < 2) {
                              return 'Username must be at least 2 characters in length';
                            }
                            // Return null if the entered username is valid
                            return null;
                          },
                          onChanged: (value) => _userName = value,
                        ),
                        new TextFormField(
                          controller: _lastNameController,
                          decoration: new InputDecoration(
                            labelText: "Last Name",
                          ),
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return 'This field is required';
                            }
                            if (value.trim().length < 2) {
                              return 'Username must be at least 2 characters in length';
                            }
                            // Return null if the entered username is valid
                            return null;
                          },
                          onChanged: (value) => _userName = value,
                        ),
                        new TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                          decoration: new InputDecoration(
                            labelText: "Email",
                          ),

                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return 'Please enter your email address';
                            }
                            // Check if the entered email has the right format
                            if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                              return 'Please enter a valid email address';
                            }
                            // Return null if the entered email is valid
                            return null;
                          },
                          onChanged: (value) => _userEmail = value,

                        ),
                        new TextFormField(
                          controller: _passwordController,
                          decoration: new InputDecoration(
                            labelText: "Password (6 or more characters)",
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return 'This field is required';
                            }
                            if (value.trim().length < 6) {
                              return 'Password must be at least 6 characters in length';
                            }
                            // Return null if the entered password is valid
                            return null;
                          },
                          onChanged: (value) => _password = value,

                        ),
                        new TextFormField(
                          controller: _secondPasswordController,
                          decoration: new InputDecoration(
                            labelText: "Confirm password",
                          ),
                          obscureText: true,

                          validator: (value) {
                            if(value!.isEmpty){
                              return 'This field is required';
                            }

                            if (value != _password) {
                              return 'Confirmation password does not match the entered password';
                            }

                            return null;
                          },
                          onChanged: (value) => _confirmPassword = value,

                        ),
                        new Padding(padding: EdgeInsets.all(10.0)),
                        new ElevatedButton(
                            child: new Text("Create account"),
                            onPressed: _trySubmitForm /*() {
                              var router = new MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      new ShopPage());
                              Navigator.of(context).push(router);
                            }*/)
                      ],
                    )),
                new TextButton(
                  onPressed: () {
                    var router = new MaterialPageRoute(
                        builder: (BuildContext context) => new SignInPage());
                    Navigator.of(context).push(router);
                  },
                  child: new Text("Already have an account? Sign in"),
                ),
              ])
        ],
      ),
    );
  }
}
