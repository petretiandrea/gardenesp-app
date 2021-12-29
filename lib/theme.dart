import 'package:flutter/material.dart';

class GardenEspTheme {
  static ThemeData dark() {
    final baseTheme = ThemeData.dark();
    final customTextTheme = baseTheme.textTheme.copyWith(
      headline2: TextStyle(
        fontSize: 30,
        fontFamily: "Roboto",
        fontWeight: FontWeight.w900,
      ),
      bodyText1: TextStyle(
        fontSize: 16,
        fontFamily: "Roboto",
        fontWeight: FontWeight.w500,
      ),
      bodyText2: TextStyle(
        fontSize: 14,
        fontFamily: "Roboto",
        fontWeight: FontWeight.w300,
      ),
    );

    return baseTheme.copyWith(
      primaryColor: Colors.blue,
      textTheme: customTextTheme,
    );
  }
}
