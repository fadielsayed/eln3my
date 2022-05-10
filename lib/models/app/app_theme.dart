import 'package:flutter/material.dart';

const primary = Color(0xff00577e);
// final secondary = Color(0xfff29a94);

const gradiantColors = [
  primary,
  Colors.redAccent,
  // Color(0xff0E3D51)
];

// 0xff1F3864
class ElNaamyAppTheme {
  static ThemeData get theme {
    // final themeData = ThemeData.light();
    // final textTheme = themeData.texptTheme;
    // final body1 = textTheme.body1.copyWith(decorationColor: Colors.transparent);

    return ThemeData.light().copyWith(
        // backgroundColor: Color(0xfff0f0f0),
        primaryColor: primary,
        accentColor: primary,
        buttonColor: primary,
        textSelectionColor: Color(0xff39556a),
        toggleableActiveColor: Color(0xff39556a),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color(0xff0E3D51),
        ),
        errorColor: Colors.red
        // snackBarTheme: SnackBarThemeData(
        //   backgroundColor: themeData.dialogBackgroundColor,
        //   contentTextStyle: body1,
        //   actionTextColor: Color(0xff39556a),
        // ),
        // textTheme: textTheme.copyWith(
        //   body1: body1,
        // ),
        );
  }
}
