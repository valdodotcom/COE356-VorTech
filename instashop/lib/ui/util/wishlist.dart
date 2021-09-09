import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:instashop/widgets/custom_nav_bar.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({Key? key}) : super(key: key);

  @override
  _WishlistPageState createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {

  late Future<List<dynamic>> futureAlbums;

  @override
  void initState() {
    super.initState();
    futureAlbums = fetchAlbums();
  }

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
    return WillPopScope(onWillPop: _backTwice,
      child: new Scaffold(
          appBar: new AppBar(
            leading: new Container(),
            backgroundColor: Color(0xff00eaff),
            title: new Text("Wishlist"),
          ),

          body: new Center(
            child: FutureBuilder<List<dynamic>>(
              future: futureAlbums,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return GridView.builder(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 400,
                          childAspectRatio: 2 / 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 20),
                      itemCount: snapshot.data!.toList().length,
                      padding: EdgeInsets.all(15),
                      itemBuilder: (BuildContext ctx, int position) {
                        return Container(
                          alignment: Alignment.center,
                          child: Stack(
                            children: <Widget>[
                              new Center(
                                  child: Image.network('https://drive.google.com/uc?export=view&id=1WELyBDOrZKbP6qPZgzHdtD82yr8ba4Ip',
                                      fit: BoxFit.fill)),
                              new Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  new Container(
                                    padding: EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      '${snapshot.data!.toList()[position].shopName}',
                                      style: new TextStyle(
                                          fontSize: 20, color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  new Container(
                                    padding: EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: new Text(
                                      '\$ ${snapshot.data!.toList()[position].vendorEmail}',
                                      style: new TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                  ),
                                  new Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      ElevatedButton(
                                          onPressed: () {
                                            final addedToCart = SnackBar(
                                              content: new Text("View item in page"),
                                              action: SnackBarAction(
                                                label: "View",
                                                onPressed: () => debugPrint("Yes")/*{
                                                var router = new MaterialPageRoute(
                                                    builder: (BuildContext context) =>
                                                    new CartPage());

                                                Navigator.of(context).push(router);
                                              }*/,
                                              ),
                                            );
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(addedToCart);
                                          },
                                          child:
                                          new Icon(Icons.grid_view)),
                                      Padding(padding: EdgeInsets.all(10)),
                                      ElevatedButton(
                                          onPressed: () {
                                            final addedToWishlist = SnackBar(
                                              content: new Text("Removed from wishlist"),
                                              action: SnackBarAction(
                                                label: "Undo",
                                                onPressed: () {},
                                              ),
                                            );
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(addedToWishlist);
                                          },

                                          child: new Icon(Icons.highlight_remove_outlined)),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white70,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.white12)),
                        );
                      });
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            ),
          ),




          bottomNavigationBar: new CustomNavBar(index: 1)),);
  }
}

Future<List<dynamic>> fetchAlbums() async {
  final response = await http
      .get(Uri.parse('http://10.74.239.230:8000/get-all-vendors'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    dynamic data = jsonDecode(response.body);
    return data.map((element) => Album.fromJson(element)).toList();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Album {
  Album({
    required this.shopName,
    required this.vendorAddress,
    required this.vendorEmail,
    required this.vendorFirstName,
    required this.vendorId,
    required this.vendorLastName,
    required this.vendorPassword,
    required this.vendorPhoneNo,
  });

  final String shopName;
  final String vendorAddress;
  final String vendorEmail;
  final String vendorFirstName;
  final String vendorId;
  final String vendorLastName;
  final String vendorPassword;
  final int vendorPhoneNo;

  factory Album.fromJson(Map<String, dynamic> json) => Album(
    shopName: json["ShopName"],
    vendorAddress: json["VendorAddress"],
    vendorEmail: json["VendorEmail"],
    vendorFirstName: json["VendorFirstName"],
    vendorId: json["VendorID"],
    vendorLastName: json["VendorLastName"],
    vendorPassword: json["VendorPassword"],
    vendorPhoneNo: json["VendorPhoneNo"],
  );

  Map<String, dynamic> toJson() => {
    "ShopName": shopName,
    "VendorAddress": vendorAddress,
    "VendorEmail": vendorEmail,
    "VendorFirstName": vendorFirstName,
    "VendorID": vendorId,
    "VendorLastName": vendorLastName,
    "VendorPassword": vendorPassword,
    "VendorPhoneNo": vendorPhoneNo,
  };
}
