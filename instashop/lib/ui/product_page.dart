import 'dart:convert';
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
        child: new ListView.builder(
            itemCount: _product.length,
            padding: const EdgeInsets.all(15.0),
            itemBuilder:(BuildContext context, int position){
              // if (position.isOdd) return new Divider();



                return new ListTile(
                  leading: new Image.network('${_product[position]['image']}',
                  width: 40.0,
                  height: 40.0,),
                  title: new Text('${_product[position]['title']}',
                  style: new TextStyle(fontSize: 18.0)),
                  subtitle: new Text('${_product[position]['description']}'),
                  onTap: ()=> debugPrint("${_product[position]['id']}"),

                );

            }),
      ),
    );
  }


}
Future<List> getProduct() async {
  var apiUrl = Uri.parse('https://fakestoreapi.com/products/category/jewelery');

  http.Response response = await http.get(apiUrl);

  return json.decode(response.body);
}