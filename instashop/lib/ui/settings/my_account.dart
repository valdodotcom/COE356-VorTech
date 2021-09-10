import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:instashop/config/link.dart' as link;

import 'dart:convert';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({Key? key}) : super(key: key);

  @override
  _MyAccountPageState createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  late Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum(link.server);
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        // leading: new Container(),
        backgroundColor: Color(0xff00eaff),
        title: new Text("Settings"),
      ),
      body: new Center(
        child: FutureBuilder<Album>(
          future: futureAlbum,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return new Container(
                padding: new EdgeInsets.all(20),
                child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                  new Padding(padding: EdgeInsets.fromLTRB(0, 50, 0, 0)),
                  new Text(
                    "    Account Details",
                    style: new TextStyle(
                      fontSize: 20,
                      color: Colors.blue.shade900,
                    ),

                  ),
                  new Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 10)),


                  new Container(
                    decoration: new BoxDecoration(
                        // color: Colors.grey,
                        borderRadius: BorderRadius.circular(10)),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0)),
                        new Text(
                            "Name: " +
                                snapshot.data!.customerFirstName +
                                " " +
                                snapshot.data!.customerLastName,
                            style: new TextStyle(fontSize: 16)),

                        new Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 10)),


                        new Text("Email: " + snapshot.data!.customerEmail,
                            style: new TextStyle(fontSize: 16)),

                        new Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 10)),

                        new Text(
                            "Phone number: " "0" +
                                snapshot.data!.customerPhoneNo.toString(),
                            style: new TextStyle(fontSize: 16)),

                        new Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 10)),


                        new Text("Address: " + snapshot.data!.customerAddress,
                            style: new TextStyle(fontSize: 16)),
                      ],
                    ),
                  )
                ]),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

Future<Album> fetchAlbum(String server) async {
  final response = await http
      .get(Uri.parse('${link.server}get-customer-info/1'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

/*class Album {
  final int userId;
  final int id;
  final String title;

  Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}*/

class Album {
  Album({
    required this.customerAddress,
    required this.customerEmail,
    required this.customerFirstName,
    required this.customerLastName,
    required this.customerPhoneNo,
  });

  final String customerAddress;
  final String customerEmail;
  final String customerFirstName;
  final String customerLastName;
  final int customerPhoneNo;

  factory Album.fromJson(Map<String, dynamic> json) => Album(
        customerAddress: json["CustomerAddress"],
        customerEmail: json["CustomerEmail"],
        customerFirstName: json["CustomerFirstName"],
        customerLastName: json["CustomerLastName"],
        customerPhoneNo: json["CustomerPhoneNo"],
      );

  Map<String, dynamic> toJson() => {
        "CustomerAddress": customerAddress,
        "CustomerEmail": customerEmail,
        "CustomerFirstName": customerFirstName,
        "CustomerLastName": customerLastName,
        "CustomerPhoneNo": customerPhoneNo,
      };
}
