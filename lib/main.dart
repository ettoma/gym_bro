import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'global/theme_provider.dart';
import 'views/home.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => ThemeProvider(), child: const MyApp()));
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
