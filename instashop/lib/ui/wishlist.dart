import 'package:flutter/material.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({Key? key}) : super(key: key);

  @override
  _WishlistPageState createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        bottomNavigationBar: new Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Color(0xff00eaff),
      ),
      child: new BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
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
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    ));
  }
}
