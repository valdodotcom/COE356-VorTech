import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../ui/cart.dart';
// import '../ui/wishlist.dart';
// import '../ui/item_in_category.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Accra Thrift"),
        backgroundColor: Color(0xff00eaff),
      ),
      body: new Container(
        child: new ListView(
          children: <Widget>[
            new Image.asset(
              'images/clothes.jpeg',
              width: 200,
              height: 200,
            ),
            new Text("Products",
                style: new TextStyle(
                  fontSize: 45.0,
                  color: Colors.blue.shade900,
                )),
            new Column(
              children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new Padding(padding: EdgeInsets.all(10)),
                    new Image.asset(
                      "images/bucket_hat.jpg",
                      height: 100.0,
                      width: 100.0,
                    ),
                    new Text("Bucket hat",
                        style: new TextStyle(
                          fontSize: 20.0,
                        )),
                    new OutlinedButton(
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
                        child: new Icon(Icons.add_shopping_cart)),
                    new OutlinedButton(
                        onPressed: () {
                          final addedToWishlist = SnackBar(
                            content: new Text("Item added to wishlist!"),
                            action: SnackBarAction(
                              label: "Undo",
                              onPressed: () {
                                // var router = new MaterialPageRoute(
                                //     builder: (BuildContext context) =>
                                //         new WishlistPage());
                                //
                                // Navigator.of(context).push(router);
                              },
                            ),
                          );
                          ScaffoldMessenger.of(context)
                              .showSnackBar(addedToWishlist);
                        },
                        child: new Icon(Icons.bookmark_add_outlined)),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
