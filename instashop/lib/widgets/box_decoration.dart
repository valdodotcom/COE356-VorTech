import 'package:flutter/material.dart';
BoxDecoration tempBoxDecoration () {
  return BoxDecoration(
      boxShadow: [BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 5,
        blurRadius: 7,
        offset: Offset(0, 3),
      )
      ],
      color: Colors.white70,
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: Colors.white12));

}