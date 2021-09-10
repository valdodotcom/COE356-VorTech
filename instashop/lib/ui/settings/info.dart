import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instashop/widgets/custom_nav_bar.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Color(0xff00eaff),
        title: new Text("Info"),
      ),
      body: new ListView(
        children: <Widget>[
          new Column(
            children: <Widget>[
              new Padding(padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0)),
              new Text(
              "About instaShop",
              style: new TextStyle(
                fontSize: 30.0,
                color: Colors.blue.shade900,
              ),
            ),
            new Container(
              padding: EdgeInsets.fromLTRB(25, 10, 15, 10),
              alignment: Alignment.topLeft,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "What is instaShop?",
                    style: new TextStyle(
                      fontSize: 20.0,
                      color: Colors.blue.shade900,
                    ),
                  ),
                  new Text(
                    "\n"
                        "Looking for an amazing deal on the latest iPhone coming out?\n\n"
                        "In need of a thrift store which has affordable and trendy clothes?\n\n"
                        "The days of mindlessly swiping through your feed "
                        "looking for these or anything in between are over!*\n\n"
                        "instaShop is a marketplace app that intends to serve "
                        "as your one-stop app for any small-scale business you'd normally "
                        "find on a social media platform such as Instagram or Twitter.\n\n"
                        "We've got you covered for anything you need ranging from clothes & "
                        "accessories, food, tech & gadgets, beauty & personal care, arts & "
                        "crafts and many more!",
                    style: new TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                  new Padding(padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0)),

                  Text(
                    "Why instaShop?",
                    style: new TextStyle(
                      fontSize: 20.0,
                      color: Colors.blue.shade900,

                    ),
                  ),
                  new Text(
                    "\n"
                        "\"Why shouldn't I just stick to the norm?\" you may ask?\n\n"
                        "Well, for starters, the stores are organised by category, making it"
                        "way easier to find a particular type of product you need.\n\n"
                        "Also, we have a wishlist feature which allows you to save stuff that "
                        "you are interested in but aren't ready to buy at the moment.\n\n"
                        "You can also keep track of the stuff you want to buy by adding them"
                        "to the cart, letting you know the total cost before checkout.\n\n"
                        "That's not all, by the way, we have a whole lot of exciting features"
                        " in development which we're very eager to share with you so stay tuned ;)\n"
                        " \n\n*This app is currently under development for a software "
                        "engineering undergraduate project.\nThe vendors and products you see here "
                        "do not exist, and are only for demonstrative purposes.  \n\n",
                    style: new TextStyle(
                      fontSize: 14.0,
                    ),
                  ),

                ],
              )
            ),

          ])
        ],
      ),
      bottomNavigationBar: new CustomNavBar(index: 2),
    );
  }
}
