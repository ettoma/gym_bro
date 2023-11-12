import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'global/colours.dart';
import 'views/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gym Bro',
      darkTheme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: ColorPalette.darkThemeBG,
        ),
        colorScheme: ColorScheme.fromSwatch(
          backgroundColor: ColorPalette.primaryYellowBG,
        ),
      ),
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: ColorPalette.primaryYellowBG,
        ),
        fontFamily: GoogleFonts.notoSansMono().fontFamily,
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}
