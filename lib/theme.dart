

import 'package:flutter/material.dart';

ThemeData lightTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    primaryColor: Colors.lightBlue,
    accentColor: Colors.lightBlue,
    primaryTextTheme: TextTheme(
      title: TextStyle(
        color: Colors.white,
        fontFamily: 'OpenSans'
      )
    ),
    primaryIconTheme: IconThemeData(
      color: Colors.lightGreen
    )
  );
}

ThemeData darkTheme() {
  final ThemeData base= ThemeData.dark();
  return base.copyWith(
    primaryColor: Colors.indigo,
    accentColor: Colors.indigo,
    primaryTextTheme: TextTheme(
      title: TextStyle(
        color: Colors.white,
        fontFamily: 'OpenSans'
      )
    ),
    primaryIconTheme: IconThemeData(
      color: Colors.indigo,
    ),
  );
}