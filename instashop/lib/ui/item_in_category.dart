import 'package:flutter/material.dart';
import '../ui/product_page.dart';
import 'cart.dart';
// import '../ui/wishlist.dart';
// import '../ui/item_in_category.dart';

class VendorInShop extends StatefulWidget {
  const VendorInShop({Key? key}) : super(key: key);

  @override
  _VendorInShopState createState() => _VendorInShopState();
}

class _VendorInShopState extends State<VendorInShop> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Color(0xff00eaff),
        title: new Text("Clothes & Accessories"),
        actions: <Widget>[
          new IconButton(
              onPressed: () => debugPrint("Search pressed"),
              icon: new Icon(Icons.search)),

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

      body: new Container(
        // alignment: Alignment.center,
        child: new ListView(
          // padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          children: <Widget>[
            new InkWell(
              onTap: () {
                var router = new MaterialPageRoute(
                    builder: (BuildContext context) => new ProductPage());

                Navigator.of(context).push(router);
              },
              child: new Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  new Image.asset(
                    'images/clothes.jpeg',
                    height: 200.0,
                    width: 300.0,
                  ),
                  new Text("Accra Thrift",
                      style: new TextStyle(
                        fontSize: 40.0,
                        color: Colors.white,
                      )),
                ],
              ),
            ),


          ],
        ),
      ),


    );
  }
}
