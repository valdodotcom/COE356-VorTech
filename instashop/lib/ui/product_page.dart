import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
// import '../ui/cart.dart';

// import '../ui/wishlist.dart';
// import '../ui/item_in_category.dart';
List _product = [];

void main() async {
  _product = await getProduct();
  print(_product[0]);

  for (int i = 0; i < _product.length; i++) {
    print(_product[i]['title']);
    print("Description: ${_product[i]['description']}");
  }

  runApp(new MaterialApp(
    title: 'ProdPage',
    home: ProductPage(),
  ));
}

class ProductPage extends StatelessWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Accra Thrift"),
          backgroundColor: Color(0xff00eaff),
        ),
        body: new Center(
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 400,
                  childAspectRatio: 2 / 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 20),
              itemCount: _product.length,
              padding: EdgeInsets.all(15),
              itemBuilder: (BuildContext ctx, int position) {
                 return Container(
                      alignment: Alignment.center,
                      child: Stack(
                        children: <Widget>[
                          new Center(
                              child: Image.network(
                                  '${_product[position]['image']}',
                                  fit: BoxFit.fill)),
                               new Container(
                                 color:Colors.black12,
                                child: new Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      '${_product[position]['title']}',
                                      style: new TextStyle(fontSize: 20),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text('Price: ${_product[position]['price']}',
                                      style: new TextStyle(fontSize: 20),),
                                    new Row(crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                      ElevatedButton(onPressed: ()=> debugPrint('pressed'), child: new Icon(Icons.shopping_cart_outlined)),
                                      Padding(padding: EdgeInsets.all(10)),
                                      ElevatedButton(onPressed: ()=> debugPrint('pressed'), child: new Icon(Icons.bookmark_add_outlined)),
                                    ],)
                                  ],
                                ),
                              ),
                        ],
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(15)),
                    );
              }),
        )

        );
  }
}

Future<List> getProduct() async {
  var apiUrl = Uri.parse('https://fakestoreapi.com/products/category/jewelery');

  http.Response response = await http.get(apiUrl);

  return json.decode(response.body);
}
