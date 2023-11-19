import 'package:flutter/material.dart';
import 'package:gym_bro/widgets/app_bar.dart';

import '../global/text.dart';
import '../widgets/page_tile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> names = PageNames.names;
  SliverGridDelegate gridDelegate =
      const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1, mainAxisExtent: 120);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NavBar(),
      body: Center(
        child: GridView.builder(
            itemCount: 4,
            shrinkWrap: true,
            gridDelegate: gridDelegate,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: PageTile(
                  pageTitle: names[index],
                ),
              );
            }),
      ),
    );
  }
}
