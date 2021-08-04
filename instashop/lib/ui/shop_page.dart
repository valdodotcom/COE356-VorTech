import 'dart:io';

import 'package:flutter/material.dart';
import 'package:instashop/widgets/custom_nav_bar.dart';
import '../ui/item_in_category.dart';
import 'cart.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  DateTime _lastQuitTime = DateTime(0);

  Future<bool> _backTwice() async {
    if (_lastQuitTime == null ||
        DateTime.now().difference(_lastQuitTime).inSeconds > 1) {
      print('Press again Back Button exit');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Press back button again to exit')));
      _lastQuitTime = DateTime.now();
      return false;
    } else {
      print('sign out');
      Navigator.of(context).pop(exit(0));
    }
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _backTwice,
      child: new Scaffold(
          appBar: new AppBar(
            leading: new Container(),
            backgroundColor: Color(0xff00eaff),
            title: new Container(
              padding: EdgeInsets.fromLTRB(9.0, 0.0, 0.0, 0.0),
              decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: new TextFormField(
              decoration: new InputDecoration(
                hintText: "Search for vendor by name",

              ),
            ),)
            ,
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
          body: new ListView(
            padding: EdgeInsets.all(15.0),
            children: <Widget>[
              new Container(padding: EdgeInsets.fromLTRB(0,0,0,10),
          child: new Center(
                child: new Text("Browse by Category",
                  style: new TextStyle(
                    fontSize: 20.0,
                    color: Colors.blue.shade900,
                  ),),),),
             

              new Column(
                children: <Widget>[
                  new InkWell(
                      onTap: () {
                        var router = new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                new VendorInShop());

                        Navigator.of(context).push(router);
                      },
                      child: new Container(
                        color: Colors.grey.shade200,
                        padding: EdgeInsets.all(15.0),
                        child: new Row(
                          children: <Widget>[
                            new Icon(
                              Icons.shopping_bag_rounded,
                              size: 40,
                              color: Colors.blue,
                            ),
                            new Text(
                              "\t\t\t Clothes & Accessories",
                              style: new TextStyle(
                                  fontSize: 20.0, color: Colors.blue.shade800),
                            ),
                          ],
                        ),
                      )),
                  new Padding(padding: EdgeInsets.all(10)),
                  new InkWell(
                    onTap: () {
                      return debugPrint("Button pressed");

                      // var router = new MaterialPageRoute(
                      //     builder: (BuildContext context) =>
                      //         new ItemInShop());
                      //
                      // Navigator.of(context).push(router);
                    },
                    child: new Container(
                        color: Colors.grey.shade200,
                        padding: EdgeInsets.all(15.0),
                        child: new Row(
                          children: <Widget>[
                            new Icon(
                              Icons.fastfood,
                              size: 40,
                              color: Colors.blue,
                            ),
                            new Text(
                              "\t\t\t Food",
                              style: new TextStyle(
                                  fontSize: 20.0, color: Colors.blue.shade800),
                            ),
                          ],
                        )),
                  ),
                  new Padding(padding: EdgeInsets.all(10)),
                  new InkWell(
                    onTap: () {
                      return debugPrint("Button pressed");

                      // var router = new MaterialPageRoute(
                      //     builder: (BuildContext context) =>
                      //         new ItemInShop());
                      //
                      // Navigator.of(context).push(router);
                    },
                    child: new Container(
                        color: Colors.grey.shade200,
                        padding: EdgeInsets.all(15.0),
                        child: new Row(
                          children: <Widget>[
                            new Icon(
                              Icons.phonelink,
                              size: 40,
                              color: Colors.blue,
                            ),
                            new Text(
                              "\t\t\t Tech & Gadgets",
                              style: new TextStyle(
                                  fontSize: 20.0, color: Colors.blue.shade800),
                            ),
                          ],
                        )),
                  ),
                  new Padding(padding: EdgeInsets.all(10)),
                  new InkWell(
                    onTap: () {
                      return debugPrint("Button pressed");

                      // var router = new MaterialPageRoute(
                      //     builder: (BuildContext context) =>
                      //         new ItemInShop());
                      //
                      // Navigator.of(context).push(router);
                    },
                    child: new Container(
                        color: Colors.grey.shade200,
                        padding: EdgeInsets.all(15.0),
                        child: new Row(
                          children: <Widget>[
                            new Icon(
                              Icons.face_retouching_natural,
                              size: 40,
                              color: Colors.blue,
                            ),
                            new Text(
                              "\t\t\t Beauty & Personal Care",
                              style: new TextStyle(
                                  fontSize: 20.0, color: Colors.blue.shade800),
                            ),
                          ],
                        )),
                  ),
                  new Padding(padding: EdgeInsets.all(10)),
                  new InkWell(
                    onTap: () {
                      return debugPrint("Button pressed");

                      // var router = new MaterialPageRoute(
                      //     builder: (BuildContext context) =>
                      //         new ItemInShop());
                      //
                      // Navigator.of(context).push(router);
                    },
                    child: new Container(
                      color: Colors.grey.shade200,
                      padding: EdgeInsets.all(15.0),
                      child: new Row(
                        children: <Widget>[
                          new Icon(
                            Icons.local_florist,
                            size: 40,
                            color: Colors.blue,
                          ),
                          new Text(
                            "\t\t\t Arts & Crafts",
                            style: new TextStyle(
                                fontSize: 20.0, color: Colors.blue.shade800),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          bottomNavigationBar: new CustomNavBar(index: 0)),
    );
  }
}
