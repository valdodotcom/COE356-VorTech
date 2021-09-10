import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:instashop/ui/util/cart.dart';
import '../config/link.dart' as link;

/*
import '../ui/wishlist.dart';
import '../ui/shop_in_category.dart';*/


class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late Future<List<dynamic>> futureAlbums;

  @override
  void initState() {
    super.initState();
    futureAlbums = fetchAlbums(link.server);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Accra Thrift"),
          backgroundColor: Color(0xff00eaff),

          actions: <Widget>[
            new IconButton(
                onPressed: () {
                  var router = new MaterialPageRoute(
                      builder: (BuildContext context) =>
                      new CartPage());
                  Navigator.of(context).push(router);
                  },
                icon: new Icon(Icons.shopping_cart_outlined))
          ],
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
                                child: Image.network('${snapshot.data!.toList()[position].productPicture}',
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
                                    '${snapshot.data!.toList()[position].product}',
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
                                    '¢ ${snapshot.data!.toList()[position].productPrice}',
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
                                            content: new Text("Item added to cart!"),
                                            action: SnackBarAction(
                                              label: "View",
                                              onPressed: () {
                                                var router = new MaterialPageRoute(
                                                    builder: (BuildContext context) =>
                                                    new CartPage());
                                                Navigator.of(context).push(router);

                                                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                              },
                                            ),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(addedToCart);
                                        },
                                        child:
                                        new Icon(Icons.shopping_cart_outlined)),
                                    Padding(padding: EdgeInsets.all(10)),
                                    ElevatedButton(
                                        onPressed: () {
                                          final addedToWishlist = SnackBar(
                                            content: new Text("Item added to wishlist!"),
                                            action: SnackBarAction(
                                              label: "Undo",
                                              onPressed: () {},
                                            ),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(addedToWishlist);
                                        },

                                        child: new Icon(Icons.bookmark_add_outlined)),
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
        ));
    // ),
  }
}

Future<List<dynamic>> fetchAlbums(String server) async {
  final response = await http
      .get(Uri.parse("${link.server}view-shop-products/Kate's Fashion"));

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
    required this.product,
    required this.productCategory,
    required this.productDescription,
    required this.productPicture,
    required this.productPrice,
    required this.shopName,
    required this.shopPicture,
  });

  final String product;
  final String productCategory;
  final String productDescription;
  final String productPicture;
  final double productPrice;
  final String shopName;
  final String shopPicture;

  factory Album.fromJson(Map<String, dynamic> json) => Album(
    product: json["Product"],
    productCategory: json["ProductCategory"],
    productDescription: json["ProductDescription"],
    productPicture: json["ProductPicture"],
    productPrice: json["ProductPrice"],
    shopName: json["ShopName"],
    shopPicture: json["ShopPicture"],
  );

  Map<String, dynamic> toJson() => {
    "Product": product,
    "ProductCategory": productCategory,
    "ProductDescription": productDescription,
    "ProductPicture": productPicture,
    "ProductPrice": productPrice,
    "ShopName": shopName,
    "ShopPicture": shopPicture,
  };
}
