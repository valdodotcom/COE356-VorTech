import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:instashop/ui/cart.dart';

// import '../ui/cart.dart';
// import '../ui/wishlist.dart';
// import '../ui/item_in_category.dart';
List _product = [];

void main() async {
  _product = await getProduct();
  print(_product[0]);

  for (int i = 0; i < _product.length; i++) {
    print(_product[i]['title']);
    print("Description: ${_product[i]['description']}");
  }

  runApp(MaterialApp(
    title: 'ProdPage',
    home: ProductPage(),
  ));
}

class ProductPage extends StatelessWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Accra Thrift"),
          backgroundColor: Color(0xff00eaff),
        ),

        body: new Center(
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 400,
                  childAspectRatio: 2 / 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 20),
              itemCount: _product.length,
              padding: EdgeInsets.all(15),
              itemBuilder: (BuildContext ctx, int position) {
                return Container(
                  alignment: Alignment.center,
                  child: Stack(
                    children: <Widget>[
                      new Center(
                          child: Image.network('${_product[position]['image']}',
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
                              '${_product[position]['title']}',
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
                              '\$ ${_product[position]['price']}',
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
              }),
        ));
  }
}

Future<List> getProduct() async {
  var apiUrl =
      Uri.parse('https://fakestoreapi.com/products/category/jewelery');

  http.Response response = await http.get(apiUrl);

  return json.decode(response.body);
}
