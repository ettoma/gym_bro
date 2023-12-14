import 'package:flutter/material.dart';
import 'package:gym_bro/database/data_model.dart';
import 'package:gym_bro/database/database_utils.dart';
import 'package:gym_bro/global/text.dart';
import 'package:gym_bro/widgets/app_bar.dart';
import 'package:gym_bro/widgets/workout_tile.dart';

import '../global/colours.dart';
import 'workout_builder.dart';

class MyWorkouts extends StatefulWidget {
  const MyWorkouts({super.key});

  @override
  State<MyWorkouts> createState() => _MyWorkoutsState();
}

class _MyWorkoutsState extends State<MyWorkouts> {
  Future<List<WorkoutModel>> getWorkouts() async {
    return await DatabaseUtils().getAllWorkouts();
  }

  @override
  Widget build(BuildContext context) {
    Brightness brigthness = MediaQuery.of(context).platformBrightness;
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: NavBar(
        pageTitle: PageNames.myWorkouts,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder(
              future: getWorkouts(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return WorkoutTile(workout: snapshot.data![index]);
                        }),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: brigthness == Brightness.dark
              ? Colors.blueAccent
              : ColorPalette.lightBox,
          foregroundColor: brigthness == Brightness.dark
              ? ColorPalette.lightText
              : ColorPalette.darkText,
          elevation: 1,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const WorkoutBuilder()));
          }),
    );
  }
}
