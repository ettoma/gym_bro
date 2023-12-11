import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gym_bro/database/database_utils.dart';
import 'package:gym_bro/widgets/app_bar.dart';

import '../database/data_model.dart';
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
      appBar: NavBar(
        implyLeading: false,
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        DatabaseUtils().insertWorkout(WorkoutModel(
          id: Random().nextInt(10000000),
          name: 'push day',
          exercises: [
            ExerciseModel(
              id: Random().nextInt(10000000),
              muscleGroup: 'chest',
              exercise: 'bench press',
              sets: [
                WorkoutSet(reps: 10, weight: 20.0, isDone: false),
                WorkoutSet(reps: 15, weight: 20.0, isDone: false),
              ],
            ),
            ExerciseModel(
              id: Random().nextInt(10000000),
              muscleGroup: 'back',
              exercise: 'lat pulldown',
              sets: [
                WorkoutSet(reps: 10, weight: 20.0, isDone: false),
                WorkoutSet(reps: 15, weight: 20.0, isDone: false),
              ],
            )
          ],
          isFavourite: false,
        ));
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
