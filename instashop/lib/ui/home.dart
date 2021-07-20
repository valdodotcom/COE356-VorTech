import 'package:flutter/material.dart';
import '../ui/shop_page.dart';

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
                                new SignInPage());

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
                new ElevatedButton(
                    child: new Text("Sign in"),
                    onPressed: () {
                      var router = new MaterialPageRoute(
                          builder: (BuildContext context) => new ShopPage());
                      Navigator.of(context).push(router);
                    }),
                new TextButton(
                  onPressed: () {
                    var router = new MaterialPageRoute(
                        builder: (BuildContext context) => new SignInPage());
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
