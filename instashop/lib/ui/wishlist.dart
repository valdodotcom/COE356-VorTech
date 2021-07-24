import 'package:flutter/material.dart';
import 'package:instashop/widgets/customNavBar.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({Key? key}) : super(key: key);

  @override
  _WishlistPageState createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () async => false,
    child: new Scaffold(
        appBar: new AppBar(
          leading: new Container(),
          backgroundColor: Color(0xff00eaff),
          title: new Text("Wishlist"),
          // actions: <Widget>[
          //   new IconButton(
          //       onPressed: () => debugPrint("Search pressed"),
          //       icon: new Icon(Icons.search)),
          // ],
        ),

        bottomNavigationBar: new CustomNavBar(index: 1)),);
  }
}
