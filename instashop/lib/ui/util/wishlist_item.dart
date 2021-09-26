import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:instashop/config/link.dart' as link;

import 'package:flutter/material.dart';
// import 'package:instashop/widgets/box_decoration.dart';
import 'package:instashop/widgets/custom_nav_bar.dart';

// import '../product_page.dart';


class WishlistItem extends StatefulWidget {
  final String id;

  const WishlistItem({Key? key, required this.id}) : super(key: key);

  @override
  _WishlistItemState createState() => _WishlistItemState();
}

class _WishlistItemState extends State<WishlistItem> {

  late Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum(link.server, widget.id);
  }



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
          appBar: new AppBar(
            backgroundColor: Color(0xff00eaff),
            title: new Text("Wishlist"),
          ),

          body: new Center(
            child: FutureBuilder<Album>(
              future: futureAlbum,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(snapshot.data?.productId ?? 'Deleted'),
                      ElevatedButton(
                        child: const Text('Delete Data'),
                        onPressed: () {
                          setState(() {
                            futureAlbum =
                                deleteAlbum(link.server, widget.id);
                          });
                        },
                      ),
                    ],
                  ) ;
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            ),
          ),




          bottomNavigationBar: new CustomNavBar(index: 1));
  }
}

Future<Album> fetchAlbum(String server, String idOfWishlist) async {
  final response = await http
      .get(Uri.parse('${link.server}view-wishlist-item/$idOfWishlist'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response, then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<Album> deleteAlbum(String server, String idOfWishlist) async {
  final http.Response response = await http.delete(
    Uri.parse('${link.server}delete-wishlist-item/$idOfWishlist'),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON. After deleting,
    // you'll get an empty JSON `{}` response.
    // Don't return `null`, otherwise `snapshot.hasData`
    // will always return false on `FutureBuilder`.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a "200 OK response",
    // then throw an exception.
    throw Exception('Failed to delete album.');
  }
}


class Album {
  Album({
    required this.customerId,
    required this.productId,
  });

  final int customerId;
  final String productId;

  factory Album.fromJson(Map<String, dynamic> json) => Album(
    customerId: json["CustomerID"],
    productId: json["ProductID"],
  );

  Map<String, dynamic> toJson() => {
    "CustomerID": customerId,
    "ProductID": productId,
  };
}

