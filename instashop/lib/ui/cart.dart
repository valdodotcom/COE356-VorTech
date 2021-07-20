import 'package:flutter/material.dart';
// import '../ui/wishlist.dart';
// import '../ui/item_in_category.dart';

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
    );
  }
}
