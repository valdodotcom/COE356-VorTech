import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:instashop/ui/util/cart.dart';
import 'package:instashop/ui/util/wishlist.dart';
import 'package:instashop/widgets/box_decoration.dart';
import 'package:instashop/widgets/custom_nav_bar.dart';
import '../../config/link.dart' as link;
import 'package:instashop/config/customerID.dart' as id;
import 'package:dio/dio.dart';

class ProductPage extends StatefulWidget {
  final String name;

  const ProductPage({Key? key, required this.name}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late Future<List<dynamic>> futureAlbums;
  Dio dio = new Dio();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _addToWishlist(String productId) async {
    dynamic data = {"ProductID": "$productId", "CustomerID": id.customer};

    var response = await dio.post("${link.server}add-to-wishlist",
        data: data, options: Options());

    if (response.statusCode == 200) {
      final addedToWishlist = SnackBar(
        content: new Text("Item added to wishlist!"),
        action: SnackBarAction(
          label: "View",
          onPressed: () {
            var router = new MaterialPageRoute(
                builder: (BuildContext context) => new WishlistPage());
            Navigator.of(context).push(router);

            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(addedToWishlist);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Unable to add to wishlist")));
    }
  }

  Future<void> _addToCart(String productId) async {
    dynamic data = {"ProductID": "$productId", "CustomerID": id.customer};

    var response = await dio.post("${link.server}add-to-cart",
        data: data, options: Options());

    if (response.statusCode == 200) {
      final addedToCart = SnackBar(
        content: new Text("Item added to cart!"),
        action: SnackBarAction(
          label: "View",
          onPressed: () {
            var router = new MaterialPageRoute(
                builder: (BuildContext context) => new CartPage());
            Navigator.of(context).push(router);

            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(addedToCart);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Unable to add to cart")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("${widget.name}"),
        backgroundColor: Color(0xff00eaff),
        actions: <Widget>[
          new IconButton(
              onPressed: () {
                var router = new MaterialPageRoute(
                    builder: (BuildContext context) => new CartPage());
                Navigator.of(context).push(router);

                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
              icon: new Icon(Icons.shopping_cart_outlined))
        ],
      ),
      body: new Center(
        child: tempWidget2("${widget.name}"),
      ),
      bottomNavigationBar: CustomNavBar(index: 0),
    );
    // ),
  }

  Widget tempWidget2(String nameOfShop) {
    var futureAlbums = fetchAlbums(nameOfShop);
    return new FutureBuilder<List<dynamic>>(
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
                        child: ClipRRect(
                          child: Image.network(
                              '${snapshot.data!.toList()[position].productPicture}',
                              fit: BoxFit.fill),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
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
                              '?? ${snapshot.data!.toList()[position].productPrice.toStringAsFixed(2)}',
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
                                    setState(() {
                                      futureAlbums = _addToCart(
                                              "${snapshot.data!.toList()[position].productId}")
                                          as Future<List>;
                                    });
                                  },
                                  child: new Icon(Icons.add_shopping_cart)),
                              Padding(padding: EdgeInsets.all(10)),
                              ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      futureAlbums = _addToWishlist(
                                              "${snapshot.data!.toList()[position].productId}")
                                          as Future<List>;
                                    });
                                  },
                                  child: new Icon(Icons.bookmark_add_outlined)),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(15),
                  decoration: tempBoxDecoration(),
                );
              });
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      },
    );
  }
}

Future<List<dynamic>> fetchAlbums(String nameOfShop) async {
  final response =
      await http.get(Uri.parse("${link.server}view-shop-products/$nameOfShop"));

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
    required this.productId,
    required this.productPicture,
    required this.productPrice,
    required this.shopName,
    required this.shopPicture,
  });

  final String product;
  final String productCategory;
  final String productDescription;
  final int productId;
  final String productPicture;
  final double productPrice;
  final String shopName;
  final String shopPicture;

  factory Album.fromJson(Map<String, dynamic> json) => Album(
        product: json["Product"],
        productCategory: json["ProductCategory"],
        productDescription: json["ProductDescription"],
        productId: json["ProductID"],
        productPicture: json["ProductPicture"],
        productPrice: json["ProductPrice"],
        shopName: json["ShopName"],
        shopPicture: json["ShopPicture"],
      );

  Map<String, dynamic> toJson() => {
        "Product": product,
        "ProductCategory": productCategory,
        "ProductDescription": productDescription,
        "ProductID": productId,
        "ProductPicture": productPicture,
        "ProductPrice": productPrice,
        "ShopName": shopName,
        "ShopPicture": shopPicture,
      };
}
