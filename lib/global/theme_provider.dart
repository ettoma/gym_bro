import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colours.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    bottomAppBarTheme: const BottomAppBarTheme(
      color: ColorPalette.lightBG,
    ),
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
            textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(
                color: ColorPalette.lightText,
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
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
            textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(
                color: ColorPalette.darkText,
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
