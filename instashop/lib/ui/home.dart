import 'package:flutter/material.dart';
import '../ui/product.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Container(
            color: Color(0xff00eaff),
            alignment: Alignment.center,
            child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text(
                    "instaShop",
                    style: new TextStyle(
                      fontSize: 50.0,
                    ),
                  ),
                  new OutlinedButton(
                      child: new Text("Sign in"),
                      onPressed: () {
                        var router = new MaterialPageRoute(
                            builder: (BuildContext context) => new SignInPage());

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
                  new OutlinedButton(
                      child: new Text("Create new account"),
                      onPressed: () {
                        var router = new MaterialPageRoute(
                            builder: (BuildContext context) => new SignInPage());

                        Navigator.of(context).push(router);
                      }),
                ])));
  }
}

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _emailController = TextEditingController();
    var _passwordController = TextEditingController();
    return new Scaffold(
      // appBar: new AppBar(
      //   backgroundColor: Color(0xff00eaff),
      // ),
      body: new Container(
        padding: EdgeInsets.all(40.0),
        color: Color(0xff00eaff),
        alignment: Alignment.center,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text("Welcome back!"),
            new Text("Please sign in to continue"),
            new TextField(
              controller: _emailController,
              decoration: new InputDecoration(
                labelText: "Email",
              ),
            ),
            new TextField(
              controller: _passwordController,
              decoration: new InputDecoration(
                labelText: "Password",
              ),
              obscureText: true,
            ),
            new TextButton(
                onPressed: () => debugPrint("Forgot password pressed"),
                child: new Text("Forgot your password?")),
            new OutlinedButton(
                child: new Text("Sign in"),
                onPressed: () {
                  var router = new MaterialPageRoute(
                      builder: (BuildContext context) => new ProductPage());
                  Navigator.of(context).push(router);
                }),
            new TextButton(
                onPressed: () {
                  var router = new MaterialPageRoute(
                      builder: (BuildContext context) => new SignInPage());
                  Navigator.of(context).push(router);
                },
                child: new Text("Don't have an account? Sign up"),)
          ],
        ),
      ),
    );
  }
}


