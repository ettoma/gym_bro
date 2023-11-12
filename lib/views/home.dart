import 'package:flutter/material.dart';
import 'package:gym_bro/widgets/app_bar.dart';

import '../global/colours.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        // backgroundColor: ColorPalette.primaryYellowBG,
        appBar: NavBar(),
        body: Center(
          child: Text(
            'Home',
            style: TextStyle(fontSize: 50),
          ),
        ));
  }
}
