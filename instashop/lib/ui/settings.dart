import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../ui/wishlist.dart';

// import '../ui/item_in_category.dart';
import '../ui/shop_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int _index = 2;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () async => false,
      child: new Scaffold(
          appBar: new AppBar(
            leading: new Container(),
            backgroundColor: Color(0xff00eaff),
            title: new Text("Settings"),
          ),

          // body: ,

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
                    icon: Icon(Icons.settings),
                    label: 'Settings',
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
                        builder: (BuildContext context) => new SettingsPage());

                    Navigator.of(context).push(router);
                  }
                }),
          )

      ),);

  }
}

onWillPop(context) async { SystemChannels.platform.invokeMethod('SystemNavigator.pop'); return false; }