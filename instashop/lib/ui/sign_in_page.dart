import '../ui/new_account_page.dart';
import 'package:flutter/material.dart';
import '../ui/shop_page.dart';
import 'package:http/http.dart' as http;


class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String _userEmail = '';
  String _password = '';

  Future<void> _trySubmitForm() async {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      var response = await http.post(Uri.parse("https://reqres.in/api/login"),
          body:({
        "email": _emailController.text,
        "password": _passwordController.text
          }));
      if (response.statusCode == 200) {
        var router = new MaterialPageRoute(
            builder: (BuildContext context) =>
            new ShopPage());
        Navigator.of(context).push(router);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Invalid Credentials")));
      }

      print(_userEmail);
      print(_password);

      /*
      Continue processing the provided information with your own logic
      such us sending HTTP requests, saving to SQLite database, etc.
      */
    }
  }

  @override
  Widget build(BuildContext context) {

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
                      onPressed: _trySubmitForm
                      ),


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