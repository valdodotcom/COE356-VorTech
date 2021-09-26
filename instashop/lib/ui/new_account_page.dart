import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:instashop/config/link.dart' as link;
import '../ui/categories.dart';
import '../ui/sign_in_page.dart';

class NewAccountPage extends StatefulWidget {
  const NewAccountPage({Key? key}) : super(key: key);

  @override
  _NewAccountPageState createState() => _NewAccountPageState();
}

class _NewAccountPageState extends State<NewAccountPage> {
  // key to access the form
  final _formKey = GlobalKey<FormState>();

  // controllers for form input
  var _firstNameController = TextEditingController();
  var _lastNameController = TextEditingController();
  var _emailController = TextEditingController();
  var _phoneNumberController = TextEditingController();
  var _addressController = TextEditingController();
  var _passwordController = TextEditingController();
  var _secondPasswordController = TextEditingController();


  String _userEmail = '';
  String _userName = '';
  String _password = '';
  String _confirmPassword = '';

  // function triggered when user presses sign up
  Future<void> _trySubmitForm() async {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      var response = await http.post(Uri.parse("${link.server}new-customer-info"),
          body: ({
            "CustomerFirstName": _firstNameController.text,
            "CustomerLastName": _lastNameController.text,
            "CustomerEmail": _emailController.text,
            "CustomerPhoneNo": _phoneNumberController.text,
            "CustomerPassword": _passwordController.text,
            "CustomerAddress": _addressController.text
          }));
      if (response.statusCode == 200) {
        var router = new MaterialPageRoute(
            builder: (BuildContext context) =>
            new Categories());
        Navigator.of(context).push(router);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Invalid Credentials")));
      }

      print('Everything looks good!');
      print(_userEmail);
      print(_userName);
      print(_password);
      print(_confirmPassword);



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
                          keyboardType: TextInputType.number,
                          controller: _phoneNumberController,
                          decoration: new InputDecoration(
                            labelText: "Phone Number",
                          ),
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return 'This field is required';
                            }
                            if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                              return 'Please enter a valid phone number';
                            }
                            // Return null if the entered username is valid
                            return null;
                          },
                          onChanged: (value) => _userName = value,
                        ),

                        new TextFormField(
                          controller: _addressController,
                          decoration: new InputDecoration(
                            labelText: "Address",
                          ),
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return 'This field is required';
                            }
                            if (value.trim().length < 5) {
                              return 'Address must be at least 5 characters in length';
                            }
                            // Return null if the entered username is valid
                            return null;
                          },
                          onChanged: (value) => _userName = value,
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
                            if (value!.isEmpty) {
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
                            onPressed: _trySubmitForm)
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


/*
Future<void> makePostRequest() async {
  const urlPrefix = 'http://10.74.236.15:8000/';

  final url = Uri.parse('$urlPrefix/new-customer-info');
  final headers = {"Content-type": "application/json"};
  final json =
      '{"CustomerName": "John Smith", "CustomerEmail": johnsmith@trial.com, "CustomerPhoneNo": 0234360065, "CustomerPassword": password1, "CustomerAddress": hall 7 }';
  final response = await post(url, headers: headers, body: json);
  print('Status code: ${response.statusCode}');
  print('Body: ${response.body}');
}
*/