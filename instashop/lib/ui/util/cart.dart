import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:instashop/config/link.dart' as link;
import 'package:instashop/ui/shops/categories.dart';
import 'package:instashop/widgets/box_decoration.dart';
import 'package:instashop/widgets/custom_nav_bar.dart';
import 'package:number_inc_dec/number_inc_dec.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late Future<List<dynamic>> futureAlbums;
  Dio dio = new Dio();
  var _customerID = "1";

  @override
  void initState() {
    super.initState();
    futureAlbums = fetchAlbums("1");
  }

  Future<void> _addToOrderHistory(String productId) async {
    dynamic data = {"ProductID": "$productId", "CustomerID": _customerID};

    var response = await dio.post("${link.server}new-order-history",
        data: data, options: Options());

    if (response.statusCode == 200) {
      new AlertDialog(
        title: new Text("Success!"),
        content: new Text("Your order has been placed successfully "
            "and you will be contacted by the respective vendor(s) shortly."),
        actions: <Widget>[
          ElevatedButton(
              onPressed: () {
                var router = new MaterialPageRoute(
                    builder: (BuildContext context) => new Categories());
                Navigator.of(context).push(router);
              },
              child: new Text("Continue shopping"))
        ],
      );
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Unable to add to wishlist")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("My Cart"),
        backgroundColor: Color(0xff00eaff),
      ),
      body: new Center(
        child: FutureBuilder<List<dynamic>>(
          future: futureAlbums,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                child: Scrollbar(
                  thickness: 0.01,
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: <Widget>[
                        GridView.builder(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
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
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
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
                                            '¢ ${snapshot.data!.toList()[position].productPrice.toStringAsFixed(2)}',
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
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return new AlertDialog(
                                                          title: new Text(
                                                              "Select Quantity"),
                                                          content: new Text(
                                                              "Increase/decrease quantity to purchase "
                                                              "(dependent on availability)"),
                                                          actions: <Widget>[
                                                            NumberInputPrefabbed
                                                                .roundedButtons(
                                                              controller:
                                                                  TextEditingController(),
                                                              incDecBgColor:
                                                                  Colors.blue
                                                                      .shade400,
                                                              initialValue: 1,
                                                              min: 1,
                                                              max: 10,
                                                            ),
                                                            Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            10)),
                                                            ElevatedButton(
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                                child: new Text(
                                                                    "Enter"))
                                                          ],
                                                        );
                                                      });
                                                },
                                                child: new Icon(Icons.add)),
                                            Padding(
                                                padding: EdgeInsets.all(10)),
                                            ElevatedButton(
                                                onPressed: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return new AlertDialog(
                                                          title: new Text(
                                                              "Remove from cart"),
                                                          content: new Text(
                                                              "Are you sure you want to remove this item from your cart? "
                                                              "This cannot be undone."),
                                                          actions: <Widget>[
                                                            Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            10)),
                                                            ElevatedButton(
                                                                onPressed: () {
                                                                  var router = new MaterialPageRoute(
                                                                      builder: (BuildContext
                                                                              context) =>
                                                                          new CartPage());
                                                                  Navigator.of(
                                                                          context)
                                                                      .push(
                                                                          router);

                                                                  setState(() {
                                                                    futureAlbums = deleteAlbum(snapshot
                                                                        .data!
                                                                        .toList()[
                                                                            position]
                                                                        .cartId) as Future<List>;
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
                              );
                            }),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Center(
                            child: InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        double _total = 0;
                                        for (int i = 0;
                                            i < snapshot.data!.toList().length;
                                            i++) {
                                          _total += snapshot.data!
                                              .toList()[i]
                                              .productPrice;
                                          print(_total);
                                          print("${snapshot.data!.toList()[i].productId}");
                                        }
                                        return new AlertDialog(
                                          title: new Text("Checkout"),
                                          content: new Text("Total: ¢$_total"),
                                          actions: <Widget>[
                                            Padding(
                                                padding: EdgeInsets.all(10)),
                                            ElevatedButton(
                                                onPressed: () {

                                                    for (int i = 0;
                                                        i <
                                                            snapshot.data!
                                                                .toList()
                                                                .length;
                                                        i++) {
                                                    futureAlbums =
                                                        _addToOrderHistory(
                                                                "${snapshot.data!.toList()[i].productId}")
                                                            as Future<List>;
                                                  }
                                                },
                                                child: new Text("Accept")),
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: new Text("Cancel"))
                                          ],
                                        );
                                      });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        // BoxShadow(
                                        //   color: Colors.white.withOpacity(0.5),
                                        //   spreadRadius: 5,
                                        //   blurRadius: 7,
                                        //   offset: Offset(0, 3),
                                        // )
                                      ],
                                      color: Colors.blue,
                                      // borderRadius: BorderRadius.circular(15),
                                      border:
                                          Border.all(color: Colors.white12)),
                                  padding: EdgeInsets.all(15.0),
                                  child: new Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Text(" CHECKOUT",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0,
                                          )),
                                    ],
                                  ),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Text('${snapshot.error}');
            }
            // By default, show a loading spinner.
            // return const CircularProgressIndicator();
          },
        ),
      ),
      bottomNavigationBar: CustomNavBar(index: 0),
    );
  }
}

Future<List<dynamic>> fetchAlbums(String customerId) async {
  final response =
      await http.get(Uri.parse('${link.server}view-customer-cart/$customerId'));

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

Future<Album> deleteAlbum(String idOfCart) async {
  final http.Response response = await http.delete(
    Uri.parse('${link.server}delete-from-cart/$idOfCart'),
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
    required this.cartId,
    required this.customerFirstName,
    required this.customerId,
    required this.customerLastName,
    required this.product,
    required this.productId,
    required this.productPicture,
    required this.productPrice,
  });

  final String cartId;
  final String customerFirstName;
  final int customerId;
  final String customerLastName;
  final String product;
  final int productId;
  final String productPicture;
  final double productPrice;

  factory Album.fromJson(Map<String, dynamic> json) => Album(
        cartId: json["CartID"],
        customerFirstName: json["CustomerFirstName"],
        customerId: json["CustomerID"],
        customerLastName: json["CustomerLastName"],
        product: json["Product"],
        productId: json["ProductID"],
        productPicture: json["ProductPicture"],
        productPrice: json["ProductPrice"],
      );

  Map<String, dynamic> toJson() => {
        "CartID": cartId,
        "CustomerFirstName": customerFirstName,
        "CustomerID": customerId,
        "CustomerLastName": customerLastName,
        "Product": product,
        "ProductID": productId,
        "ProductPicture": productPicture,
        "ProductPrice": productPrice,
      };
}
