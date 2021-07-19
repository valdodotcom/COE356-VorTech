import 'package:flutter/material.dart';

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
        backgroundColor: Color(0xff00eaff),
        title: new TextField(
        ),
        actions: <Widget>[
          new IconButton(
              onPressed: () => debugPrint("Search pressed"),
              icon: new Icon(Icons.search))
        ],
      ),
    );
  }
}
