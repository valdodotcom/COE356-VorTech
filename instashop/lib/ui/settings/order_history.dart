import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:instashop/config/link.dart' as link;
import 'package:flutter/material.dart';
import 'package:instashop/ui/settings/settings.dart';
import 'package:instashop/widgets/box_decoration.dart';
import 'package:instashop/widgets/custom_nav_bar.dart';


class OrderHistory extends StatefulWidget {
  const OrderHistory({Key? key}) : super(key: key);

  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {

  late Future<List<dynamic>> futureAlbums;

  @override
  void initState() {
    super.initState();
    futureAlbums = fetchAlbums("1");
  }


  @override
  Widget build(BuildContext context) {
      return new Scaffold(
          appBar: new AppBar(
            leading: new IconButton(
                onPressed: () {
                  var router = new MaterialPageRoute(
                      builder: (BuildContext context) =>
                      new SettingsPage());
                  Navigator.of(context).push(router);
                },
                icon: new Icon(Icons.arrow_back)),
            backgroundColor: Color(0xff00eaff),
            title: new Text("Order History"),
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
                                child: ClipRRect(child: Image.network('${snapshot.data!.toList()[position].productPicture}'),
                                    borderRadius: BorderRadius.circular(8.0)),),


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
                                      '¢ ${snapshot.data!.toList()[position].productPrice.toStringAsFixed(2)}',
                                      style: new TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                  ),
                                  new Container(
                                    padding: EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      '${snapshot.data!.toList()[position].orderDate}',
                                      style: new TextStyle(
                                          fontSize: 20, color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  new Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      /*ElevatedButton(
                                          onPressed: () {

                                             var router = new MaterialPageRoute(
                                                builder: (BuildContext context) =>
                                                new ProductPage(name: '${snapshot.data!.toList()[position].shopName}'));

                                            Navigator.of(context).push(router);

                                          },
                                          child:
                                          new Icon(Icons.grid_view)),*/
                                      Padding(padding: EdgeInsets.all(10)),
                                      ElevatedButton(
                                          onPressed: () {



                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return new AlertDialog(
                                                    title: new Text(
                                                        "Remove from history"),
                                                    content: new Text(
                                                        "Are you sure you want to remove this item from your history? "
                                                            "This cannot be undone."),
                                                    actions: <Widget>[
                                                      Padding(
                                                          padding:
                                                          EdgeInsets.all(
                                                              10)),
                                                      ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.of(context).pop();

                                                          },
                                                          child:
                                                          new Text("Yes")),

                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.of(context).pop();

                                                          },
                                                          child:
                                                          new Text("Cancel"))
                                                    ],
                                                  );
                                                });


                                          },

                                          child: new Icon(Icons.highlight_remove_outlined)),
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
            ),
          ),




          bottomNavigationBar: new CustomNavBar(index: 2));
  }
}

Future<List<dynamic>> fetchAlbums(String customerId) async {
  final response = await http
      .get(Uri.parse('${link.server}view-customer-history/$customerId'));

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
    required this.customerFirstName,
    required this.customerLastName,
    required this.orderDate,
    required this.orderId,
    required this.product,
    required this.productPicture,
    required this.productPrice,
    required this.vendorFirstName,
    required this.vendorLastName,
  });

  final String customerFirstName;
  final String customerLastName;
  final DateTime orderDate;
  final String orderId;
  final String product;
  final String productPicture;
  final double productPrice;
  final String vendorFirstName;
  final String vendorLastName;

  factory Album.fromJson(Map<String, dynamic> json) => Album(
    customerFirstName: json["CustomerFirstName"],
    customerLastName: json["CustomerLastName"],
    orderDate: DateTime.parse(json["OrderDate"]),
    orderId: json["OrderID"],
    product: json["Product"],
    productPicture: json["ProductPicture"],
    productPrice: json["ProductPrice"],
    vendorFirstName: json["VendorFirstName"],
    vendorLastName: json["VendorLastName"],
  );

  Map<String, dynamic> toJson() => {
    "CustomerFirstName": customerFirstName,
    "CustomerLastName": customerLastName,
    "OrderDate": orderDate.toIso8601String(),
    "OrderID": orderId,
    "Product": product,
    "ProductPicture": productPicture,
    "ProductPrice": productPrice,
    "VendorFirstName": vendorFirstName,
    "VendorLastName": vendorLastName,
  };
}

