import 'package:flutter/material.dart';

import 'data.dart';

class AppTheme {
  static String appName = "Money";

  static Color darkPrimary = customPrimaryColor;
  static Color darkAccent = customSecondaryColor;
  static Color darkCursor = customButtonTextColor;

  static const String fontName = 'WorkSans';

  static ThemeData darkTheme = ThemeData(
      backgroundColor: darkPrimary,
      primaryColor: darkPrimary,
      accentColor: darkAccent,
      cursorColor: darkCursor,
      scaffoldBackgroundColor: darkPrimary,
      brightness: Brightness.dark,
      primaryColorBrightness: Brightness.dark,
      fontFamily: 'RobotoMono',
      buttonTheme: ButtonThemeData(
        buttonColor: darkAccent,
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        highlightColor: darkCursor,
        splashColor: darkCursor,
      ),
      chipTheme: ChipThemeData(
        elevation: 10.0,
        backgroundColor: customSecondaryColor,
        selectedColor: customButtonTextColor,
        labelPadding: EdgeInsets.all(5.0),
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        labelStyle: TextStyle(
          color: customButtonTextColor,
          fontSize: 16,
          fontWeight: FontWeight.bold
        ),
        secondarySelectedColor: customButtonTextColor,
        padding: EdgeInsets.all(5.0),
        secondaryLabelStyle: TextStyle(
          color: customWhite,
          fontSize: 16,
            fontWeight: FontWeight.bold

        ),
        disabledColor: customFieldColor,
        brightness: Brightness.dark,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          splashColor: darkCursor,
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          )),
      accentIconTheme: IconThemeData(color: customButtonTextColor),
      appBarTheme: AppBarTheme(
          color: customPrimaryColor,
          actionsIconTheme: IconThemeData(color: customButtonTextColor),
          iconTheme: IconThemeData(color: customButtonTextColor),
          textTheme: TextTheme(
            title: TextStyle(
              color: customButtonTextColor,
              fontSize: 21,
            ),
          )),
    iconTheme: IconThemeData(
      color:customButtonTextColor,
    ),
    dialogTheme: DialogTheme(
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
      elevation: 5.0,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      contentTextStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
    cardTheme: CardTheme(
      color: customPrimaryColor,
      elevation: 1.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
    )

  );
}
