import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:instashop/config/link.dart' as link;

import 'package:flutter/material.dart';
import 'package:instashop/ui/util/wishlist_item.dart';
import 'package:instashop/widgets/box_decoration.dart';
import 'package:instashop/widgets/custom_nav_bar.dart';

import '../product_page.dart';

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
          appBar: new AppBar(
            leading: new Container(),
            backgroundColor: Color(0xff00eaff),
            title: new Text("Wishlist"),
          ),
          body: new Center(
            child: FutureBuilder<List<dynamic>>(
              future: futureAlbums,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
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
                          return InkWell(
                            onTap: () {
                              var router = new MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      new WishlistItem(id: '${snapshot.data!.toList()[position].wishlistId}'));

                              Navigator.of(context).push(router);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              child: Stack(
                                children: <Widget>[
                                  new Center(
                                    child: ClipRRect(
                                        child: Image.network(
                                            '${snapshot.data!.toList()[position].productPicture}'),
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                  ),
                                  new Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      new Container(
                                        padding: EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          color: Colors.black54,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          '${snapshot.data!.toList()[position].product}',
                                          style: new TextStyle(
                                              fontSize: 20,
                                              color: Colors.white),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      new Container(
                                        padding: EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          color: Colors.black54,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: new Text(
                                          '¢ ${snapshot.data!.toList()[position].productPrice}',
                                          style: new TextStyle(
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                      ),
                                      new Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          ElevatedButton(
                                              onPressed: () {
                                                var router = new MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        new ProductPage(
                                                            name:
                                                                '${snapshot.data!.toList()[position].shopName}'));

                                                Navigator.of(context)
                                                    .push(router);
                                              },
                                              child: new Icon(Icons.grid_view)),
                                          Padding(padding: EdgeInsets.all(10)),
                                          ElevatedButton(
                                              onPressed: () {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return new AlertDialog(
                                                        title: new Text(
                                                            "Remove from wishlist"),
                                                        content: new Text(
                                                            "Are you sure you want to remove this item from your wishlist? "
                                                            "This cannot be undone."),
                                                        actions: <Widget>[
                                                          Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(10)),
                                                          ElevatedButton(
                                                              onPressed: () {

                                                                var router = new MaterialPageRoute(
                                                                    builder: (BuildContext context) =>
                                                                    new WishlistPage());
                                                                Navigator.of(context).push(router);


                                                                setState(() {
                                                                  futureAlbums =
                                                                      deleteAlbum(link.server, snapshot.data!.toList()[position].wishlistId) as Future<List>;
                                                                });
                                                              },
                                                              child: new Text(
                                                                  "Yes")),
                                                          TextButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: new Text(
                                                                  "Cancel"))
                                                        ],
                                                      );
                                                    });
                                              },
                                              child: new Icon(
                                                  Icons.delete_forever)),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              margin: EdgeInsets.all(10),
                              padding: EdgeInsets.all(15),
                              decoration: tempBoxDecoration(),
                            ),
                          );
                        });
                  }
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            ),
          ),
          bottomNavigationBar: new CustomNavBar(index: 1)),
    );
  }
}

Future<List<dynamic>> fetchAlbums() async {
  final response =
      await http.get(Uri.parse('${link.server}view-customer-wishlist/1'));

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
    required this.customerFirstName,
    required this.customerLastName,
    required this.product,
    required this.productPicture,
    required this.productPrice,
    required this.shopName,
    required this.wishlistId,
  });

  final String customerFirstName;
  final String customerLastName;
  final String product;
  final String productPicture;
  final double productPrice;
  final String shopName;
  final String wishlistId;

  factory Album.fromJson(Map<String, dynamic> json) => Album(
        customerFirstName: json["CustomerFirstName"],
        customerLastName: json["CustomerLastName"],
        product: json["Product"],
        productPicture: json["ProductPicture"],
        productPrice: json["ProductPrice"],
        shopName: json["ShopName"],
        wishlistId: json["WishlistID"],
      );

  Map<String, dynamic> toJson() => {
        "CustomerFirstName": customerFirstName,
        "CustomerLastName": customerLastName,
        "Product": product,
        "ProductPicture": productPicture,
        "ProductPrice": productPrice,
        "ShopName": shopName,
        "WishlistID": wishlistId,
      };
}
