import 'package:flutter/material.dart';
import '../ui/shop_page.dart';
import '../ui/my_account.dart';
// import '../ui/wishlist.dart';
// import '../ui/item_in_category.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({Key? key}) : super(key: key);

  @override
  _WishlistPageState createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  int _index = 1;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          backgroundColor: Color(0xff00eaff),
          title: new Text("Wishlist"),
          // actions: <Widget>[
          //   new IconButton(
          //       onPressed: () => debugPrint("Search pressed"),
          //       icon: new Icon(Icons.search)),
          // ],
        ),

        bottomNavigationBar: new Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Color(0xff00eaff),
          ),
          child: new BottomNavigationBar (
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
                if (i == 0){
                  var router = new MaterialPageRoute(
                      builder: (BuildContext context) => new ShopPage());

                  Navigator.of(context).push(router);
                }
                if (i == 1){
                  var router = new MaterialPageRoute(
                      builder: (BuildContext context) => new WishlistPage());

                  Navigator.of(context).push(router);
                }
                if (i == 2){
                  var router = new MaterialPageRoute(
                      builder: (BuildContext context) => new MyAccount());

                  Navigator.of(context).push(router);
                }
              }),
        ));
  }
}
