import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/link.dart' as link;
import 'package:flutter/material.dart';
import 'package:instashop/ui/product_page.dart';
import 'package:instashop/widgets/custom_nav_bar.dart';

class ShopInCategory extends StatefulWidget {
  final String name;

  const ShopInCategory({Key? key, required this.name}) : super(key: key);

  @override
  _ShopInCategoryState createState() => _ShopInCategoryState();
}

class _ShopInCategoryState extends State<ShopInCategory> {
  late Future<List<dynamic>> futureAlbums;

  @override
  void initState() {
    super.initState();
    // futureAlbums = fetchAlbums(link.server, link.defaultCategory);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          backgroundColor: Color(0xff00eaff),
          title: new Text('${widget.name}'),
        ),
        body: new Center(
          child: tempWidget("${widget.name}"),
        ),
        bottomNavigationBar: new CustomNavBar(index: 0));
  }


}


Widget tempWidget(String categoryName) {
  var futureAlbums = fetchAlbums(link.server, categoryName);
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
              return InkWell(
                  onTap: () {
                    var router = new MaterialPageRoute(
                        builder: (BuildContext context) =>
                        new ProductPage(name: '${snapshot.data!.toList()[position].shopName}'));

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
                                boxShadow: [BoxShadow(
                                  color: Colors.grey.withOpacity(0.5)
                                )],
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
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(23),
                    decoration: BoxDecoration(
                        boxShadow: [BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0,3),
                        )],
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
  );
}


Future<List<dynamic>> fetchAlbums(String server, String categoryName) async {
  final response = await http.get(Uri.parse(
      '${link.server}get-shops/category/$categoryName'));

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
