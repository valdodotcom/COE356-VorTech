import 'package:flutter/material.dart';
import '../UI/home.dart';
import 'dart:async';



class SplashScreen extends StatefulWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
       super.initState();
       Timer(Duration(seconds: 5), () => new Home());
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget> [
          Container(
            decoration: BoxDecoration(color: Colors.blueAccent),
               ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget> [
                 Expanded(
                   flex: 2,
                   child: Container(
                     child: Column(
                      mainAxisAlignment:MainAxisAlignment.center,
                       children: <Widget> [
                         CircleAvatar(
                           backgroundColor: Colors.white,
                           radius: 50.0,
                           child: Icon(
                             Icons.shopping_cart_rounded,
                             color: Colors.blueAccent,
                             size: 50.0,
                                  ),
                                      ),
                          Padding(padding: EdgeInsets.only(top: 10.0),
                          ),   
                          Text(
                            "InstaShop", 
                            style: TextStyle(
                              color: Colors.white, 
                              fontSize: 25.0, 
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                              
                            ),
                          
                              
                        
                         ],
                       ),  
                    ) ,
                 ),
                            Expanded(flex: 1,
                               child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget> [
                                        CircularProgressIndicator(color: Colors.white),
                                        Padding(
                                            padding: EdgeInsets.only(top: 20.0),
                                        ),
                                        
                                    ],
                     ),
                 )
            ],
          )
        ],
      ),
      
    );
  }
}