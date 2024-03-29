import 'package:flutter/material.dart';
import 'package:gym_bro/database/database_provider.dart';
import 'package:gym_bro/database/database_utils.dart';
import 'package:gym_bro/global/live_workout_provider.dart';
import 'package:gym_bro/global/text.dart';
import 'package:gym_bro/views/live_workout.dart';
import 'package:gym_bro/widgets/app_bar.dart';
import 'package:gym_bro/widgets/workout_dialog.dart';
import 'package:gym_bro/widgets/workout_tile.dart';
import 'package:provider/provider.dart';

import '../global/colours.dart';
import 'workout_builder.dart';

class MyWorkouts extends StatefulWidget {
  const MyWorkouts({super.key});

  @override
  State<MyWorkouts> createState() => _MyWorkoutsState();
}

class _MyWorkoutsState extends State<MyWorkouts> {
  @override
  Widget build(BuildContext context) {
    Brightness brigthness = MediaQuery.of(context).platformBrightness;
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: NavBar(
        pageTitle: PageNames.myWorkouts,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Consumer<DatabaseProvider>(
                builder: (context, databaseProvider, _) {
                  return Expanded(
                      child: ListView.builder(
                          itemCount: databaseProvider.workoutList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text(Titles.startWorkout),
                                        contentPadding:
                                            const EdgeInsets.all(20),
                                        titleTextStyle:
                                            const TextStyle(fontSize: 18),
                                        actions: [
                                          IconButton(
                                              icon: const Icon(Icons.clear),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              }),
                                          IconButton(
                                            onPressed: () {
                                              Provider.of<LiveWorkoutProvider>(
                                                      context,
                                                      listen: false)
                                                  .setWorkout(databaseProvider
                                                      .workoutList[index]);

                                              Navigator.of(context)
                                                  .pushReplacement(
                                                      MaterialPageRoute(
                                                          builder:
                                                              (context) =>
                                                                  LiveWorkout(
                                                                    workout: databaseProvider
                                                                            .workoutList[
                                                                        index],
                                                                    workoutExerciseListLength: databaseProvider
                                                                        .workoutList[
                                                                            index]
                                                                        .exercises
                                                                        .length,
                                                                  )));
                                            },
                                            icon: const Icon(
                                              Icons.check,
                                              color: Colors.tealAccent,
                                            ),
                                          )
                                        ],
                                      );
                                    });
                              },
                              onLongPress: () {
                                showDialog(
                                    barrierDismissible: true,
                                    context: context,
                                    builder: (context) {
                                      return WorkoutDialog(
                                        deviceSize: deviceSize,
                                        workout:
                                            databaseProvider.workoutList[index],
                                      );
                                    });
                              },
                              child: Dismissible(
                                key: UniqueKey(),
                                dismissThresholds: Map.from(
                                    {DismissDirection.endToStart: 0.3}),
                                direction: DismissDirection.endToStart,
                                confirmDismiss: (direction) async {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          titleTextStyle:
                                              const TextStyle(fontSize: 18),
                                          title:
                                              const Text(Titles.deleteWorkout),
                                          actions: [
                                            IconButton(
                                                icon: const Icon(
                                                  Icons.clear,
                                                  color: Colors.redAccent,
                                                ),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                }),
                                            IconButton(
                                              onPressed: () async {
                                                await DatabaseUtils()
                                                    .deleteWorkout(
                                                        databaseProvider
                                                                .workoutList[
                                                            index]);

                                                databaseProvider.deleteWorkout(
                                                    databaseProvider
                                                        .workoutList[index]);

                                                Navigator.of(context).pop();
                                              },
                                              icon: const Icon(
                                                Icons.check,
                                              ),
                                            )
                                          ],
                                        );
                                      });
                                  return;
                                },
                                background: stackBehindDismiss(),
                                child: WorkoutTile(
                                    workout:
                                        databaseProvider.workoutList[index]),
                              ),
                            );
                          }));
                },
              )
            ],
          ),
        ),
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
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => WorkoutBuilder()));
          }),
    );
  }
}

Widget stackBehindDismiss() {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Colors.redAccent,
    ),
    alignment: Alignment.centerRight,
    padding: const EdgeInsets.only(right: 20.0),
    child: const Icon(
      Icons.delete,
      color: Colors.white,
    ),
  );
}
