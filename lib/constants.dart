import 'package:flutter/material.dart';

import "package:flutter/material.dart";


AppBar emptyAppBar() {
  return AppBar(
    toolbarHeight: 0,
    elevation: 0,
    backgroundColor: Colors.white,
    //foregroundColor: Colors.white,
    shadowColor: Colors.white,
  );
}

class Constants {
  static Color accent = Color.fromRGBO(113, 177, 132, 1);
  static Color black = Color.fromRGBO(23, 23, 23, 1);
  static Color background = Color.fromRGBO(249, 249, 249, 1);


  //static MaterialColor main = MaterialColor(1,{1:Color.fromRGBO(113, 177, 132, 1)});

  get header => TextStyle(
    fontFamily: 'Montserrat',

        fontSize: 28,
        color: black,
        fontWeight: FontWeight.w800,
      );

  get subheader => TextStyle(
    fontFamily: 'Montserrat',
        fontSize: 17,
        color: black,
        fontWeight: FontWeight.w600,
      );

  get maintext => TextStyle(
    fontFamily: 'Montserrat',
        fontSize: 14,
        color: black,
        fontWeight: FontWeight.w500,
      );

  get buttontext => TextStyle(
    fontFamily: 'Montserrat',
        fontSize: 12,
        color: Colors.white,
        fontWeight: FontWeight.w400,
      );

  get accenttext => TextStyle(
    fontFamily: 'Montserrat',
        fontSize: 14,
        color: accent,
        fontWeight: FontWeight.w500,
      );

  get menu => TextStyle(
    fontFamily: 'Montserrat',
        fontSize: 10,
        color: Colors.grey,
        fontWeight: FontWeight.w400,
      );
  get menuaccent => TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 10,
    color: accent,
    fontWeight: FontWeight.w400,
  );
}
