import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:instashop/ui/product_page.dart';
import 'package:instashop/widgets/custom_nav_bar.dart';

class Beauty extends StatefulWidget {
  const Beauty({Key? key}) : super(key: key);

  @override
  _BeautyState createState() => _BeautyState();
}

class _BeautyState extends State<Beauty> {
  late Future<List<dynamic>> futureAlbums;

  @override
  void initState() {
    super.initState();
    futureAlbums = fetchAlbums();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          backgroundColor: Color(0xff00eaff),
          title: new Text("Beauty & Personal Care"),
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
                      return InkWell(
                          onTap: () {
                            var router = new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                new ProductPage());

                            Navigator.of(context).push(router);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            child: Stack(
                              children: <Widget>[
                                new Center(
                                    child: Image.network(
                                        '${snapshot.data!.toList()[position].shopPicture}',
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
                                    new Container(),
                                  ],
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                                color: Colors.white70,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: Colors.white12)),
                          ));
                    });
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
        bottomNavigationBar: new CustomNavBar(index: 0));
  }
}

Future<List<dynamic>> fetchAlbums() async {
  final response = await http.get(Uri.parse(
      'http://10.74.239.230:8000/get-shops/category/Beauty & Fashion'));

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
    required this.productCategory,
    required this.shopName,
    required this.shopPicture,
  });

  final String productCategory;
  final String shopName;
  final String shopPicture;

  factory Album.fromJson(Map<String, dynamic> json) => Album(
    productCategory: json["ProductCategory"],
    shopName: json["ShopName"],
    shopPicture: json["ShopPicture"],
  );

  Map<String, dynamic> toJson() => {
    "ProductCategory": productCategory,
    "ShopName": shopName,
    "ShopPicture": shopPicture,
  };
}
