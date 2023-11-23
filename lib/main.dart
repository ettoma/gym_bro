import 'package:flutter/material.dart';
import 'package:gym_bro/global/locale_provider.dart';
import 'package:provider/provider.dart';

import 'global/theme_provider.dart';
import 'views/home.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => ThemeProvider()),
    ChangeNotifierProvider(create: (context) => LocaleProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gym Bro',
      darkTheme: Provider.of<ThemeProvider>(context).darkMode,
      theme: Provider.of<ThemeProvider>(context).lightMode,
      home: const Home(),
    );
  }
}
