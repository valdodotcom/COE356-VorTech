import 'package:flutter/material.dart';
import 'package:instashop/widgets/customNavBar.dart';
import '../ui/item_in_category.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
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
                  icon: new Icon(Icons.search))
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
                                new ItemInShop());

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
