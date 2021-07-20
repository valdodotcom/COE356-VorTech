import 'package:flutter/material.dart';
import 'package:instashop/ui/my_account.dart';
import 'package:instashop/ui/shop_page.dart';
import 'package:instashop/ui/wishlist.dart';


class CustomNavBar extends StatefulWidget {
  const CustomNavBar({Key? key}) : super(key: key);

  @override
  _CustomNavBarState createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Theme(
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
    );
  }

}
