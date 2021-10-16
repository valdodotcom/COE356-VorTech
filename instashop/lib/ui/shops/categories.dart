import 'dart:io';
import 'package:flutter/material.dart';
import 'package:instashop/ui/shops/shop_in_category.dart';
import 'package:instashop/widgets/box_decoration.dart';
import 'package:instashop/widgets/custom_nav_bar.dart';
import '../util/cart.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
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
            title: new Text("instaShop"),

            actions: <Widget>[
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
                    fontSize: 20, color: Colors.blue.shade900,
                  )),),),

              new Column(
                children: <Widget>[
                  new InkWell(
                      onTap: () {
                        String _category = "Fashion & Clothing";
                        var router = new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                new ShopInCategory(name: _category));

                        Navigator.of(context).push(router);
                      },
                      child: new Container(
                        decoration: tempBoxDecoration(),
                        padding: EdgeInsets.all(15.0),
                        child: new Row(
                          children: <Widget>[
                            new Icon(
                              Icons.accessibility,
                              size: 40,
                              color: Colors.blue,
                            ),
                            new Text(
                              "    Fashion & Clothing",
                              style: tempStyle()
                            ),
                          ],
                        ),
                      )),
                  new Padding(padding: EdgeInsets.all(10)),
                  new InkWell(
                    onTap: () {
                      String _category = "Food";
                      var router = new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new ShopInCategory(name: _category));

                      Navigator.of(context).push(router);
                    },
                    child: new Container(
                        decoration: tempBoxDecoration(),
                        padding: EdgeInsets.all(15.0),
                        child: new Row(
                          children: <Widget>[
                            new Icon(
                              Icons.fastfood,
                              size: 40,
                              color: Colors.blue,
                            ),
                            new Text(
                              "    Food",
                              style: tempStyle()
                            ),
                          ],
                        )),
                  ),
                  new Padding(padding: EdgeInsets.all(10)),
                  new InkWell(
                    onTap: () {
                      String _category = "Tech & Gadgets";
                      var router = new MaterialPageRoute(
                          builder: (BuildContext context) =>
                          new ShopInCategory(name: _category));

                      Navigator.of(context).push(router);
                    },
                    child: new Container(
                        decoration: tempBoxDecoration(),

                        padding: EdgeInsets.all(15.0),
                        child: new Row(
                          children: <Widget>[
                            new Icon(
                              Icons.phonelink,
                              size: 40,
                              color: Colors.blue,
                            ),
                            new Text(
                              "    Tech & Gadgets",
                              style: tempStyle()
                            ),
                          ],
                        )),
                  ),
                  new Padding(padding: EdgeInsets.all(10)),
                  new InkWell(
                    onTap: () {
                      String _category = "Beauty & Personal Care";
                      var router = new MaterialPageRoute(
                          builder: (BuildContext context) =>
                          new ShopInCategory(name: _category));

                      Navigator.of(context).push(router);
                    },
                    child: new Container(
                        decoration: tempBoxDecoration(),

                        padding: EdgeInsets.all(15.0),
                        child: new Row(
                          children: <Widget>[
                            new Icon(
                              Icons.face_retouching_natural,
                              size: 40,
                              color: Colors.blue,
                            ),
                            new Text(
                              "    Beauty & Personal Care",
                              style: tempStyle()
                            ),
                          ],
                        )),
                  ),
                  new Padding(padding: EdgeInsets.all(10)),
                  new InkWell(
                    onTap: () {
                      String _category = "Arts & Crafts";
                      var router = new MaterialPageRoute(
                          builder: (BuildContext context) =>
                          new ShopInCategory(name: _category));

                      Navigator.of(context).push(router);
                    },
                    child: new Container(
                      decoration: tempBoxDecoration(),

                      padding: EdgeInsets.all(15.0),
                      child: new Row(
                        children: <Widget>[
                          new Icon(
                            Icons.local_florist,
                            size: 40,
                            color: Colors.blue,
                          ),
                          new Text(
                            "    Arts & Crafts",
                            style: tempStyle()
                          ),
                        ],
                      ),
                    ),
                  ),
                  new Padding(padding: EdgeInsets.all(10)),

                  new InkWell(
                    onTap: () {
                      String _category = "Other";
                      var router = new MaterialPageRoute(
                          builder: (BuildContext context) =>
                          new ShopInCategory(name: _category));

                      Navigator.of(context).push(router);
                    },
                    child: new Container(
                      decoration: tempBoxDecoration(),

                      padding: EdgeInsets.all(15.0),
                      child: new Row(
                        children: <Widget>[
                          new Icon(
                            Icons.add,
                            size: 40,
                            color: Colors.blue,
                          ),
                          new Text(
                            "    Other",
                            style: tempStyle(),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
          bottomNavigationBar: new CustomNavBar(index: 0)),
    );
  }
}

TextStyle tempStyle () {
  return new TextStyle(
    color: Colors.blue.shade800,
    fontSize: 20.0,
  );
}
