import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants.dart';








ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: "Muli",
    primarySwatch: MaterialColor(const Color(0xFF000000).value, const {
      50: Color(0xFFf2f2f2),
      100: Color(0xFFd9d9d9),
      200: Color(0xFFbfbfbf),
      300: Color(0xFFa6a6a6),
      400: Color(0xFF8c8c8c),
      500: Color(0xFF737373),
      600: Color(0xFF595959),
      700: Color(0xFF404040),
      800: Color(0xFF262626),
      900: Color(0xFF0d0d0d),
    }),
    appBarTheme: appBarTheme(),
    textTheme: textTheme(),
    inputDecorationTheme: inputDecorationTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(28),
    borderSide: const BorderSide(color: haTextColor),
    gapPadding: 10,
  );
  return InputDecorationTheme(
    floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: const EdgeInsets.symmetric(horizontal: 42, vertical: 20),
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
  );
}

TextTheme textTheme() {
  return const TextTheme(
    bodyText1: TextStyle(color: haTextColor),
    bodyText2: TextStyle(color: haTextColor),
  );
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
    color: haPrimaryColor,
    
    systemOverlayStyle: SystemUiOverlayStyle.light,
    iconTheme: IconThemeData(color: Colors.white),
    toolbarTextStyle: TextStyle(color: Colors.white, fontSize: 18),
  );
}
