import 'package:flutter/material.dart';
import 'package:instashop/ui/settings.dart';
import 'package:instashop/ui/shop_page.dart';
import 'package:instashop/ui/wishlist.dart';

class CustomNavBar extends StatefulWidget {
  final int index;

  const CustomNavBar({Key? key, required this.index}) : super(key: key);

  @override
  _CustomNavBarState createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  void _switchPage(int i) {
    setState(() {
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
          builder: (BuildContext context) => new SettingsPage());

      Navigator.of(context).push(router);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Color(0xff00eaff),
        ),
        child: new BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: widget.index,
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
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          onTap: _switchPage,
        ));
  }
}
