import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colours.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    bottomAppBarTheme: const BottomAppBarTheme(
      color: ColorPalette.lightBG,
    ),
    textTheme: textThemeBase,
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
            foregroundColor:
                MaterialStateColor.resolveWith((states) => Colors.black),
            textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.notoSansMono().fontFamily)))),
    appBarTheme: const AppBarTheme(
      backgroundColor: ColorPalette.lightBG,
    ),
    scaffoldBackgroundColor: ColorPalette.lightBG,
    fontFamily: GoogleFonts.notoSansMono().fontFamily,
    primaryColor: ColorPalette.lightText,
    useMaterial3: true,
  );

  ThemeData darkMode = ThemeData(
    bottomAppBarTheme: const BottomAppBarTheme(
      color: ColorPalette.darkBG,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: ColorPalette.darkBG,
    ),
    textTheme: textThemeBase,
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
            foregroundColor: MaterialStateColor.resolveWith(
                (states) => ColorPalette.darkText),
            textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(
                // color: ColorPalette.darkText,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.notoSansMono().fontFamily)))),
    brightness: Brightness.dark,
    scaffoldBackgroundColor: ColorPalette.darkBG,
    fontFamily: GoogleFonts.notoSansMono().fontFamily,
    primaryColor: ColorPalette.darkText,
    useMaterial3: true,
  );
}

TextTheme textThemeBase = const TextTheme(
  headlineMedium: TextStyle(fontSize: 40),
);
