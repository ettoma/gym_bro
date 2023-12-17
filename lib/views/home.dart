import 'package:flutter/material.dart';
import 'package:gym_bro/database/database_provider.dart';
import 'package:gym_bro/database/database_utils.dart';
import 'package:gym_bro/widgets/app_bar.dart';
import 'package:provider/provider.dart';

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
  void initState() {
    DatabaseUtils().initialiseProviderDatabase(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar(
        implyLeading: false,
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Provider.of<DatabaseProvider>(context, listen: false)
            .deleteAllWorkouts();
        DatabaseUtils().deleteAllWorkouts();
      }),
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
