import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import '../ui/wishlist.dart';
// import '../ui/item_in_category.dart';

List _cart = [];

void main() async {
  _cart = await getProduct();
  print(_cart[0]);

  for (int i = 0; i < _cart.length; i++) {
    print(_cart[i]['products']);
    print("Description: ${_cart[i]['date']}");
  }

  runApp( MaterialApp(
    title: 'ProdPage',
    home: CartPage(),
  ));
}

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("My Cart"),
        backgroundColor: Color(0xff00eaff),
      ),

        body: new Center(
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 400,
                  childAspectRatio: 2 / 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 20),
              itemCount: _cart.length,
              padding: EdgeInsets.all(15),
              itemBuilder: (BuildContext ctx, int position) {
                return Container(
                  alignment: Alignment.center,
                  child: Stack(
                    children: <Widget>[
                      new Center(
                          // child: Image.network('${_cart[position]['image']}',
                          //     fit: BoxFit.fill)
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
                              '${_cart[position]['date']}',
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
                              '\$ ${_cart[position]['products']}',
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
        )

    );
  }
}

Future<List> getProduct() async {
  var apiUrl =
  Uri.parse('https://fakestoreapi.com/carts');

  http.Response response = await http.get(apiUrl);

  return json.decode(response.body);
}

