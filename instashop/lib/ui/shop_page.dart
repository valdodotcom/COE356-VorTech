import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:instashop/ui/my_account.dart';
import '../ui/wishlist.dart';
import '../ui/item_in_category.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: new Scaffold(
          appBar: new AppBar(
            leading: new Container(),
            backgroundColor: Color(0xff00eaff),
            title: new TextFormField(
              decoration: new InputDecoration(
                hintText: "Enter a vendor name",
              ),
            ),
            actions: <Widget>[
              new IconButton(
                  onPressed: () => debugPrint("Search pressed"),
                  icon: new Icon(Icons.search))
            ],
          ),
          body: new ListView(
            padding: EdgeInsets.all(15.0),
            children: <Widget>[
              new Column(
                children: <Widget>[
                  new InkWell(
                      onTap: () {
                        var router = new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                new ItemInCategory());

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
                      var router = new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new ItemInCategory());

                      Navigator.of(context).push(router);
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
                      var router = new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new ItemInCategory());

                      Navigator.of(context).push(router);
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
                      var router = new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new ItemInCategory());

                      Navigator.of(context).push(router);
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
                      var router = new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new ItemInCategory());

                      Navigator.of(context).push(router);
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
          bottomNavigationBar: new Theme(
            data: Theme.of(context).copyWith(
              canvasColor: Color(0xff00eaff),
            ),
            child: new BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: _index,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_bag),
                    label: 'Shop',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.bookmark_add),
                    label: 'Wishlist',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'My Account',
                  ),
                ],
                onTap: (int i) {
                  setState(() {
                    // _index = i;
                  });
                  if (i == 0) {
                    var router = new MaterialPageRoute(
                        builder: (BuildContext context) => new ShopPage());

                    Navigator.of(context).push(router);
                  }
                  if (i == 1) {
                    var router = new MaterialPageRoute(
                        builder: (BuildContext context) => new WishlistPage());

                    Navigator.of(context).push(router);
                  }
                  if (i == 2) {
                    var router = new MaterialPageRoute(
                        builder: (BuildContext context) => new MyAccount());

                    Navigator.of(context).push(router);
                  }
                }),
          )),
    );
  }
}





/*
•	Appliances
•	Food
•	Arts, Crafts and Sewing
•	Automotive Parts and accessories
•	Beauty and personal care
•	Books
•	CDs and Vinyl*
•	Cell Phones and Accessories
•	Clothing, shoes and Jewelry
•	Collectibles and Fine Art
•	Computers
•	Electronic gadgets
•	Garden and Outdoor*
•	Grocery
•	Handmade
•	Health and Household
•	Home and Kitchen
•	Industrial and scientific
•	Office Products
•	Pet Supplies
•	Sports and Outdoors

 */
