import 'package:flutter/material.dart';
import '../ui/product_page.dart';
// import '../ui/wishlist.dart';
// import '../ui/item_in_category.dart';

class ItemInShop extends StatefulWidget {
  const ItemInShop({Key? key}) : super(key: key);

  @override
  _ItemInShopState createState() => _ItemInShopState();
}

class _ItemInShopState extends State<ItemInShop> {
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
